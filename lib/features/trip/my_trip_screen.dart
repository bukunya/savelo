import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/savelo_colors.dart';
import '../../core/utils/image_helper.dart';
import '../../shared/widgets/s_bottom_navbar.dart';
import '../budget_planner/budget_planner_screen.dart';
import 'trip_live_screen.dart';
import '../../core/auth_guard.dart';
import '../discovery_map/discovery_map_screen.dart';
import '../reward/reward_screen.dart';
import '../profile/profile_screen.dart';
import '../budget_planner/providers/itinerary_provider.dart';

class MyTripScreen extends ConsumerStatefulWidget {
  const MyTripScreen({super.key});

  @override
  ConsumerState<MyTripScreen> createState() => _MyTripScreenState();
}

class _MyTripScreenState extends ConsumerState<MyTripScreen> {
  int _currentIndex = 2; // Trip index

  Widget _buildTripCard({
    required String status,
    required String title,
    required String location,
    required String date,
    required String people,
    required String price,
    required String imageUrl,
    double? progress,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
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
                    imageUrl,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black.withOpacity(0.1), Colors.black.withOpacity(0.8)],
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(status, style: TextStyle(color: Colors.orange.shade900, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, color: Colors.white70, size: 14),
                          const SizedBox(width: 4),
                          Text(location, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, color: Colors.grey, size: 14),
                      const SizedBox(width: 4),
                      Text(date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      const SizedBox(width: 16),
                      const Icon(Icons.people_outline, color: Colors.grey, size: 14),
                      const SizedBox(width: 4),
                      Text(people, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.account_balance_wallet_outlined, color: SColors.sdarkgreen, size: 16),
                          const SizedBox(width: 8),
                          Text(price, style: const TextStyle(color: SColors.sdarkgreen, fontWeight: FontWeight.bold, fontSize: 14)),
                        ],
                      ),
                      if (progress != null)
                        Text("Progress ${(progress * 100).toInt()}%", style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  if (progress != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      height: 4,
                      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(2)),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: progress,
                        child: Container(decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(2))),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF9F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBF9F6),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Trip Saya",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Segment Control
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: SColors.sdarkgreen,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Text("Akan Datang (2)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text("Selesai (2)", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Active Trip Card logic
                Consumer(
                  builder: (context, ref, child) {
                    final activeTripIdAsync = ref.watch(activeTripIdProvider);
                    
                    return activeTripIdAsync.when(
                      data: (activeId) {
                        if (activeId == null) {
                          return const Padding(
                            padding: EdgeInsets.only(bottom: 24),
                            child: Center(
                              child: Text(
                                "Belum ada trip aktif. Yuk buat rencana baru!",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          );
                        }

                        final detailAsync = ref.watch(itineraryDetailProvider(activeId));
                        return detailAsync.when(
                          data: (detail) {
                            return _buildTripCard(
                              status: "Sedang berjalan",
                              title: "Liburan ${detail.request.destinationLabel}",
                              location: detail.request.destinationLabel,
                              date: "${detail.request.durationDays} hari",
                              people: "${detail.request.numPeople} orang",
                              price: "Rp ${detail.itinerary.totalEstimate}",
                              progress: detail.itinerary.budgetPercent / 100,
                              imageUrl: ImageHelper.getImageForCategory("wisata", "yogyakarta_banner"),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => TripLiveScreen(itineraryId: activeId)),
                                );
                              },
                            );
                          },
                          loading: () => const Center(child: CircularProgressIndicator()),
                          error: (err, stack) => Text("Gagal memuat trip: $err"),
                        );
                      },
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (err, stack) => const SizedBox(),
                    );
                  },
                ),

                _buildTripCard(
                  status: "Akan datang",
                  title: "Weekend Bandung Eco",
                  location: "Bandung",
                  date: "10–11 Mei 2026",
                  people: "4 orang",
                  price: "Rp 2.000.000",
                  imageUrl: ImageHelper.getImageForCategory("wisata", "bandung_cityscape"),
                ),
                
                const SizedBox(height: 80), // Padding for bottom FAB
              ],
            ),
          ),
          Positioned(
            bottom: 24,
            right: 24,
            child: FloatingActionButton.extended(
              backgroundColor: SColors.sdarkgreen,
              onPressed: () {
                AuthGuard.requireLogin(context, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BudgetPlannerScreen()),
                  );
                });
              },
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text("Rencana Baru", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
          } else if (index == 3) {
            nextScreen = const RewardScreen();
          } else if (index == 4) {
            nextScreen = const ProfileScreen();
          } else {
            return;
          }

          if (index == 3 || index == 4) {
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
