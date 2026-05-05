import 'package:flutter/material.dart';
import '../../core/savelo_colors.dart';

class SEcoStreakCard extends StatelessWidget {
  final int streakDays;
  final String co2Saved;
  final double progress;

  const SEcoStreakCard({
    super.key,
    required this.streakDays,
    required this.co2Saved,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: SColors.sinput.withOpacity(0.8)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5F0E5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.eco_outlined,
                  color: SColors.sdarkgreen,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Eco Streak $streakDays hari 🔥",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: SColors.sbold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Kamu hemat ~$co2Saved kg CO₂ minggu ini",
                      style: const TextStyle(
                        color: SColors.sparagraph,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: SColors.sparagraph,
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 16),

          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: SColors.sinput,
              color: SColors.sdarkgreen,
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}
