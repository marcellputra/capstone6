mkdir -p lib/core/{bindings,routes,theme,utils} \
lib/data/{models,services,local} \
lib/features/auth/{controller,view,binding} \
lib/features/onboarding/view \
lib/features/home/{controller,view} \
lib/features/symptom/{controller,view} \
lib/features/recommendation/{controller,view} \
lib/features/scan/{controller,view} \
lib/features/chatbot/{controller,view} \
lib/features/profile/{controller,view}

# Buat file kosong
touch lib/core/bindings/app_binding.dart \
lib/core/routes/app_routes.dart \
lib/core/theme/app_theme.dart \
lib/core/utils/helpers.dart \

lib/data/models/base_model.dart \
lib/data/services/api_service.dart \
lib/data/local/local_storage.dart \

lib/features/auth/controller/auth_controller.dart \
lib/features/auth/view/auth_view.dart \
lib/features/auth/binding/auth_binding.dart \

lib/features/onboarding/view/onboarding_view.dart \

lib/features/home/controller/home_controller.dart \
lib/features/home/view/home_view.dart \

lib/features/symptom/controller/symptom_controller.dart \
lib/features/symptom/view/symptom_view.dart \

lib/features/recommendation/controller/recommendation_controller.dart \
lib/features/recommendation/view/recommendation_view.dart \

lib/features/scan/controller/scan_controller.dart \
lib/features/scan/view/scan_view.dart \

lib/features/chatbot/controller/chatbot_controller.dart \
lib/features/chatbot/view/chatbot_view.dart \

lib/features/profile/controller/profile_controller.dart \
lib/features/profile/view/profile_view.dart