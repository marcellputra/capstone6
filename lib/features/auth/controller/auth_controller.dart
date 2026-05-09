import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/api/api_provider.dart';

class AuthController extends GetxController {
  ApiProvider get _apiProvider => Get.find<ApiProvider>();

  // Global auth state
  var isLogin = false.obs;
  var token = ''.obs;
  var userData = {}.obs;

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

  // Validation Errors
  var emailError = ''.obs;
  var passwordError = ''.obs;
  var confirmError = ''.obs;
  var nameError = ''.obs;

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

  bool validateEmail() {
    if (emailController.text.trim().isEmpty) {
      emailError.value = 'Email tidak boleh kosong';
      return false;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailController.text)) {
      emailError.value = 'Format email tidak valid';
      return false;
    } else {
      emailError.value = '';
      return true;
    }
  }

  bool validatePassword() {
    if (passwordController.text.isEmpty) {
      passwordError.value = 'Password tidak boleh kosong';
      return false;
    } else if (passwordController.text.length < 8) {
      passwordError.value = 'Password minimal 8 karakter';
      return false;
    } else {
      passwordError.value = '';
      return true;
    }
  }

  bool validateName() {
    if (nameController.text.trim().isEmpty) {
      nameError.value = 'Nama tidak boleh kosong';
      return false;
    } else if (nameController.text.trim().length < 3) {
      nameError.value = 'Nama minimal 3 karakter';
      return false;
    } else {
      nameError.value = '';
      return true;
    }
  }

  bool validateConfirmPassword() {
    if (confirmController.text.isEmpty) {
      confirmError.value = 'Konfirmasi password tidak boleh kosong';
      return false;
    } else if (confirmController.text != passwordController.text) {
      confirmError.value = 'Password tidak cocok';
      return false;
    } else {
      confirmError.value = '';
      return true;
    }
  }

  Future<void> login() async {
    if (!validateEmail() || !validatePassword()) {
      return;
    }
    isLoading.value = true;
    try {
      final response = await _apiProvider.login(
        emailController.text.trim(),
        passwordController.text,
      );

      if (response.status.isOk) {
        token.value = response.body['token'];
        userData.value = response.body['user'];
        isLogin.value = true;
        
        Get.offAllNamed(AppRoutes.home);
      } else {
        String message = response.body?['message'] ?? 'Login Gagal';
        Get.snackbar(
          'Login Gagal',
          message,
          backgroundColor: Colors.red.shade600,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Login Gagal',
        'Koneksi ke server bermasalah: $e',
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register() async {
    if (!validateName() || !validateEmail() || !validatePassword() || !validateConfirmPassword()) {
      return;
    }
    if (!agreedToTerms.value) {
      Get.snackbar(
        'Persetujuan Diperlukan',
        'Anda harus menyetujui Syarat & Ketentuan terlebih dahulu.',
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    isLoading.value = true;
    try {
      final response = await _apiProvider.register(
        nameController.text.trim(),
        emailController.text.trim(),
        passwordController.text,
      );

      if (response.status.isOk) {
        Get.back();
        Get.snackbar(
          'Berhasil! 🎉',
          'Akun Anda telah berhasil dibuat. Silakan masuk.',
          backgroundColor: Colors.green.shade600,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        String message = response.body?['message'] ?? 'Pendaftaran Gagal';
        Get.snackbar(
          'Pendaftaran Gagal',
          message,
          backgroundColor: Colors.red.shade600,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Pendaftaran Gagal',
        'Koneksi ke server bermasalah: $e',
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
   }

  void logout() {
    isLogin.value = false;
    token.value = '';
    userData.value = {};
    Get.offAllNamed(AppRoutes.login);
  }
}