import 'package:get/get.dart';

import '../../features/auth/view/login_view.dart';
import '../../features/home/view/main_navigation_view.dart'; // 🔥 INI
import '../../features/onboarding/view/onboarding_view.dart';
import '../../features/onboarding/view/splash_view.dart';
import '../../features/symptom/view/symptom_view.dart';

import 'package:smart_farmasi1/core/routes/app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.SPLASH, page: () => const SplashView()),
    GetPage(name: AppRoutes.LOGIN, page: () => const LoginView()),
    GetPage(name: AppRoutes.ONBOARDING, page: () => const OnboardingView()),
    GetPage(name: AppRoutes.HOME, page: () => const MainNavigationView()),
    GetPage(name: '/symptom', page: () => const SymptomView()),
  ];
}
