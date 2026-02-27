import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/icon_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  // ── 1. Master sequencer ────────────────────────────────────────────────────
  late final AnimationController _master = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 3200),
  );

  // ── 2. Idle float loop ─────────────────────────────────────────────────────
  late final AnimationController _float = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2600),
  )..repeat(reverse: true);

  // ── 3. Glow pulse loop ─────────────────────────────────────────────────────
  late final AnimationController _glow = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  )..repeat(reverse: true);

  // ── 4. Rotating ring ───────────────────────────────────────────────────────
  late final AnimationController _ring = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 8000),
  )..repeat();

  // ── 5. Floating particles ──────────────────────────────────────────────────
  late final AnimationController _particles = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2000),
  )..repeat();

  // ── Derived animations from _master ───────────────────────────────────────
  late final Animation<double> _bgFade = CurvedAnimation(
    parent: _master,
    curve: const Interval(0.0, 0.25, curve: Curves.easeOut),
  );

  late final Animation<double> _iconScale = Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).animate(CurvedAnimation(
    parent: _master,
    curve: const Interval(0.15, 0.55, curve: Curves.elasticOut),
  ));

  late final Animation<double> _iconFade = CurvedAnimation(
    parent: _master,
    curve: const Interval(0.15, 0.40, curve: Curves.easeOut),
  );

  late final Animation<double> _textFade = CurvedAnimation(
    parent: _master,
    curve: const Interval(0.45, 0.70, curve: Curves.easeOut),
  );

  late final Animation<Offset> _textSlide = Tween<Offset>(
    begin: const Offset(0, 0.6),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _master,
    curve: const Interval(0.45, 0.70, curve: Curves.easeOut),
  ));

  late final Animation<double> _taglineFade = CurvedAnimation(
    parent: _master,
    curve: const Interval(0.62, 0.82, curve: Curves.easeOut),
  );

  late final Animation<Offset> _taglineSlide = Tween<Offset>(
    begin: const Offset(0, 0.8),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _master,
    curve: const Interval(0.62, 0.82, curve: Curves.easeOut),
  ));

  late final Animation<double> _loaderFade = CurvedAnimation(
    parent: _master,
    curve: const Interval(0.78, 0.92, curve: Curves.easeOut),
  );

  // Float offset
  late final Animation<double> _floatY = Tween<double>(
    begin: -7.0,
    end: 7.0,
  ).animate(CurvedAnimation(parent: _float, curve: Curves.easeInOut));

  // Glow opacity
  late final Animation<double> _glowOpacity = Tween<double>(
    begin: 0.20,
    end: 0.55,
  ).animate(CurvedAnimation(parent: _glow, curve: Curves.easeInOut));

  // Loader progress
  late final Animation<double> _loaderProgress = Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).animate(CurvedAnimation(
    parent: _master,
    curve: const Interval(0.82, 1.0, curve: Curves.easeInOut),
  ));

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    // Small delay lets the first frame render before animation starts
    await Future.delayed(const Duration(milliseconds: 150));

    if (!mounted) return;
    _master.forward();

    _master.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 400), () {
          if (mounted) context.go('/onboarding');
        });
      }
    });
  }

  @override
  void dispose() {
    _master.dispose();
    _float.dispose();
    _glow.dispose();
    _ring.dispose();
    _particles.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: AnimatedBuilder(
        animation: _master,
        builder: (context, _) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(-0.8, -0.9),
                radius: 1.4,
                colors: [
                  AppColor.gradientStart.withValues(alpha: _bgFade.value),
                  AppColor.gradientMid.withValues(alpha: _bgFade.value * 0.8),
                  const Color(0xFF060D0A),
                ],
                stops: const [0.0, 0.40, 1.0],
              ),
            ),
            child: Stack(
              children: [
                // ── Particle layer ─────────────────────────────────────────
                Opacity(
                  opacity: _iconFade.value.clamp(0.0, 1.0),
                  child: _ParticleField(controller: _particles),
                ),

                // ── Center content ─────────────────────────────────────────
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildIconStack(),

                      SizedBox(height: 40.h),

                      // App name
                      SlideTransition(
                        position: _textSlide,
                        child: FadeTransition(
                          opacity: _textFade,
                          child: Text(
                            'IMPERFECTO',
                            style: GoogleFonts.dmSans(
                              color: Colors.white,
                              fontSize: 36.sp,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 8.h),

                      // Tagline
                      SlideTransition(
                        position: _taglineSlide,
                        child: FadeTransition(
                          opacity: _taglineFade,
                          child: Text(
                            'Progreso real, sin castigo.',
                            style: GoogleFonts.dmSans(
                              color: AppColor.textSecondary,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 64.h),

                      // Loader bar
                      FadeTransition(
                        opacity: _loaderFade,
                        child: _buildLoaderBar(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ── Icon stack: glow + rings + SVG ────────────────────────────────────────
  Widget _buildIconStack() {
    return AnimatedBuilder(
      animation: Listenable.merge([_float, _glow, _ring]),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatY.value),
          child: ScaleTransition(
            scale: _iconScale,
            child: FadeTransition(
              opacity: _iconFade,
              child: SizedBox(
                width: 160,
                height: 160,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer glow
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.accent
                                .withValues(alpha: _glowOpacity.value),
                            blurRadius: 80,
                            spreadRadius: 30,
                          ),
                        ],
                      ),
                    ),

                    // Outer rotating dashed ring
                    Transform.rotate(
                      angle: _ring.value * 2 * math.pi,
                      child: CustomPaint(
                        size: const Size(140, 140),
                        painter: _DashedRingPainter(
                          color: AppColor.accent.withValues(alpha: 0.35),
                          strokeWidth: 1.5,
                          dashCount: 20,
                        ),
                      ),
                    ),

                    // Inner counter-rotating dashed ring
                    Transform.rotate(
                      angle: -_ring.value * 2 * math.pi * 0.6,
                      child: CustomPaint(
                        size: const Size(110, 110),
                        painter: _DashedRingPainter(
                          color: AppColor.accent.withValues(alpha: 0.18),
                          strokeWidth: 1.0,
                          dashCount: 12,
                        ),
                      ),
                    ),

                    // Icon circle
                    Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.accent.withValues(alpha: 0.12),
                        border: Border.all(
                          color: AppColor.accent.withValues(alpha: 0.40),
                          width: 1.5,
                        ),
                      ),
                      // ✅ flutter_svg only — no vector_graphics needed
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: SvgPicture.asset(
                          IconPath.appLogoSvg,
                          fit: BoxFit.contain,
                          colorFilter: ColorFilter.mode(
                            AppColor.accent,
                            BlendMode.srcIn,
                          ),
                          // Fallback if SVG fails to load
                          placeholderBuilder: (_) => Icon(
                            Icons.restaurant_menu_rounded,
                            color: AppColor.accent,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ── Progress loader bar ────────────────────────────────────────────────────
  Widget _buildLoaderBar() {
    return AnimatedBuilder(
      animation: _loaderProgress,
      builder: (context, _) {
        return Column(
          children: [
            SizedBox(
              width: 140.w,
              height: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: _loaderProgress.value,
                  backgroundColor: AppColor.accent.withValues(alpha: 0.12),
                  valueColor: AlwaysStoppedAnimation<Color>(AppColor.accent),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Cargando tu plan…',
              style: GoogleFonts.dmSans(
                color: AppColor.textSecondary
                    .withValues(alpha: _loaderProgress.value),
                fontSize: 11.sp,
                letterSpacing: 0.3,
              ),
            ),
          ],
        );
      },
    );
  }
}

// ── Dashed ring CustomPainter ──────────────────────────────────────────────
class _DashedRingPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final int dashCount;

  const _DashedRingPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final dashAngle = (2 * math.pi) / dashCount;
    const gapFraction = 0.40;

    for (int i = 0; i < dashCount; i++) {
      final startAngle = i * dashAngle;
      final sweepAngle = dashAngle * (1 - gapFraction);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_DashedRingPainter old) =>
      old.color != color ||
          old.strokeWidth != strokeWidth ||
          old.dashCount != dashCount;
}

// ── Floating particle field ────────────────────────────────────────────────
class _ParticleField extends StatelessWidget {
  final AnimationController controller;
  const _ParticleField({required this.controller});

  static final _rng = math.Random(42);
  static final _dots = List.generate(
    18,
        (i) => (
    x: _rng.nextDouble(),
    y: _rng.nextDouble(),
    size: _rng.nextDouble() * 3 + 1.5,
    phase: _rng.nextDouble(),
    speed: _rng.nextDouble() * 0.4 + 0.6,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final t = controller.value;
        return LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: _dots.map((d) {
              final phase = (t * d.speed + d.phase) % 1.0;
              final opacity =
              math.sin(phase * math.pi).clamp(0.0, 1.0);
              final dy = -30 * phase;
              return Positioned(
                left: d.x * constraints.maxWidth,
                top: d.y * constraints.maxHeight + dy,
                child: Opacity(
                  opacity: (opacity * 0.55).clamp(0.0, 1.0),
                  child: Container(
                    width: d.size,
                    height: d.size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.accent,
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        });
      },
    );
  }
}