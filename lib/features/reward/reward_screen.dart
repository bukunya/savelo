import 'package:flutter/material.dart';
import '../../core/savelo_colors.dart';
import '../../shared/widgets/s_bottom_navbar.dart';
import '../../core/auth_guard.dart';
import '../discovery_map/discovery_map_screen.dart';
import '../trip/my_trip_screen.dart';
import '../profile/profile_screen.dart';
import 'voucher_screen.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  int _currentIndex = 3;

  Widget _buildVoucherCard(IconData icon, String title, String subtitle, String points, {VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFEBEBEB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.brown.shade700, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 8),
                Text(points, style: const TextStyle(color: SColors.sdarkgreen, fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: SColors.sdarkgreen,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 0,
            ),
            onPressed: onTap ?? () {},
            child: const Text("Tukar", style: TextStyle(fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF9F6),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 16, bottom: 32),
              decoration: const BoxDecoration(
                color: Color(0xFFD08A29), // Orange/Brown color from mockup
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Reward Center",
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Icon(Icons.emoji_events_outlined, color: Colors.white, size: 40),
                  const SizedBox(height: 8),
                  const Text("1.247", style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold)),
                  const Text("PATHPOINTS", style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Column(
                              children: [
                                Text("540", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                                Text("EcoPoints", style: TextStyle(color: Colors.white, fontSize: 10)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Column(
                              children: [
                                Text("707", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                                Text("CulturePoints", style: TextStyle(color: Colors.white, fontSize: 10)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Tier Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Tier: Explorer", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "253 pts ke Adventurer",
                              style: TextStyle(color: Colors.orange.shade800, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 8,
                        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: 0.6, // 60% progress
                          child: Container(decoration: BoxDecoration(color: SColors.sdarkgreen, borderRadius: BorderRadius.circular(4))),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Beginner", style: TextStyle(color: Colors.grey, fontSize: 10)),
                          Text("Explorer", style: TextStyle(color: SColors.sdarkgreen, fontSize: 10, fontWeight: FontWeight.bold)),
                          Text("Adventurer", style: TextStyle(color: Colors.grey, fontSize: 10)),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Tukar Voucher UMKM
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Tukar Voucher UMKM", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text("Lihat semua", style: TextStyle(color: SColors.sdarkgreen, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 16),
                _buildVoucherCard(Icons.local_cafe_outlined, "Diskon 20% Kopi Klotok", "Kopi Klotok", "200 pts", onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const VoucherScreen()));
                }),
                _buildVoucherCard(Icons.shopping_bag_outlined, "Voucher Rp 25K Batik UMKM", "Batik Bentenan", "350 pts"),
                _buildVoucherCard(Icons.local_activity_outlined, "Free entry Keraton", "Keraton DIY", "500 pts"),
              ]),
            ),
          )
        ],
      ),
      bottomNavigationBar: SBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == _currentIndex) return;

          Widget nextScreen;
          if (index == 0) {
            Navigator.popUntil(context, (route) => route.isFirst);
            return;
          } else if (index == 1) {
            nextScreen = const DiscoveryMapScreen();
          } else if (index == 2) {
            nextScreen = const MyTripScreen();
          } else if (index == 4) {
            nextScreen = const ProfileScreen();
          } else {
            return;
          }

          if (index == 2 || index == 4) {
            AuthGuard.requireLogin(context, () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            });
          } else {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          }
        },
      ),
    );
  }
}
