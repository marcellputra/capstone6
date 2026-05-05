import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.menu, color: Color(0xFF40627B)),
                  const Text(
                    "SmartFarmasi",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF40627B),
                    ),
                  ),
                  const CircleAvatar(
                    backgroundColor: Color(0xFFBBDEFB),
                    child: Icon(Icons.person, color: Color(0xFF40627B)),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// GREETING
              const Text(
                "Halo, User 👋",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF40627B),
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Bagaimana kesehatanmu hari ini?",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 20),

              /// SEARCH
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.search),
                    hintText: "Cari obat atau gejala",
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// CARD ANALISIS
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFBBDEFB), Color(0xFFC9E7CA)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Cek Gejala Sekarang",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Get.toNamed('/symptom');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF40627B),
                          ),
                          child: const Text("Mulai Analisis"),
                        ),
                      ],
                    ),
                    const Icon(Icons.health_and_safety, size: 40),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// MENU
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [

                    /// SCAN
                    _menuCard(
                      icon: Icons.document_scanner,
                      title: "Scan Obat",
                    ),

                    /// CHAT
                    _menuCard(
                      icon: Icons.smart_toy,
                      title: "Chat AI",
                    ),

                    /// HISTORY
                    _menuCard(
                      icon: Icons.history,
                      title: "Riwayat",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuCard({required IconData icon, required String title}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: const Color(0xFF40627B)),
          const SizedBox(height: 10),
          Text(title),
        ],
      ),
    );
  }
}