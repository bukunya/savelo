import 'package:flutter/material.dart';
import '../../core/savelo_colors.dart';
import '../../shared/widgets/s_bottom_navbar.dart';
import 'widgets/logout_dialog.dart';
import 'wishlist_screen.dart';

import '../discovery_map/discovery_map_screen.dart';
import '../trip/my_trip_screen.dart';
import '../reward/reward_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final int _currentIndex = 4; // Saya index

  void _onBottomNavTapped(int index) {
    if (index == _currentIndex) return;
    
    Widget nextScreen;
    if (index == 0) {
      Navigator.popUntil(context, (route) => route.isFirst);
      return;
    } else if (index == 1) {
      nextScreen = const DiscoveryMapScreen();
    } else if (index == 2) {
      nextScreen = const MyTripScreen();
    } else if (index == 3) {
      nextScreen = const RewardScreen();
    } else {
      return;
    }
    
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
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
            Container(
              padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 32),
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
                  const Text(
                    "Profile",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEAA236),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text("F", style: TextStyle(color: Colors.black87, fontSize: 28, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Falah Awgjadi", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          const Text("falah@savelo.com", style: TextStyle(color: Colors.white70, fontSize: 14)),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAA236),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Text("Explorer", style: TextStyle(color: Colors.black87, fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatCard("3", "Trip", Icons.location_on_outlined),
                      _buildStatCard("847", "PathPts", Icons.emoji_events_outlined),
                      _buildStatCard("3.2kg", "CO₂ saved", Icons.eco_outlined),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    _buildMenuItem(Icons.favorite_border, "Tersimpan", trailingText: "12", onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const WishlistScreen()));
                    }),
                    const Divider(height: 1, color: Color(0xFFEEEEEE)),
                    _buildMenuItem(Icons.notifications_none, "Notifikasi"),
                    const Divider(height: 1, color: Color(0xFFEEEEEE)),
                    _buildMenuItem(Icons.logout, "Keluar", textColor: Colors.red.shade700, iconColor: Colors.red.shade700, iconBgColor: Colors.red.shade50, onTap: () {
                      LogoutDialog.show(context);
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {String? trailingText, VoidCallback? onTap, Color? textColor, Color? iconColor, Color? iconBgColor}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconBgColor ?? const Color(0xFFF5F5F5),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor ?? Colors.black87, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: textColor ?? Colors.black87)),
            ),
            if (trailingText != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAA236),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(trailingText, style: const TextStyle(color: Colors.black87, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 8),
            ],
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
          ],
        ),
      ),
    );
  }
}

