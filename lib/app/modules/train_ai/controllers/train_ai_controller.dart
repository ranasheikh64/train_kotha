import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum MessageSender { ai, user }

class ChatMessage {
  final String text;
  final MessageSender sender;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.sender,
    required this.timestamp,
  });
}

class TrainAIController extends GetxController {
  final messages = <ChatMessage>[].obs;
  final isTyping = false.obs;
  final textController = TextEditingController();
  final scrollController = ScrollController();

  final initialQuestions = [
    'Tell me the route of Egarosindhur Probhati.',
    'How can I earn coins by sharing location?',
    'What is the current status of Suborno Express?',
    'How do I track my train live?',
  ];

  @override
  void onInit() {
    super.onInit();
    // Start with a welcoming message
    _addAiMessage('Hello, I am Rail AI. Tell me how can I assist you today?');
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    messages.add(ChatMessage(
      text: text,
      sender: MessageSender.user,
      timestamp: DateTime.now(),
    ));
    textController.clear();
    _scrollToBottom();

    _simulateAiResponse(text);
  }

  void selectInitialQuestion(String question) {
    sendMessage(question);
  }

  void _simulateAiResponse(String userQuery) {
    isTyping.value = true;
    
    // Simulate thinking time
    Future.delayed(const Duration(seconds: 1), () {
      String response = '';
      final query = userQuery.toLowerCase();

      if (query.contains('egarosindhur')) {
        response = 'Egarosindhur Probhati travels from Dhaka to Kishoreganj. It stops at Airport, Joydebpur, Tongi, and Bhairab Bazar.';
      } else if (query.contains('coin')) {
        response = 'You can earn 5 coins every time you share your train location while traveling. This helps other passengers track the train!';
      } else if (query.contains('track')) {
        response = 'To track a train, go to the "Track" tab, select your train and station, and click "Track Live Now".';
      } else {
        response = 'I am here to help you with train schedules, routes, and live tracking info. What else would you like to know?';
      }

      _addAiMessage(response);
      isTyping.value = false;
      _scrollToBottom();
    });
  }

  void _addAiMessage(String text) {
    messages.add(ChatMessage(
      text: text,
      sender: MessageSender.ai,
      timestamp: DateTime.now(),
    ));
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void clearChat() {
    messages.clear();
  }

  void startNewChat() {
    messages.clear();
    _addAiMessage('Hello, I am Rail AI. Tell me how can I assist you today?');
  }

  @override
  void onClose() {
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
