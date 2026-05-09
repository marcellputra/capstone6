import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../controller/symptom_controller.dart';
import '../../recommendation/controller/recommendation_controller.dart';
import '../../recommendation/view/recommendation_view.dart';

class SymptomView extends StatefulWidget {
  const SymptomView({super.key});

  @override
  State<SymptomView> createState() => _SymptomViewState();
}

class _SymptomViewState extends State<SymptomView> with TickerProviderStateMixin {
  late AnimationController _headerController;
  late Animation<double> _headerOpacity;

  final _searchController = TextEditingController();
  List<_SymptomItem> _filteredSymptoms = [];

  final List<_SymptomItem> _allSymptoms = [
    _SymptomItem(name: 'Demam', emoji: '🌡️', category: 'Umum'),
    _SymptomItem(name: 'Sakit Kepala', emoji: '🤕', category: 'Umum'),
    _SymptomItem(name: 'Batuk', emoji: '😮‍💨', category: 'Pernafasan'),
    _SymptomItem(name: 'Pilek', emoji: '🤧', category: 'Pernafasan'),
    _SymptomItem(name: 'Sakit Tenggorokan', emoji: '🔴', category: 'Pernafasan'),
    _SymptomItem(name: 'Sesak Napas', emoji: '😤', category: 'Pernafasan'),
    _SymptomItem(name: 'Nyeri Otot', emoji: '💪', category: 'Fisik'),
    _SymptomItem(name: 'Kelelahan', emoji: '😴', category: 'Umum'),
    _SymptomItem(name: 'Mual', emoji: '🤢', category: 'Pencernaan'),
    _SymptomItem(name: 'Diare', emoji: '🚽', category: 'Pencernaan'),
    _SymptomItem(name: 'Sakit Perut', emoji: '🫃', category: 'Pencernaan'),
    _SymptomItem(name: 'Pusing', emoji: '😵', category: 'Umum'),
    _SymptomItem(name: 'Alergi Kulit', emoji: '🔺', category: 'Kulit'),
    _SymptomItem(name: 'Gatal-gatal', emoji: '🔸', category: 'Kulit'),
    _SymptomItem(name: 'Nyeri Sendi', emoji: '🦵', category: 'Fisik'),
    _SymptomItem(name: 'Menggigil', emoji: '🥶', category: 'Umum'),
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    _filteredSymptoms = List.from(_allSymptoms);

    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _headerOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeOut),
    );
    _headerController.forward();

    _searchController.addListener(_filterSymptoms);
  }

  void _filterSymptoms() {
    final q = _searchController.text.toLowerCase();
    setState(() {
      _filteredSymptoms = _allSymptoms
          .where((s) => s.name.toLowerCase().contains(q))
          .toList();
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SymptomController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // ─── HEADER ───
          FadeTransition(
            opacity: _headerOpacity,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.surface,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // AppBar row
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceVariant,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 18,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Cek Kesehatan',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Obx(() => Text(
                                    '${controller.symptoms.length} gejala dipilih',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      color: controller.symptoms.isEmpty
                                          ? AppColors.textTertiary
                                          : AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Search
                      TextField(
                        controller: _searchController,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Cari gejala...',
                          prefixIcon:
                              const Icon(Icons.search_rounded, size: 20),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    _searchController.clear();
                                    _filterSymptoms();
                                  },
                                  child: const Icon(Icons.clear_rounded,
                                      size: 18),
                                )
                              : null,
                          filled: true,
                          fillColor: AppColors.surfaceVariant,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ─── SYMPTOM GRID ───
          Expanded(
            child: Obx(() {
              final selectedSymptoms = controller.symptoms.toList();
              return _filteredSymptoms.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.search_off_rounded,
                              size: 64, color: AppColors.textTertiary),
                          const SizedBox(height: 12),
                          Text(
                            'Gejala tidak ditemukan',
                            style: GoogleFonts.plusJakartaSans(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1.6,
                      ),
                      itemCount: _filteredSymptoms.length,
                      itemBuilder: (context, index) {
                        final s = _filteredSymptoms[index];
                        final isSelected = selectedSymptoms.contains(s.name);
                        return _SymptomCard(
                          symptom: s,
                          isSelected: isSelected,
                          onTap: () {
                            HapticFeedback.selectionClick();
                            controller.toggleSymptom(s.name);
                          },
                        );
                      },
                    );
            }),
          ),
        ],
      ),

      // ─── FLOATING ACTION BUTTON ───
      bottomNavigationBar: Obx(() {
        final count = controller.symptoms.length;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutCubic,
          height: count > 0 ? 100 : 0,
          child: count > 0
              ? Container(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 20,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      final rec = Get.find<RecommendationController>();
                      rec.generateRecommendation(controller.symptoms.toList());
                      Get.to(
                        () => const RecommendationView(),
                        transition: Transition.upToDown,
                        duration: const Duration(milliseconds: 400),
                      );
                    },
                    child: Container(
                      height: 54,
                      decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: AppTheme.buttonShadow,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.auto_awesome_rounded,
                              color: Colors.white, size: 18),
                          const SizedBox(width: 10),
                          Text(
                            'Analisis $count Gejala',
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        );
      }),
    );
  }
}

class _SymptomCard extends StatelessWidget {
  final _SymptomItem symptom;
  final bool isSelected;
  final VoidCallback onTap;

  const _SymptomCard({
    required this.symptom,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : const Color(0xFFE5E7EB),
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : AppTheme.softShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(symptom.emoji, style: const TextStyle(fontSize: 24)),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? Colors.white
                        : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : AppColors.textTertiary,
                      width: 1.5,
                    ),
                  ),
                  child: isSelected
                      ? Icon(Icons.check_rounded,
                          size: 14, color: AppColors.primary)
                      : null,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  symptom.category,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.7)
                        : AppColors.textTertiary,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  symptom.name,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: isSelected
                        ? Colors.white
                        : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SymptomItem {
  final String name;
  final String emoji;
  final String category;
  const _SymptomItem({
    required this.name,
    required this.emoji,
    required this.category,
  });
}