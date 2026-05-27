import 'package:flutter/material.dart';
import '../../core/savelo_colors.dart';
import '../../shared/widgets/s_ai_gemini_badge.dart';
import 'models/itinerary.dart';
import '../home/home_screen.dart';

class TripSelesaiScreen extends StatelessWidget {
  final ItineraryDetailData? detail;

  const TripSelesaiScreen({super.key, this.detail});

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
          "Trip Selesai!",
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
          children: [
            // Savelo Trip Card
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2E5E21), // Dark green background for the card
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                children: [
                  // Decorative circle on the top right
                  Positioned(
                    top: -40,
                    right: -40,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "SAVELO",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(color: Colors.orange.shade700, borderRadius: BorderRadius.circular(8)),
                                  child: const Text("TRIP CARD", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            const Text("23–25 Apr 2026", style: TextStyle(color: Colors.white70, fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text("${detail?.request.durationDays ?? 3} Hari di", style: const TextStyle(color: Colors.white70, fontSize: 14)),
                        Text("${detail?.request.destinationLabel ?? 'Yogyakarta'} 🇮🇩", style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 24),
                        
                        // 3 Stat Boxes
                        Row(
                          children: [
                            _buildStatBox("847", "PathPoints", Colors.orange.shade300),
                            const SizedBox(width: 12),
                            _buildStatBox("8", "Destinasi", Colors.white),
                            const SizedBox(width: 12),
                            _buildStatBox("3.2 kg", "CO₂ saved", Colors.orange.shade300),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Budget Performance
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Budget Performance", style: TextStyle(color: Colors.white70, fontSize: 12)),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                                    child: const Text("Under budget!", style: TextStyle(color: SColors.sdarkgreen, fontSize: 10, fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Rp ${detail?.itinerary.totalEstimate ?? '1.43M'}", style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                                  const SizedBox(width: 8),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Text("/ Rp ${detail != null ? detail!.itinerary.totalEstimate ~/ (detail!.itinerary.budgetPercent / 100) : '1.50M'}", style: const TextStyle(color: Colors.white70, fontSize: 12)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              // Progress bar
                              Container(
                                height: 6,
                                width: double.infinity,
                                decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), borderRadius: BorderRadius.circular(3)),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: detail != null ? detail!.itinerary.budgetPercent / 100 : 0.95,
                                  child: Container(
                                    decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(3)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Chips
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildLocationChip("Pasar Beringharjo"),
                            _buildLocationChip("Keraton"),
                            _buildLocationChip("Hutan Pinus"),
                            _buildLocationChip("Prambanan"),
                            _buildLocationChip("+4 lainnya", isGhost: true),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),

            // AI Trip Recap
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
                  Row(
                    children: [
                      SAiGeminiBadge(),
                      const SizedBox(width: 12),
                      const Text("AI Trip Recap", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(color: SColors.sparagraph, fontSize: 13, height: 1.5),
                      children: [
                        TextSpan(text: "Trip kamu mencapai "),
                        TextSpan(text: "62% destinasi UMKM", style: TextStyle(fontWeight: FontWeight.bold, color: SColors.sdarkgreen)),
                        TextSpan(text: " & memilih transportasi publik 7 dari 10 perjalanan. Kontribusi kamu setara dengan menanam "),
                        TextSpan(text: "0.3 pohon 🌱", style: TextStyle(fontWeight: FontWeight.bold, color: SColors.sdarkgreen)),
                        TextSpan(text: "."),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Points Breakdown
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
                  const Text("Poin yang didapat", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 16),
                  _buildPointRow(Icons.eco_outlined, "EcoPoints", "+340"),
                  const SizedBox(height: 12),
                  _buildPointRow(Icons.auto_awesome_outlined, "CulturePoints", "+507"),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  _buildPointRow(Icons.emoji_events_outlined, "Total PathPoints", "+847", isTotal: true),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 56,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: SColors.sdarkgreen),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                  ),
                  icon: const Icon(Icons.share_outlined, color: SColors.sdarkgreen, size: 18),
                  label: const Text("Share", style: TextStyle(color: SColors.sdarkgreen, fontWeight: FontWeight.bold)),
                  onPressed: () {},
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: SColors.sdarkgreen,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                    elevation: 0,
                  ),
                  onPressed: () {
                    // Navigate back to HomeScreen, clearing the stack
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                      (route) => false,
                    );
                  },
                  child: const Text("Selesai", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBox(String value, String label, Color valueColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(value, style: TextStyle(color: valueColor, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationChip(String text, {bool isGhost = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isGhost ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.location_on_outlined, color: Colors.white70, size: 12),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildPointRow(IconData icon, String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: isTotal ? SColors.sdarkgreen : Colors.grey, size: 20),
            const SizedBox(width: 12),
            Text(label, style: TextStyle(fontWeight: isTotal ? FontWeight.bold : FontWeight.normal, fontSize: 14)),
          ],
        ),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: isTotal ? 16 : 14)),
      ],
    );
  }
}
