import 'package:get/get.dart';

// Auth
import '../../features/auth/controller/auth_controller.dart';
import '../api/api_provider.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // ✅ API Provider
    Get.put(ApiProvider(), permanent: true);

    // ✅ Auth Controller - global state
    Get.lazyPut<AuthController>(
      () => AuthController(),
      fenix: true,
    );
  }
}