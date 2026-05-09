import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';

class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> with TickerProviderStateMixin {
  late AnimationController _laserController;
  late AnimationController _pulseController;
  late AnimationController _fadeController;
  late Animation<double> _laserAnim;
  late Animation<double> _pulseAnim;
  late Animation<double> _fadeAnim;

  bool _flashOn = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    _laserController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();

    _laserAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _laserController, curve: Curves.easeInOut),
    );
    _pulseAnim = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _fadeAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _laserController.dispose();
    _pulseController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _simulateScan() {
    HapticFeedback.mediumImpact();
    _showResultSheet();
  }

  void _showResultSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _buildResultSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scanSize = size.width * 0.68;

    return Scaffold(
      backgroundColor: Colors.black,
      body: FadeTransition(
        opacity: _fadeAnim,
        child: Stack(
          children: [
            // Simulated Camera Background
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [const Color(0xFF0A0A0A), const Color(0xFF1A1A2E)],
                ),
              ),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10,
                ),
                itemCount: 200,
                itemBuilder: (_, _) => Container(
                  margin: const EdgeInsets.all(1),
                  color: Colors.white.withValues(alpha: 0.02),
                ),
              ),
            ),

            // Dark overlay with clear scan area
            CustomPaint(
              size: Size(size.width, size.height),
              painter: _ScanOverlayPainter(
                scanSize: scanSize,
                cornerColor: AppColors.primaryGlow,
              ),
            ),

            // Scan area elements
            Center(
              child: SizedBox(
                width: scanSize,
                height: scanSize,
                child: Stack(
                  children: [
                    // Animated laser line
                    AnimatedBuilder(
                      animation: _laserAnim,
                      builder: (context, _) {
                        return Positioned(
                          top: _laserAnim.value * (scanSize - 3),
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 3,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  AppColors.primaryGlow,
                                  AppColors.primaryGlow,
                                  Colors.transparent,
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryGlow.withValues(
                                    alpha: 0.8,
                                  ),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    // Pulsing corner glow
                    AnimatedBuilder(
                      animation: _pulseAnim,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _pulseAnim.value,
                          child: child,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.primaryGlow.withValues(alpha: 0.2),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Top Header
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.2),
                              ),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Scan Obat',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => setState(() => _flashOn = !_flashOn),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: _flashOn
                                  ? Colors.amber.withValues(alpha: 0.3)
                                  : Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _flashOn
                                    ? Colors.amber.withValues(alpha: 0.6)
                                    : Colors.white.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Icon(
                              _flashOn
                                  ? Icons.flash_on_rounded
                                  : Icons.flash_off_rounded,
                              color: _flashOn ? Colors.amber : Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Guide text below scan area
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: scanSize + 40),
                child: Column(
                  children: [
                    Text(
                      'Arahkan kamera ke kemasan obat',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Pastikan teks label terbaca dengan jelas',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Controls
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                top: false,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(28, 24, 28, 32),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.9),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildControlBtn(
                        Icons.photo_library_rounded,
                        'Galeri',
                        () {},
                      ),
                      // Scan Button
                      GestureDetector(
                        onTap: _simulateScan,
                        child: AnimatedBuilder(
                          animation: _pulseAnim,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _pulseAnim.value,
                              child: child,
                            );
                          },
                          child: Container(
                            width: 76,
                            height: 76,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AppTheme.primaryGradient,
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryGlow.withValues(
                                    alpha: 0.5,
                                  ),
                                  blurRadius: 24,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.document_scanner_rounded,
                              color: Colors.white,
                              size: 34,
                            ),
                          ),
                        ),
                      ),
                      _buildControlBtn(Icons.history_rounded, 'Riwayat', () {}),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlBtn(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultSheet() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textTertiary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryLighter,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.medication_rounded,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Paracetamol 500mg',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    'Tablet — Generik',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '✓ Terverifikasi',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.success,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 16),

          _buildInfoRow('Kandungan', 'Paracetamol 500mg'),
          _buildInfoRow('Indikasi', 'Meredakan demam dan nyeri'),
          _buildInfoRow('Dosis', '3x sehari 1 tablet setelah makan'),
          _buildInfoRow('Pabrik', 'PT Pharma Indonesia'),

          const SizedBox(height: 24),

          ElevatedButton.icon(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.info_rounded),
            label: const Text('Lihat Detail Lengkap'),
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScanOverlayPainter extends CustomPainter {
  final double scanSize;
  final Color cornerColor;

  _ScanOverlayPainter({required this.scanSize, required this.cornerColor});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final left = centerX - scanSize / 2;
    final top = centerY - scanSize / 2;
    final right = centerX + scanSize / 2;
    final bottom = centerY + scanSize / 2;

    // Dark overlay
    final overlayPaint = Paint()..color = Colors.black.withValues(alpha: 0.65);
    final overlayPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTRB(left, top, right, bottom),
          const Radius.circular(20),
        ),
      )
      ..fillType = PathFillType.evenOdd;
    canvas.drawPath(overlayPath, overlayPaint);

    // Corner brackets
    final cornerPaint = Paint()
      ..color = cornerColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    const cornerLen = 28.0;
    const radius = 20.0;

    // Top-left
    canvas.drawArc(
      Rect.fromLTWH(left, top, radius * 2, radius * 2),
      3.14159,
      0.5 * 3.14159,
      false,
      cornerPaint,
    );
    canvas.drawLine(
      Offset(left, top + radius),
      Offset(left, top + radius + cornerLen),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(left + radius, top),
      Offset(left + radius + cornerLen, top),
      cornerPaint,
    );

    // Top-right
    canvas.drawArc(
      Rect.fromLTWH(right - radius * 2, top, radius * 2, radius * 2),
      -0.5 * 3.14159,
      0.5 * 3.14159,
      false,
      cornerPaint,
    );
    canvas.drawLine(
      Offset(right, top + radius),
      Offset(right, top + radius + cornerLen),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(right - radius, top),
      Offset(right - radius - cornerLen, top),
      cornerPaint,
    );

    // Bottom-left
    canvas.drawArc(
      Rect.fromLTWH(left, bottom - radius * 2, radius * 2, radius * 2),
      0.5 * 3.14159,
      0.5 * 3.14159,
      false,
      cornerPaint,
    );
    canvas.drawLine(
      Offset(left, bottom - radius),
      Offset(left, bottom - radius - cornerLen),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(left + radius, bottom),
      Offset(left + radius + cornerLen, bottom),
      cornerPaint,
    );

    // Bottom-right
    canvas.drawArc(
      Rect.fromLTWH(
        right - radius * 2,
        bottom - radius * 2,
        radius * 2,
        radius * 2,
      ),
      0,
      0.5 * 3.14159,
      false,
      cornerPaint,
    );
    canvas.drawLine(
      Offset(right, bottom - radius),
      Offset(right, bottom - radius - cornerLen),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(right - radius, bottom),
      Offset(right - radius - cornerLen, bottom),
      cornerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
