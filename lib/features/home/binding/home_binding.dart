import 'package:get/get.dart';
import '../controller/home_controller.dart';
import '../../symptom/controller/symptom_controller.dart';
import '../../scan/controller/scan_controller.dart';
import '../../profile/controller/profile_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Home Tab
    Get.lazyPut<HomeController>(() => HomeController());

    // Symptom Tab
    Get.lazyPut<SymptomController>(() => SymptomController(), fenix: true);

    // Scan Tab
    Get.lazyPut<ScanController>(() => ScanController(), fenix: true);

    // Profile Tab
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
  }
}
