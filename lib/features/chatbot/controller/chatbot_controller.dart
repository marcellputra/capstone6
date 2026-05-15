import 'package:get/get.dart';

class Message {
  final String content;
  final bool isUser;

  Message({required this.content, required this.isUser});
}

class ChatbotController extends GetxController {
  var messages = <Message>[].obs;
  var isTyping = false.obs;

  @override
  void onInit() {
    super.onInit();
    _addWelcome();
  }

  void sendMessage(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty || isTyping.value) return;

    messages.add(Message(content: trimmed, isUser: true));
    isTyping.value = true;

    Future.delayed(const Duration(milliseconds: 650), () {
      isTyping.value = false;
      messages.add(Message(content: _responseFor(trimmed), isUser: false));
    });
  }

  void clearChat() {
    messages.clear();
    isTyping.value = false;
    _addWelcome();
  }

  void _addWelcome() {
    messages.add(
      Message(
        content:
            'Halo, saya asisten SmartFarmasi. Saya bisa bantu jelaskan gejala ringan, aturan pakai umum, dan kapan sebaiknya konsultasi.',
        isUser: false,
      ),
    );
  }

  String _responseFor(String text) {
    final lower = text.toLowerCase();
    if (lower.contains('demam') || lower.contains('suhu')) {
      return 'Untuk demam ringan, cukupkan cairan dan istirahat. Obat penurun panas seperti paracetamol dapat dipertimbangkan sesuai aturan pakai. Jika demam tinggi, lebih dari 3 hari, atau disertai sesak, segera konsultasi.';
    }
    if (lower.contains('batuk') || lower.contains('pilek')) {
      return 'Batuk dan pilek sering membaik dengan istirahat, cairan hangat, dan pemantauan gejala. Periksa label obat flu karena sebagian dapat menyebabkan kantuk atau tidak cocok untuk hipertensi.';
    }
    if (lower.contains('obat') || lower.contains('dosis')) {
      return 'Ikuti dosis pada kemasan atau anjuran tenaga kesehatan. Hindari menggandakan dosis dan cek kandungan obat agar tidak minum bahan aktif yang sama dari dua produk berbeda.';
    }
    return 'Saya bantu arahkan secara umum, bukan menggantikan konsultasi medis. Ceritakan gejala utama, durasi keluhan, dan obat yang sedang digunakan agar sarannya lebih relevan.';
  }
}
