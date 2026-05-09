import 'package:get/get.dart';

class ApiProvider extends GetConnect {
  @override
  void onInit() {
    // === PILIH SALAH SATU URL DI BAWAH INI ===
    
    // 1. Opsi Ngrok (Gunakan ini agar tidak perlu ganti-ganti IP)
    // const String baseUrl = 'https://35e8-wjfs-aggf-ftde.ngrok-free.app'; 
    
    // 2. Opsi IP Lokal Laptop (IP yang sekarang: 192.168.1.7)
    const String baseUrl = 'http://192.168.1.7:5000'; 

    // 3. Opsi Emulator Android (Khusus jika pakai emulator bawaan Android Studio)
    // const String baseUrl = 'http://10.0.2.2:5000';

    // 4. Opsi Localhost (Khusus untuk Flutter Web / Chrome)
    // const String baseUrl = 'http://127.0.0.1:5000';

    httpClient.baseUrl = baseUrl;
    httpClient.timeout = const Duration(seconds: 15); 
    super.onInit();
  }

  // Register
  Future<Response> register(String name, String email, String password) {
    return post('/api/register', {
      'name': name,
      'email': email,
      'password': password,
    });
  }

  // Login
  Future<Response> login(String email, String password) {
    return post('/api/login', {
      'email': email,
      'password': password,
    });
  }

  // Get Profile
  Future<Response> getProfile(String token) {
    return get('/api/profile', headers: {
      'Authorization': 'Bearer $token',
    });
  }
}
