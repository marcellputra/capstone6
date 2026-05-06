import 'package:get/get.dart';

import '../../features/auth/view/login_view.dart';
import '../../features/auth/view/register_view.dart';
import '../../features/auth/binding/auth_binding.dart';
import '../../features/home/view/main_navigation_view.dart';
import '../../features/home/binding/home_binding.dart';
import '../../features/onboarding/view/onboarding_view.dart';
import '../../features/onboarding/view/splash_view.dart';
import '../../features/onboarding/binding/onboarding_binding.dart';
import '../../features/symptom/view/symptom_view.dart';
import '../../features/symptom/binding/symptom_binding.dart';
import '../../features/recommendation/view/recommendation_view.dart';
import '../../features/recommendation/binding/recommendation_binding.dart';
import '../../features/scan/view/scan_view.dart';
import '../../features/scan/binding/scan_binding.dart';
import '../../features/chatbot/view/chatbot_view.dart';
import '../../features/chatbot/binding/chatbot_binding.dart';
import '../../features/profile/view/profile_view.dart';
import '../../features/profile/binding/profile_binding.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    // Splash - without binding (just display)
    GetPage(name: AppRoutes.SPLASH, page: () => const SplashView()),

    // Auth - dengan binding
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.REGISTER,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),

    // Onboarding - tanpa binding
    GetPage(
      name: AppRoutes.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),

    // Home - Main Navigation dengan binding
    GetPage(
      name: AppRoutes.HOME,
      page: () => const MainNavigationView(),
      binding: HomeBinding(),
    ),

    // Symptom - dengan binding
    GetPage(
      name: AppRoutes.SYMPTOM,
      page: () => const SymptomView(),
      binding: SymptomBinding(),
    ),

    // Recommendation - dengan binding
    GetPage(
      name: AppRoutes.RECOMMENDATION,
      page: () => const RecommendationView(),
      binding: RecommendationBinding(),
    ),

    // Scan - dengan binding
    GetPage(
      name: AppRoutes.SCAN,
      page: () => const ScanView(),
      binding: ScanBinding(),
    ),

    // Chatbot - dengan binding
    GetPage(
      name: AppRoutes.CHATBOT,
      page: () => const ChatbotView(),
      binding: ChatbotBinding(),
    ),

    // Profile - dengan binding
    GetPage(
      name: AppRoutes.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
