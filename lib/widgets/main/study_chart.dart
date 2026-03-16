import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../controllers/main/home_controller.dart';

class StudyChart extends StatelessWidget {
  const StudyChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Header ─────────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              const Text('📈', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Text('Today', style: AppTextStyles.headingSmall),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // ── Chart ───────────────────────────────────────────────────────
        Expanded(
          child: Obx(() {
            final spots = controller.chartSpots;

            if (spots.isEmpty) {
              return Center(
                child: Text(
                  'No data yet!',
                  style: AppTextStyles.bodySmall,
                ),
              );
            }

final maxY = (spots.map((s) => s.y).reduce((a, b) => a > b ? a : b) * 1.3).ceilToDouble();

            return Padding(
              padding: const EdgeInsets.only(right: 12, bottom: 8),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (_) => FlLine(
                      color: AppColors.textSecondary.withOpacity(0.1),
                      strokeWidth: 1,
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: (value, _) => Text(
                          '${value.toInt()}m',
                          style: AppTextStyles.labelSmall.copyWith(fontSize: 9),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) => Text(
                          '#${value.toInt() + 1}',
                          style: AppTextStyles.labelSmall.copyWith(fontSize: 9),
                        ),
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  minY: 0,
                  maxY: maxY,
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: AppColors.primaryColor,
                      barWidth: 2.5,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (_, __, ___, ____) =>
                            FlDotCirclePainter(
                          radius: 3,
                          color: AppColors.primaryColor,
                          strokeWidth: 1.5,
                          strokeColor: AppColors.surfaceColor,
                        ),
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: AppColors.primaryColor.withOpacity(0.08),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}