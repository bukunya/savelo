import 'package:flutter/material.dart';

class SAiGeminiBadge extends StatelessWidget {
  const SAiGeminiBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF4285F4), // Blue
            Color(0xFF9B72CB), // Purple
            Color(0xFFD96570), // Pink
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.auto_awesome, color: Colors.white, size: 14),
          SizedBox(width: 4),
          Text(
            "AI Gemini",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
