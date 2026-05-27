import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../core/savelo_colors.dart';
import '../../shared/widgets/s_ai_gemini_badge.dart';
import 'select_itinerary_screen.dart';
import 'repositories/itinerary_repository.dart';

class LoadingItineraryScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> requestBody;

  const LoadingItineraryScreen({super.key, required this.requestBody});

  @override
  ConsumerState<LoadingItineraryScreen> createState() => _LoadingItineraryScreenState();
}

class _LoadingItineraryScreenState extends ConsumerState<LoadingItineraryScreen> {
  @override
  void initState() {
    super.initState();
    _generate();
  }

  Future<void> _generate() async {
    try {
      final repo = ref.read(itineraryRepositoryProvider);
      final result = await repo.generateItinerary(widget.requestBody);
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SelectItineraryScreen(generateData: result)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal: $e')),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SColors.sdarkgreen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.auto_awesome, color: Colors.orangeAccent, size: 60),
                ),
              ),
              const SizedBox(height: 32),

              // Badge
              const SAiGeminiBadge(),
              const SizedBox(height: 16),

              // Title
              const Text(
                "Gemini sedang meracik trip kamu...",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, height: 1.3),
              ),
              const SizedBox(height: 12),
              const Text(
                "Biasanya kurang dari 30 detik",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 48),

              // Checklist
              _buildChecklistItem(Icons.check_circle, "Menganalisis budget & preferensi", Colors.orangeAccent),
              const SizedBox(height: 16),
              _buildChecklistItem(Icons.check_circle, "Mencocokkan destinasi UMKM lokal", Colors.orangeAccent),
              const SizedBox(height: 16),
              _buildChecklistItem(Icons.circle, "Verifikasi badge aksesibilitas", Colors.white38),
              const SizedBox(height: 16),
              _buildChecklistItem(Icons.circle, "Menyusun 3 opsi itinerary", Colors.white38),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChecklistItem(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 16),
        Text(text, style: TextStyle(color: color == Colors.white38 ? Colors.white54 : Colors.white, fontSize: 14)),
      ],
    );
  }
}
