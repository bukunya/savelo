import 'package:flutter/material.dart';
import '../../core/savelo_colors.dart';
import '../../shared/widgets/s_ai_gemini_badge.dart';

class TripLiveScreen extends StatelessWidget {
  const TripLiveScreen({super.key});

  Widget _buildSummaryMetric(String title, String mainValue, String subValue) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white70, fontSize: 10)),
            const SizedBox(height: 4),
            Text(mainValue, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 4),
            Text(subValue, style: TextStyle(color: Colors.orange.shade200, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingCard(String time, String duration, String title, String subtitle, String imageUrl) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(time, style: const TextStyle(color: SColors.sdarkgreen, fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.schedule, color: Colors.grey, size: 10),
                  const SizedBox(width: 2),
                  Text(duration, style: const TextStyle(color: Colors.grey, fontSize: 10)),
                ],
              )
            ],
          ),
          const SizedBox(width: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF9F6),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 16,
                    left: 24,
                    right: 24,
                    bottom: 32,
                  ),
                  decoration: const BoxDecoration(
                    color: SColors.sdarkgreen,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                          ),
                          const Expanded(
                            child: Center(
                              child: Text("Live Trip", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                            ),
                          ),
                          const SizedBox(width: 20), // Balance
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 8),
                          const Text("LIVE • HARI 2 / 3", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text("Liburan Jogja Hemat", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      const Text("24 Apr 2026 • 14:25 WIB", style: TextStyle(color: Colors.white70, fontSize: 12)),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          _buildSummaryMetric("Terpakai", "Rp 920K", "dari 1.5jt"),
                          _buildSummaryMetric("Tersisa", "Rp 580K", "aman ✓"),
                          _buildSummaryMetric("PathPoints", "+1.840", "hari ini"),
                        ],
                      ),
                    ],
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Warning Banner
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.orange.shade200),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.error_outline, color: Colors.orange.shade800, size: 20),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text("Budget 61% terpakai", style: TextStyle(color: Colors.orange.shade900, fontWeight: FontWeight.bold, fontSize: 14)),
                                      const SizedBox(width: 8),
                                      const SAiGeminiBadge(),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text("Tap untuk lihat 2 saran swap aktivitas hari 3 ➔", style: TextStyle(color: Colors.orange.shade800, fontSize: 12)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Sekarang
                      const Text("SEKARANG", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 1.2)),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                                  child: Image.network(
                                    "https://img.jakpost.net/c/2019/07/09/2019_07_09_76012_1562669678._large.jpg", // Kopi Klotok placeholder
                                    height: 140,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 12,
                                  left: 12,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(12)),
                                    child: Text("Sedang di sini", style: TextStyle(color: Colors.orange.shade900, fontSize: 10, fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Kopi Klotok", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                  const SizedBox(height: 4),
                                  const Row(
                                    children: [
                                      Icon(Icons.location_on_outlined, color: Colors.grey, size: 14),
                                      SizedBox(width: 4),
                                      Text("Pakem, Sleman • 2.4 km", style: TextStyle(color: Colors.grey, fontSize: 12)),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: SColors.sdarkgreen,
                                            padding: const EdgeInsets.symmetric(vertical: 14),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                                            elevation: 0,
                                          ),
                                          onPressed: () {},
                                          icon: const Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
                                          label: const Text("Check-in", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Container(
                                        width: 48,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey.shade300),
                                          borderRadius: BorderRadius.circular(24),
                                        ),
                                        child: const Icon(Icons.phone_outlined, color: Colors.grey, size: 20),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Berikutnya
                      const Text("BERIKUTNYA", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 1.2)),
                      const SizedBox(height: 16),
                      _buildUpcomingCard(
                        "16:00",
                        "1.5 jam",
                        "Hutan Pinus Mangunan",
                        "12.4 km • Sunset spot",
                        "https://res.klook.com/image/upload/w_500,h_313,c_fill,q_85/activities/fqzsr56zk5qoik90d0qm.jpg",
                      ),
                      _buildUpcomingCard(
                        "19:30",
                        "1 jam",
                        "Gudeg Yu Djum",
                        "8.2 km • Dinner UMKM",
                        "https://img.jakpost.net/c/2019/07/09/2019_07_09_76012_1562669678._large.jpg",
                      ),
                      
                      const SizedBox(height: 80), // Pad for sticky button
                    ],
                  ),
                ),
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
                  elevation: 5,
                ),
                onPressed: () {},
                child: const Text("Buka Navigasi", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
