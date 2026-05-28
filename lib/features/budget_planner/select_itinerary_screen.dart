import 'package:flutter/material.dart';
import '../../core/savelo_colors.dart';
import '../../core/utils/image_helper.dart';
import '../../shared/widgets/s_itinerary_card.dart';
import '../../shared/widgets/s_info_banner.dart';
import '../../shared/widgets/s_ai_gemini_badge.dart';
import 'trip_details_screen.dart';
import 'models/itinerary.dart';

class SelectItineraryScreen extends StatelessWidget {
  final ItineraryGenerateData generateData;

  const SelectItineraryScreen({super.key, required this.generateData});

  String _formatCurrency(num value) {
    return value.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
  }

  String _getImageForVariant(String variant) {
    switch (variant) {
      case 'hemat':
        return ImageHelper.getImageForCategory("wisata", "hemat_trip");
      case 'seimbang':
        return ImageHelper.getImageForCategory("iconic", "seimbang_trip");
      case 'experience':
        return ImageHelper.getImageForCategory("alam", "experience_trip");
      default:
        return ImageHelper.getImageForCategory("alam", variant);
    }
  }

  String _getVariantDescription(String variant) {
    switch (variant) {
      case 'hemat':
        return "Fokus ke transportasi publik & UMKM lokal";
      case 'seimbang':
        return "Mix antara hemat & pengalaman premium";
      case 'experience':
        return "Kuliner premium & destinasi hidden gem";
      default:
        return "Pilihan itinerary untuk kamu";
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = generateData.request;
    
    return Scaffold(
      backgroundColor: SColors.sbackground,
      appBar: AppBar(
        backgroundColor: SColors.sbackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Pilih Itinerary", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16, top: 14, bottom: 14),
            child: SAiGeminiBadge(),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(color: SColors.sparagraph, fontSize: 13, height: 1.5),
                children: [
                  const TextSpan(text: "Gemini menyusun opsi sesuai budget "),
                  TextSpan(text: "Rp ${_formatCurrency(request.budget)}\n", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                  TextSpan(text: "untuk ${request.durationDays} hari di ${request.destinationLabel}."),
                ],
              ),
            ),
            const SizedBox(height: 24),

            ...generateData.itineraries.map((itinerary) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SItineraryCard(
                  title: itinerary.title,
                  description: _getVariantDescription(itinerary.variant),
                  imagePath: _getImageForVariant(itinerary.variant),
                  price: "Rp ${_formatCurrency(itinerary.totalEstimate)}",
                  budgetPercentageText: "${itinerary.budgetPercent}% budget",
                  budgetPercentage: itinerary.budgetPercent / 100,
                  isTopPick: itinerary.summary.isRecommended,
                  tags: itinerary.summary.tags,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TripDetailsScreen(itineraryId: itinerary.id))),
                ),
              );
            }).toList(),

            // Tip Banner
            SInfoBanner(
              backgroundColor: const Color(0xFFFFF8E1), // Light yellow
              icon: const Icon(Icons.auto_awesome, color: Colors.orange, size: 20),
              text: "Tip: bisa edit destinasi setelah pilih — budget counter akan update real-time.",
              textColor: Colors.brown.shade700,
              borderColor: Colors.orange.shade200,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
