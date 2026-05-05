import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/symptom_controller.dart';

// TAMBAH INI
import '../../recommendation/controller/recommendation_controller.dart';
import '../../recommendation/view/recommendation_view.dart';

class SymptomView extends StatelessWidget {
  const SymptomView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SymptomController());

    final symptomList = [
      "Demam",
      "Sakit Kepala",
      "Batuk",
      "Pilek",
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Pilih Gejala")),

      body: Column(
        children: [

          // 🔽 LIST GEJALA
          Expanded(
            child: Obx(() => ListView(
                  children: symptomList.map((s) {
                    return CheckboxListTile(
                      title: Text(s),
                      value: controller.symptoms.contains(s),
                      onChanged: (_) =>
                          controller.toggleSymptom(s),
                    );
                  }).toList(),
                )),
          ),

          // 🔽 TOMBOL DI BAWAH
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                final rec = Get.find<RecommendationController>();

                rec.generateRecommendation(controller.symptoms);

                Get.to(() => const RecommendationView());
              },
              child: const Text("Lihat Rekomendasi"),
            ),
          ),
        ],
      ),
    );
  }
}