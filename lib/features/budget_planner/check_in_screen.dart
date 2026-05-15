import 'package:flutter/material.dart';
import '../../core/savelo_colors.dart';
import '../../shared/widgets/s_badge.dart';
import '../../shared/widgets/s_info_banner.dart';
import '../../shared/widgets/s_transport_option_card.dart';
import '../../shared/widgets/s_ai_gemini_badge.dart';
import 'trip_selesai_screen.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  int _selectedTransportIndex = 2; // Default to TransJogja

  final List<Map<String, dynamic>> _transportOptions = [
    {"icon": Icons.directions_walk, "title": "Jalan kaki", "points": "+50 pts", "co2": "0 kg CO₂"},
    {"icon": Icons.directions_bike, "title": "Sepeda", "points": "+45 pts", "co2": "0 kg CO₂"},
    {"icon": Icons.directions_bus, "title": "TransJogja", "points": "+30 pts", "co2": "0.4 kg CO₂"},
    {"icon": Icons.directions_railway, "title": "Kereta", "points": "+25 pts", "co2": "0.6 kg CO₂"},
    {"icon": Icons.local_taxi, "title": "Ojek/Taksi Online", "points": "+10 pts", "co2": "1.8 kg CO₂"},
    {"icon": Icons.directions_car, "title": "Mobil Pribadi", "points": "+5 pts", "co2": "2.6 kg CO₂"},
  ];

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
        title: const Text(
          "Check-in",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.location_on_outlined, color: SColors.sdarkgreen),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SBadge(
                                  text: "GPS verified",
                                  color: SColors.sdarkgreen,
                                  icon: Icons.check,
                                  backgroundColor: Colors.green.shade50,
                                ),
                                const SizedBox(width: 8),
                                const Text("radius 100m", style: TextStyle(color: Colors.grey, fontSize: 11)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Pasar Beringharjo",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Jl. Margo Mulyo • 23 m dari pin",
                              style: TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Map placeholder
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.green.shade200,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: SColors.sdarkgreen,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Transport Selection
            const Text(
              "Tadi naik apa?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "Pilihan ramah lingkungan = lebih banyak EcoPoints",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 16),
            
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.5,
              ),
              itemCount: _transportOptions.length,
              itemBuilder: (context, index) {
                final option = _transportOptions[index];
                return STransportOptionCard(
                  icon: option["icon"],
                  title: option["title"],
                  points: option["points"],
                  co2: option["co2"],
                  isSelected: _selectedTransportIndex == index,
                  onTap: () {
                    setState(() {
                      _selectedTransportIndex = index;
                    });
                  },
                );
              },
            ),
            const SizedBox(height: 32),

            // Points Summary
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
                  const Row(
                    children: [
                      Icon(Icons.eco_outlined, color: SColors.sdarkgreen, size: 20),
                      SizedBox(width: 8),
                      Text("Kamu akan dapat", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
                          child: const Column(
                            children: [
                              Text("+30", style: TextStyle(color: SColors.sdarkgreen, fontSize: 20, fontWeight: FontWeight.bold)),
                              Text("EcoPoints", style: TextStyle(color: SColors.sdarkgreen, fontSize: 10)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            children: [
                              Text("+25", style: TextStyle(color: Colors.orange.shade800, fontSize: 20, fontWeight: FontWeight.bold)),
                              Text("CulturePoints", style: TextStyle(color: Colors.orange.shade800, fontSize: 10)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                          child: const Column(
                            children: [
                              Text("+55", style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold)),
                              Text("PathPoints", style: TextStyle(color: Colors.grey, fontSize: 10)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),

            // AI Info Banner
            SInfoBanner(
              backgroundColor: const Color(0xFFF0F4FF),
              icon: const Padding(
                padding: EdgeInsets.only(top: 2),
                child: SAiGeminiBadge(),
              ),
              text: "Pilihan ini hemat ~1.4 kg CO₂ dibanding rata-rata pengunjung.",
              textColor: const Color(0xFF3F51B5),
              borderColor: const Color(0xFFE3E8FF),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TripSelesaiScreen()),
              );
            },
            child: const Text(
              "Konfirmasi Check-in",
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
