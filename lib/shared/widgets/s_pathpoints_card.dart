import 'package:flutter/material.dart';
import '../../core/savelo_colors.dart';

class SPathPointsCard extends StatelessWidget {
  final String points;
  final VoidCallback onRedeem;

  const SPathPointsCard({
    super.key,
    required this.points,
    required this.onRedeem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: SColors.smustard,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.emoji_events,
              color: SColors.sdarkgreen,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "PathPoints kamu",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                Text(
                  "$points pts",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: onRedeem,
            child: const Row(
              children: [
                Text(
                  "Tukar",
                  style: TextStyle(
                    color: SColors.smustard,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward, color: SColors.smustard, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
