import 'package:flutter/material.dart';
import '../../core/savelo_colors.dart';
import '../../shared/widgets/s_ai_gemini_badge.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  Widget _buildNotificationItem({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String text,
    required String time,
    bool isUnread = false,
    bool hasGemini = false,
    String? emojiText,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              if (isUnread)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: title,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            if (emojiText != null)
                              TextSpan(
                                text: " $emojiText",
                                style: const TextStyle(fontSize: 14),
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (hasGemini) ...[
                      const SizedBox(width: 8),
                      const SAiGeminiBadge(),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: const TextStyle(color: SColors.sparagraph, fontSize: 13, height: 1.4),
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF9F6), // Slightly warm white background
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBF9F6),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Notifikasi",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Hari ini",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "3 baru",
                    style: TextStyle(color: Colors.orange.shade800, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildNotificationItem(
              icon: Icons.warning_amber_rounded,
              iconBgColor: Colors.orange.shade100,
              iconColor: Colors.orange.shade800,
              title: "Smart Re-planner aktif",
              text: "Budget kamu hampir habis (92%). AI Gemini punya 2 saran swap untuk hari 3.",
              time: "Baru saja",
              isUnread: true,
              hasGemini: true,
            ),
            _buildNotificationItem(
              icon: Icons.local_fire_department,
              iconBgColor: Colors.deepOrange.shade100,
              iconColor: Colors.deepOrange.shade800,
              title: "Streak 5 hari!",
              emojiText: "🔥",
              text: "Jangan lupa check-in hari ini biar streak tetap nyala.",
              time: "2 jam lalu",
              isUnread: true,
            ),
            _buildNotificationItem(
              icon: Icons.card_giftcard,
              iconBgColor: Colors.green.shade100,
              iconColor: SColors.sdarkgreen,
              title: "Voucher baru tersedia",
              text: "Tukar 500 pts ➔ Voucher Rp 25K Gudeg Yu Djum.",
              time: "5 jam lalu",
              isUnread: true,
            ),
            
            const SizedBox(height: 24),
            
            const Text(
              "Sebelumnya",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
            _buildNotificationItem(
              icon: Icons.eco_outlined,
              iconBgColor: Colors.lightGreen.shade100,
              iconColor: Colors.green.shade800,
              title: "+120 EcoPoints",
              text: "Check-in pakai TransJogja di Pasar Beringharjo.",
              time: "Kemarin",
            ),
            _buildNotificationItem(
              icon: Icons.emoji_events_outlined,
              iconBgColor: Colors.orange.shade100,
              iconColor: Colors.orange.shade800,
              title: "Tier Explorer tercapai",
              text: "Kamu naik dari Newbie ➔ Explorer. Unlock 5 voucher UMKM.",
              time: "2 hari lalu",
            ),
            _buildNotificationItem(
              icon: Icons.location_on_outlined,
              iconBgColor: Colors.blue.shade100,
              iconColor: Colors.blue.shade800,
              title: "Destinasi disekitarmu",
              text: "Hutan Pinus Mangunan (3.2km) lagi tren minggu ini.",
              time: "3 hari lalu",
            ),
          ],
        ),
      ),
    );
  }
}
