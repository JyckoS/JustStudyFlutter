import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juststudyflutterapp/constants/app_colors.dart';
import 'package:juststudyflutterapp/constants/app_text_styles.dart';
import 'package:juststudyflutterapp/controllers/main/home_controller.dart';

class TimerCircle extends StatelessWidget {
  const TimerCircle({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      final isBreak = controller.timerPhase.value == TimerPhase.breakTime;
      final ringColor = isBreak ? AppColors.secondaryColor : AppColors.primaryColor;

      return GestureDetector(
        onTap: controller.onCircleTap,
        child: SizedBox(
          width: 220,
          height: 220,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // ── Progress Ring ───────────────────────────────────────────
              SizedBox(
                width: 220,
                height: 220,
                child: AnimatedProgressRing(
                  progress: controller.progress,
                  color: ringColor,
                ),
              ),

              // ── Inner Circle ────────────────────────────────────────────
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surfaceColor,
                  boxShadow: [
                    BoxShadow(
                      color: ringColor.withOpacity(0.15),
                      blurRadius: 24,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.formattedTime,
                      style: AppTextStyles.displayMedium.copyWith(
                        fontSize: 38,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      controller.isRunning.value
                          ? controller.phaseLabel
                          : 'Tap to start',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: ringColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class AnimatedProgressRing extends StatelessWidget {
  final double progress;
  final Color color;

  const AnimatedProgressRing({
    super.key,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: progress),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, _) {
        return CustomPaint(
          painter: _RingPainter(progress: value, color: color),
        );
      },
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color color;

  _RingPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 8.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - strokeWidth / 2;
    const startAngle = -3.14159 / 2;

    // Track
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = color.withOpacity(0.12)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );

    // Progress arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      2 * 3.14159 * progress,
      false,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress || old.color != color;
}