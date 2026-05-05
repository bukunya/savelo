import 'package:flutter/material.dart';
import '../../core/savelo_colors.dart';
import 's_button.dart';

class SAiItineraryCard extends StatelessWidget {
  final VoidCallback onStartPlan;

  const SAiItineraryCard({super.key, required this.onStartPlan});

  Widget _buildCustomBadge({
    required String text,
    required Color color,
    required IconData icon,
    bool isOutlined = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isOutlined ? color.withOpacity(0.1) : color,
        borderRadius: BorderRadius.circular(12),
        border: isOutlined ? Border.all(color: color.withOpacity(0.5)) : null,
      ),
      child: Row(
        children: [
          Icon(icon, size: 12, color: isOutlined ? color : Colors.white),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: isOutlined ? color : Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: SColors.sinput.withOpacity(0.8),
        ), // Subtle border
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildCustomBadge(
                text: "AI Gemini",
                color: const Color(0xFFD9668D),
                icon: Icons.auto_awesome,
              ),
              const SizedBox(width: 8),
              _buildCustomBadge(
                text: "< 30 detik",
                color: SColors.smustard,
                icon: Icons.bolt,
                isOutlined: true,
              ),
            ],
          ),
          const SizedBox(height: 16),

          const Text(
            "Buat itinerary dari budget kamu",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: SColors.sbold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "AI Gemini bikin 3 opsi rencana - Hemat, Seimbang, Experience.",
            style: TextStyle(
              color: SColors.sparagraph,
              fontSize: 14,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 20),

          SButton(
            text: "Mulai Plan Itinerary",
            icon: Icons.auto_awesome,
            onPressed: onStartPlan,
          ),
        ],
      ),
    );
  }
}
