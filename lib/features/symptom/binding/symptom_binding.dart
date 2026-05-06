import 'package:get/get.dart';
import '../controller/symptom_controller.dart';

class SymptomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SymptomController>(() => SymptomController());
  }
}
