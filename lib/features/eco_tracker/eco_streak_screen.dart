import 'package:flutter/material.dart';
import '../../core/savelo_colors.dart';
import '../../shared/widgets/s_ai_gemini_badge.dart';
import '../../shared/widgets/s_progress_bar.dart';

class EcoStreakScreen extends StatelessWidget {
  const EcoStreakScreen({super.key});

  Widget _buildDayItem(String day, bool isDone, String subtitle, {bool isToday = false}) {
    return Column(
      children: [
        Text(day, style: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isDone ? SColors.sdarkgreen : Colors.grey.shade200,
            shape: BoxShape.circle,
            border: isToday ? Border.all(color: Colors.orange, width: 2) : null,
          ),
          child: Icon(
            Icons.local_fire_department,
            color: isDone ? Colors.orange : Colors.grey.shade400,
            size: 18,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            color: isDone ? SColors.sdarkgreen : Colors.grey,
            fontSize: 10,
            fontWeight: isDone ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(IconData icon, String value, String unit, String subtitle) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            Icon(icon, color: SColors.sdarkgreen, size: 20),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(unit, style: const TextStyle(color: Colors.grey, fontSize: 10)),
            const SizedBox(height: 2),
            Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _buildTransportItem(IconData icon, String title, String count, double progress, Color progressColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: SColors.sdarkgreen, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(count, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 8),
                SProgressBar(percentage: progress, activeColor: progressColor),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMilestoneCard(String number, String title, String subtitle, {bool isAchieved = false, String? progressTag, double? progress}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
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
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isAchieved ? SColors.sdarkgreen : const Color(0xFFEBEBEB),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    number,
                    style: TextStyle(
                      color: isAchieved ? Colors.white : Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              if (isAchieved)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.check, color: SColors.sdarkgreen, size: 12),
                      SizedBox(width: 4),
                      Text("Tercapai", style: TextStyle(color: SColors.sdarkgreen, fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              if (progressTag != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(progressTag, style: TextStyle(color: Colors.orange.shade800, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
          if (progress != null) ...[
            const SizedBox(height: 16),
            SProgressBar(percentage: progress!, activeColor: Colors.orange),
          ]
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF9F6),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Header
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 16, bottom: 32),
              decoration: const BoxDecoration(
                color: SColors.sdarkgreen,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Expanded(
                        child: Text(
                          "Eco Streak",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 48), // Balance for back button
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade600,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.orange.shade300, width: 8),
                    ),
                    child: const Icon(Icons.local_fire_department, color: Colors.white, size: 50),
                  ),
                  const SizedBox(height: 16),
                  const Text("5", style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold)),
                  const Text("HARI BERURUTAN", style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                  const SizedBox(height: 8),
                  Text("Lanjut 2 hari lagi untuk menjadi Green Explorer", style: TextStyle(color: Colors.orange.shade200, fontSize: 12)),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Minggu Ini Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Minggu ini", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            Text("17–23 Apr", style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildDayItem("S", true, "0.4kg"),
                            _buildDayItem("S", true, "0.6kg"),
                            _buildDayItem("R", false, "—"),
                            _buildDayItem("K", true, "0.5kg"),
                            _buildDayItem("J", true, "0.3kg"),
                            _buildDayItem("S", true, "0.4kg"),
                            _buildDayItem("M", true, "0.2kg", isToday: true),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Summary Cards
                  Row(
                    children: [
                      _buildSummaryCard(Icons.trending_down, "2.4", "kg CO₂", "hemat"),
                      _buildSummaryCard(Icons.eco_outlined, "540", "EcoPoints", "minggu ini"),
                      _buildSummaryCard(Icons.emoji_events_outlined, "0.3", "Pohon", "setara"),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Insight Mingguan
                  Container(
                    padding: const EdgeInsets.all(16),
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
                            const SAiGeminiBadge(),
                            const SizedBox(width: 8),
                            const Text("Insight Mingguan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Kamu memilih transportasi publik 83% dari perjalanan minggu ini naik 12% vs minggu lalu. Hari Rabu kamu skip check-in, coba isi rutin biar streak tetap nyala.",
                          style: TextStyle(color: Colors.black87, fontSize: 13, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text("Pilihan Transportasi", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        _buildTransportItem(Icons.directions_walk, "Jalan kaki", "3x", 0.6, SColors.sdarkgreen),
                        _buildTransportItem(Icons.directions_bike, "Sepeda", "1x", 0.2, SColors.sdarkgreen),
                        _buildTransportItem(Icons.directions_bus, "TransJogja", "5x", 0.8, SColors.sdarkgreen),
                        _buildTransportItem(Icons.local_taxi, "Ojek online", "2x", 0.4, Colors.orange),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text("Milestone Streak", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 16),
                  _buildMilestoneCard("3", "Eco Newbie", "3 hari berurutan • +50 pts", isAchieved: true),
                  _buildMilestoneCard("7", "Green Explorer", "7 hari berurutan • +150 pts", progressTag: "5 / 7 hari", progress: 5/7),
                  _buildMilestoneCard("14", "Eco Champion", "14 hari berurutan • +400 pts"),
                  _buildMilestoneCard("30", "Climate Hero", "30 hari berurutan • +1.000 pts"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
