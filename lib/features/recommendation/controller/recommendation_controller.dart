import 'package:get/get.dart';

class RecommendationController extends GetxController {
  var results = <Map<String, dynamic>>[].obs;

  void generateRecommendation(List<String> symptoms) {
    results.clear();

    final rules = [
      {
        "name": "Paracetamol",
        "symptoms": ["Demam", "Sakit Kepala"],
        "desc": "Meredakan demam dan nyeri",
        "side_effect": "Mual (jarang)",
        "warning": "Hindari jika gangguan hati",
      },
      {
        "name": "OBH Combi",
        "symptoms": ["Batuk"],
        "desc": "Meredakan batuk",
        "side_effect": "Mengantuk",
        "warning": "Hindari saat mengemudi",
      },
      {
        "name": "Decolgen",
        "symptoms": ["Pilek", "Demam"],
        "desc": "Meredakan flu dan pilek",
        "side_effect": "Mengantuk",
        "warning": "Tidak untuk hipertensi",
      },
    ];

    for (var rule in rules) {
      int matchCount = 0;

      for (var s in rule["symptoms"] as List<String>) {
        if (symptoms.contains(s)) {
          matchCount++;
        }
      }

      if (matchCount > 0) {
        final score =
            matchCount / (rule["symptoms"] as List).length;

        results.add({
          "name": rule["name"],
          "desc": rule["desc"],
          "side_effect": rule["side_effect"],
          "warning": rule["warning"],
          "score": score,
          "matched": matchCount,
        });
      }
    }

    // 🔥 SORT DARI YANG PALING COCOK
    results.sort((a, b) =>
        (b["score"] as double).compareTo(a["score"] as double));
  }
}