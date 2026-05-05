import 'package:flutter/material.dart';
import 'home_view.dart';
import '../../symptom/view/symptom_view.dart';

class MainNavigationView extends StatefulWidget {
  const MainNavigationView({super.key});

  @override
  State<MainNavigationView> createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends State<MainNavigationView> {
  int currentIndex = 0;

  final screens = [
    const HomeView(),
    const SymptomView(),
    const Center(child: Text("Scan View")),
    const Center(child: Text("Profile View")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: Container(
        height: 70,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              color: Colors.black.withOpacity(0.08),
            ),
          ],
        ),

        /// 🔥 FIX UTAMA PAKAI LAYOUTBUILDER (BIAR PRESISI)
        child: LayoutBuilder(
          builder: (context, constraints) {
            double itemWidth = constraints.maxWidth / 4;

            return Stack(
              children: [

                /// 🔥 INDICATOR (GESER SESUAI INDEX)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  left: itemWidth * currentIndex,
                  child: Container(
                    width: itemWidth,
                    height: 50,
                    alignment: Alignment.center,
                    child: Container(
                      width: 70,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF40627B),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),

                /// 🔥 MENU ITEMS
                Row(
                  children: [
                    _navItem(Icons.home, "Home", 0),
                    _navItem(Icons.healing, "Gejala", 1),
                    _navItem(Icons.qr_code_scanner, "Scan", 2),
                    _navItem(Icons.person, "Profile", 3),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// 🔥 NAV ITEM
  Widget _navItem(IconData icon, String label, int index) {
    final isActive = currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentIndex = index;
          });
        },
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              /// ICON ANIMASI
              AnimatedScale(
                duration: const Duration(milliseconds: 300),
                scale: isActive ? 1.2 : 1.0,
                child: Icon(
                  icon,
                  color: isActive ? Colors.white : Colors.grey,
                ),
              ),

              /// TEXT ANIMASI
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isActive ? 1 : 0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}