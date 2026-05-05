import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/routes/app_routes.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Onboarding"),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.LOGIN);
              },
              child: const Text("Login"),
            ),

            TextButton(
              onPressed: () {
                Get.offAllNamed(AppRoutes.HOME);
              },
              child: const Text("Lewati untuk Sekarang"),
            ),
          ],
        ),
      ),
    );
  }
}
