import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/recommendation_controller.dart';

class RecommendationView extends StatelessWidget {
  const RecommendationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RecommendationController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Rekomendasi Obat")),
      body: Obx(() {
        if (controller.results.isEmpty) {
          return const Center(
            child: Text("Tidak ada rekomendasi"),
          );
        }

        return ListView.builder(
          itemCount: controller.results.length,
          itemBuilder: (context, index) {
            final item = controller.results[index];

            return Card(
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      item["name"],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),
                    Text(item["desc"]),

                    const SizedBox(height: 6),
                    Text(
                        "Kecocokan: ${(item["score"] * 100).toStringAsFixed(0)}%"),

                    const SizedBox(height: 6),
                    Text("Efek samping: ${item["side_effect"]}"),

                    const SizedBox(height: 6),
                    Text(
                      "⚠ ${item["warning"]}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}