import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/routes/app_routes.dart';

class AuthController extends GetxController {
  // Global auth state
  var isLogin = false.obs;

  // Form Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final confirmController = TextEditingController();

  // Form States
  var obscurePassword = true.obs;
  var obscureConfirm = true.obs;
  var isLoading = false.obs;
  var agreedToTerms = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() => obscurePassword.value = !obscurePassword.value;
  void toggleConfirmVisibility() => obscureConfirm.value = !obscureConfirm.value;
  void toggleTermsAgreement() => agreedToTerms.value = !agreedToTerms.value;

  Future<void> login() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1500));
    isLoading.value = false;
    isLogin.value = true;
    Get.offAllNamed(AppRoutes.HOME);
  }

  Future<void> register() async {
    if (!agreedToTerms.value) {
      Get.snackbar(
        'Persetujuan Diperlukan',
        'Anda harus menyetujui Syarat & Ketentuan terlebih dahulu.',
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 16,
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.info_outline, color: Colors.white),
      );
      return;
    }
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1500));
    isLoading.value = false;
    Get.back();
    Get.snackbar(
      'Berhasil! 🎉',
      'Akun Anda telah berhasil dibuat. Silakan masuk.',
      backgroundColor: Colors.green.shade600,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void logout() {
    isLogin.value = false;
  }
}