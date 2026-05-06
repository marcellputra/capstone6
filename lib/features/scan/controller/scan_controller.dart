import 'package:get/get.dart';

class ScanController extends GetxController {
  var isScanning = false.obs;
  var scannedResult = ''.obs;

  void scanBarcode() {
    isScanning.value = true;
    // Simulate scanning
    Future.delayed(const Duration(seconds: 2), () {
      scannedResult.value = 'OBAT-001';
      isScanning.value = false;
      Get.snackbar('Berhasil', 'Obat terdeteksi: $scannedResult');
    });
  }

  void stopScanning() {
    isScanning.value = false;
  }
}
