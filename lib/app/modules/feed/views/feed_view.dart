import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:train_kotai/app/data/models/post_model.dart';
import 'package:train_kotai/app/modules/feed/controllers/feed_controller.dart';
import 'package:train_kotai/app/routes/app_pages.dart';

class FeedView extends GetView<FeedController> {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Connect with Travelers',
          style: GoogleFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: Obx(() => ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            itemCount: controller.posts.length,
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final post = controller.posts[index];
              return _buildPostCard(post);
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADD_POST),
        backgroundColor: const Color(0xFF2C9E6A),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  Widget _buildPostCard(Post post) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200, width: 1),
          bottom: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Header
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: const Color(0xFFE8F5E9),
                  backgroundImage: post.userAvatar != null ? NetworkImage(post.userAvatar!) : null,
                  child: post.userAvatar == null ? Icon(Icons.person, color: Colors.grey.shade400) : null,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.userName,
                        style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        post.time,
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz, color: Colors.black54),
                ),
              ],
            ),
          ),

          // Content with left accent
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    width: 3.w,
                    margin: EdgeInsets.only(right: 12.w),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      post.content,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Post Image
          if (post.imageUrl != null || post.localImage != null)
            Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: post.localImage != null
                  ? Image.file(post.localImage!, width: 1.sw, height: 250.h, fit: BoxFit.cover)
                  : Image.network(post.imageUrl!, width: 1.sw, height: 250.h, fit: BoxFit.cover),
            ),

          // Stats
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: const BoxDecoration(
                    color: Color(0xFF2C9E6A),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.thumb_up, color: Colors.white, size: 10.sp),
                ),
                SizedBox(width: 8.w),
                Text(
                  '${post.likes}',
                  style: GoogleFonts.inter(fontSize: 12.sp, color: Colors.grey.shade600),
                ),
                const Spacer(),
                Text(
                  '${post.comments} comments',
                  style: GoogleFonts.inter(fontSize: 12.sp, color: Colors.grey.shade600),
                ),
                SizedBox(width: 12.w),
                Text(
                  '${post.shares} shares',
                  style: GoogleFonts.inter(fontSize: 12.sp, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Action Buttons
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionBtn(
                  icon: post.isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                  label: 'Like',
                  color: post.isLiked ? const Color(0xFF2C9E6A) : Colors.black54,
                  onTap: () => controller.likePost(post.id),
                ),
                _buildActionBtn(icon: Icons.chat_bubble_outline, label: 'Comment', onTap: () {}),
                _buildActionBtn(icon: Icons.share_outlined, label: 'Share', onTap: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
    Color color = Colors.black54,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            Icon(icon, size: 18.sp, color: color),
            SizedBox(width: 8.w),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
