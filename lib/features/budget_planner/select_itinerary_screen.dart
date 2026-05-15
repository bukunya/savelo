import 'package:flutter/material.dart';
import '../../core/savelo_colors.dart';
import '../../shared/widgets/s_itinerary_card.dart';
import '../../shared/widgets/s_info_banner.dart';
import '../../shared/widgets/s_ai_gemini_badge.dart';
import 'trip_details_screen.dart';

class SelectItineraryScreen extends StatelessWidget {
  const SelectItineraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              text: const TextSpan(
                style: TextStyle(color: SColors.sparagraph, fontSize: 13, height: 1.5),
                children: [
                  TextSpan(text: "Gemini menyusun 3 opsi sesuai budget "),
                  TextSpan(text: "Rp 1.500.000\n", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                  TextSpan(text: "untuk 3 hari di Yogyakarta."),
                ],
              ),
            ),
            const SizedBox(height: 24),

            SItineraryCard(
              title: "Hemat",
              description: "Fokus ke transportasi publik & UMKM lokal",
              imagePath: "https://www.uii.ac.id/wp-content/uploads/2018/05/Jogja-1-1.jpg",
              price: "Rp 1.180.000",
              budgetPercentageText: "79% budget",
              budgetPercentage: 0.79,
              tags: const ["TransJogja & sepeda", "9 destinasi UMKM", "Eco +180 pts"],
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TripDetailsScreen())),
            ),

            SItineraryCard(
              title: "Seimbang",
              description: "Mix antara hemat & pengalaman premium",
              imagePath: "https://www.bakpiamutiarajogja.com/wp-content/uploads/2022/11/Sejarah-Tugu-Jogja.png",
              price: "Rp 1.450.000",
              budgetPercentageText: "97% budget",
              budgetPercentage: 0.97,
              isTopPick: true,
              tags: const ["6 destinasi ikonik", "Mix taxi + transit", "Eco +120 pts"],
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TripDetailsScreen())),
            ),

            SItineraryCard(
              title: "Experience",
              description: "Kuliner premium & destinasi hidden gem",
              imagePath: "https://res.klook.com/image/upload/w_500,h_313,c_fill,q_85/activities/fqzsr56zk5qoik90d0qm.jpg",
              price: "Rp 1.490.000",
              budgetPercentageText: "99% budget",
              budgetPercentage: 0.99,
              tags: const ["Heritage tour 2 hari", "Private guide UMKM", "Eco +60 pts"],
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TripDetailsScreen())),
            ),

            const SizedBox(height: 16),

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
