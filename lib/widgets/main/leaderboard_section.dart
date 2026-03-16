import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juststudyflutterapp/models/leaderboard_entry.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../controllers/main/home_controller.dart';

class LeaderboardSection extends StatelessWidget {
  const LeaderboardSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Header ──────────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const Text('🏆', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Text('Top Studiers Today', style: AppTextStyles.headingSmall),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // ── Scrollable List ──────────────────────────────────────────────
        Expanded(
          child: Obx(
            () => ListView.builder(
              padding: const EdgeInsets.only(bottom: 16),
              itemCount: controller.leaderboard.length,
              itemBuilder: (context, index) {
                final LeaderboardEntry item = controller.leaderboard[index];
                return _LeaderboardRow(
                  rank: index + 1,
                  name: item.name,
                  time: item.time,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _LeaderboardRow extends StatelessWidget {
  final int rank;
  final String name;
  final String time;

  const _LeaderboardRow({
    required this.rank,
    required this.name,
    required this.time,
  });

  Color get _medalColor {
    if (rank == 1) return const Color(0xFFFFD700);
    if (rank == 2) return const Color(0xFFB0BEC5);
    if (rank == 3) return const Color(0xFFFF8C42);
    return AppColors.textSecondary.withOpacity(0.4);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Text(
              rank <= 3 ? ['🥇', '🥈', '🥉'][rank - 1] : '$rank',
              style: AppTextStyles.labelSmall.copyWith(color: _medalColor),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(name, style: AppTextStyles.bodyMedium),
          ),
          Text(
            time,
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}