import 'package:flutter/material.dart';
import '../../core/savelo_colors.dart';

class CheckInRundownScreen extends StatelessWidget {
  final String destinationName;
  final int currentProgress;
  final int totalDestinations;

  final int ecoPoints;
  final int culturePoints;
  final int pathPoints;
  final int totalPathPoints;

  const CheckInRundownScreen({
    super.key,
    required this.destinationName,
    required this.currentProgress,
    required this.totalDestinations,
    required this.ecoPoints,
    required this.culturePoints,
    required this.pathPoints,
    required this.totalPathPoints,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF9F6),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 80, left: 24, right: 24, bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 64), // Push down to center a bit
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: SColors.sdarkgreen,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(16),
                    child: const Icon(Icons.check, color: Colors.white, size: 48),
                  ),
                ),
                const SizedBox(height: 24),
                const Text("Check-in berhasil!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black87)),
                const SizedBox(height: 12),
                Text("$destinationName ditandai selesai.", style: const TextStyle(color: Colors.grey, fontSize: 14)),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    text: "Kamu dapat ",
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                    children: [
                      TextSpan(text: "+$pathPoints PathPoints", style: const TextStyle(color: SColors.sdarkgreen, fontWeight: FontWeight.bold)),
                      const TextSpan(text: " & "),
                      TextSpan(text: "+$ecoPoints EcoPoints", style: const TextStyle(color: SColors.sdarkgreen, fontWeight: FontWeight.bold)),
                      const TextSpan(text: "."),
                    ]
                  )
                ),
                const SizedBox(height: 8),
                Text("Total PathPoints: $totalPathPoints", style: const TextStyle(color: SColors.sdarkgreen, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 48),
                
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(child: Text("PROGRESS TRIP", style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold))),
                      const SizedBox(height: 8),
                      Center(child: Text("$currentProgress dari $totalDestinations destinasi selesai", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                      const SizedBox(height: 16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: totalDestinations > 0 ? currentProgress / totalDestinations : 0.0,
                          backgroundColor: Colors.grey.shade200,
                          color: SColors.sdarkgreen,
                          minHeight: 8,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100), // Pad for sticky button
              ],
            ),
          ),

          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: SColors.sdarkgreen,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text("Lanjut ke Destinasi Berikutnya", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
