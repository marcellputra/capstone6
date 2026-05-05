import 'package:get/get.dart';

// Auth
import '../../features/auth/controller/auth_controller.dart';

// Recommendation
import '../../features/recommendation/controller/recommendation_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {

    // ✅ Auth Controller
    Get.lazyPut<AuthController>(
      () => AuthController(),
      fenix: true,
    );

    // ✅ Recommendation Controller (INI YANG KAMU TAMBAH)
    Get.lazyPut<RecommendationController>(
      () => RecommendationController(),
      fenix: true,
    );
  }
}