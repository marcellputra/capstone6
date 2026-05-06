import 'package:get/get.dart';

class ProfileController extends GetxController {
  var name = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var address = ''.obs;

  void updateProfile({
    required String name,
    required String email,
    required String phone,
    required String address,
  }) {
    this.name.value = name;
    this.email.value = email;
    this.phone.value = phone;
    this.address.value = address;
  }
}
