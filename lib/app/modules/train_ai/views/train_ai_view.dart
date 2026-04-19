import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:train_kotai/app/modules/train_ai/controllers/train_ai_controller.dart';

class TrainAIView extends GetView<TrainAIController> {
  const TrainAIView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => controller.messages.isEmpty
                ? _buildInitialQuestions()
                : _buildChatList()),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
        onPressed: () => Get.back(),
      ),
      title: Column(
        children: [
          Text(
            'Rail AI',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8.w,
                height: 8.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF2C9E6A),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                'Online',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'clear') controller.clearChat();
            if (value == 'new') controller.startNewChat();
          },
          icon: Container(
            margin: EdgeInsets.only(right: 16.w),
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.more_horiz, color: Colors.black),
          ),
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'new', child: Text('Start New Chat')),
            const PopupMenuItem(value: 'clear', child: Text('Clear All Chat', style: TextStyle(color: Colors.red))),
          ],
        ),
      ],
    );
  }

  Widget _buildInitialQuestions() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40.h),
          Image.asset('assets/aiImage.png', height: 120.h),
          SizedBox(height: 24.h),
          Text(
            'How can I help you today?',
            style: GoogleFonts.inter(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 24.h),
          Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            alignment: WrapAlignment.center,
            children: controller.initialQuestions.map((q) => _buildQuestionChip(q)).toList(),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildQuestionChip(String question) {
    return InkWell(
      onTap: () => controller.selectInitialQuestion(question),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          question,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(fontSize: 13.sp, color: Colors.black87),
        ),
      ),
    );
  }

  Widget _buildChatList() {
    return ListView.builder(
      controller: controller.scrollController,
      padding: EdgeInsets.all(20.w),
      itemCount: controller.messages.length + (controller.isTyping.value ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == controller.messages.length) {
          return _buildTypingIndicator();
        }
        
        final msg = controller.messages[index];
        final isAi = msg.sender == MessageSender.ai;

        return Column(
          children: [
            if (index == 0) _buildDateDivider('Today'),
            _buildMessageBubble(msg, isAi),
          ],
        );
      },
    );
  }

  Widget _buildDateDivider(String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.h),
      child: Row(
        children: [
          Expanded(child: Divider(color: Colors.grey.shade300)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              text,
              style: GoogleFonts.inter(fontSize: 12.sp, color: Colors.grey),
            ),
          ),
          Expanded(child: Divider(color: Colors.grey.shade300)),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage msg, bool isAi) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        mainAxisAlignment: isAi ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isAi) _buildAvatar('assets/aiImage.png'),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: isAi ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: 0.7.sw),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  gradient: isAi
                      ? const LinearGradient(
                          colors: [Color(0xFF1E5631), Color(0xFF2C9E6A)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: isAi ? null : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                    bottomLeft: Radius.circular(isAi ? 0 : 20.r),
                    bottomRight: Radius.circular(isAi ? 20.r : 0),
                  ),
                  boxShadow: [
                    if (!isAi)
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                  ],
                ),
                child: Text(
                  msg.text,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: isAi ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                DateFormat('hh:mm a').format(msg.timestamp),
                style: GoogleFonts.inter(fontSize: 10.sp, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(width: 8.w),
          if (!isAi) _buildAvatar(null, isUser: true),
        ],
      ),
    );
  }

  Widget _buildAvatar(String? asset, {bool isUser = false}) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: isUser ? Colors.grey.shade200 : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: isUser
          ? Icon(Icons.person, color: Colors.grey.shade400, size: 24.sp)
          : ClipOval(child: Image.asset(asset!, fit: BoxFit.cover)),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        children: [
          _buildAvatar('assets/aiImage.png'),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              'Rail AI is typing...',
              style: GoogleFonts.inter(fontSize: 12.sp, color: Colors.grey.shade600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: TextField(
                  controller: controller.textController,
                  decoration: InputDecoration(
                    hintText: 'Type your message...',
                    hintStyle: GoogleFonts.inter(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (val) => controller.sendMessage(val),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            InkWell(
              onTap: () => controller.sendMessage(controller.textController.text),
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: const BoxDecoration(
                  color: Color(0xFF2C9E6A),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
