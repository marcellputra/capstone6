import 'package:get/get.dart';

class Message {
  final String content;
  final bool isUser;

  Message({required this.content, required this.isUser});
}

class ChatbotController extends GetxController {
  var messages = <Message>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Welcome message
    messages.add(
      Message(
        content:
            'Halo! Saya asisten kesehatan SmartFarmasi. Ada yang bisa saya bantu?',
        isUser: false,
      ),
    );
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    // Add user message
    messages.add(Message(content: text, isUser: true));

    // Simulate bot response
    Future.delayed(const Duration(milliseconds: 500), () {
      messages.add(
        Message(
          content: 'Terima kasih atas pertanyaannya. Mohon tunggu...',
          isUser: false,
        ),
      );
    });
  }

  void clearChat() {
    messages.clear();
    messages.add(
      Message(
        content:
            'Halo! Saya asisten kesehatan SmartFarmasi. Ada yang bisa saya bantu?',
        isUser: false,
      ),
    );
  }
}
