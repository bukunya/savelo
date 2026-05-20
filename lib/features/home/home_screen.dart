import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math; // Used for calculation during collapse
import '../../core/savelo_colors.dart';

// Import all your custom UI widgets
import '../../shared/widgets/s_pathpoints_card.dart';
import '../../shared/widgets/s_ai_itinerary_card.dart';
import '../../shared/widgets/s_category_cart.dart';
import '../../shared/widgets/s_destination_card.dart';
import '../../shared/widgets/s_eco_streak_card.dart';
import '../../shared/widgets/s_bottom_navbar.dart';
import '../auth/login_screen.dart';
import '../budget_planner/budget_planner_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double safeTop = MediaQuery.of(context).padding.top;
    double calculatedExpandedHeight = safeTop + 260.0;

    return Scaffold(
      backgroundColor: SColors.sbackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: SColors.sbackground,
            pinned: true,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            toolbarHeight: 84.0,
            expandedHeight: calculatedExpandedHeight,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double safeTop = MediaQuery.of(context).padding.top;
                double topPadding = math.max(safeTop, 24.0) + 16.0;

                double minHeight = 84.0 + safeTop;
                double maxHeight = calculatedExpandedHeight;

                double maxShrink = maxHeight - minHeight;
                double currentShrink = constraints.maxHeight - minHeight;
                double shrinkPercentage =
                    (math.max(0.0, maxShrink - currentShrink) / maxShrink)
                        .clamp(0.0, 1.0);

                double greetingsOpacity =
                    1.0 - (shrinkPercentage * 2.0).clamp(0.0, 1.0);
                double collapsedNotifOpacity = (shrinkPercentage * 2.0 - 1.0)
                    .clamp(0.0, 1.0);
                double pointsOpacity =
                    1.0 - (shrinkPercentage * 1.5).clamp(0.0, 1.0);

                double greetingsHeight = 44.0 * (1.0 - shrinkPercentage);
                double spacingAfterGreetings = 24.0 * (1.0 - shrinkPercentage);

                return Container(
                  decoration: const BoxDecoration(
                    color: SColors.sdarkgreen,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(32),
                    ),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                        top: topPadding,
                        left: 24.0,
                        right: 24.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: greetingsHeight,
                              child: SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                child: Opacity(
                                  opacity: greetingsOpacity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Halo, Traveler',
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            'Mau kemana hari ini?',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.notifications_none,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: spacingAfterGreetings),

                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        if (shrinkPercentage > 0.8)
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.05,
                                            ),
                                            blurRadius: 10,
                                          ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.search,
                                          color: SColors.sparagraph,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: TextField(
                                            controller: _searchController,
                                            focusNode: _searchFocusNode,
                                            decoration: const InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              hintText: "Cari kota, destinasi, UMKM...",
                                              hintStyle: TextStyle(
                                                color: SColors.sparagraph,
                                                fontSize: 14,
                                              ),
                                              border: InputBorder.none,
                                            ),
                                            style: const TextStyle(
                                              color: SColors.sbold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        if (_searchFocusNode.hasFocus)
                                          GestureDetector(
                                            onTap: () {
                                              _searchController.clear();
                                              _searchFocusNode.unfocus();
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.only(left: 8.0),
                                              child: Icon(Icons.close, color: SColors.sparagraph, size: 20),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                  if (collapsedNotifOpacity > 0.0 && !_searchFocusNode.hasFocus) ...[
                                  SizedBox(width: 12 * collapsedNotifOpacity),
                                  SizedBox(
                                    width: 40 * collapsedNotifOpacity,
                                    child: Opacity(
                                      opacity: collapsedNotifOpacity,
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.notifications_none,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),

                            if (pointsOpacity > 0.0) ...[
                              SizedBox(height: 20.0 * pointsOpacity),
                              Opacity(
                                opacity: pointsOpacity,
                                child: SPathPointsCard(
                                  points: "1.247",
                                  onRedeem: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Login untuk menukar poin!",
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SAiItineraryCard(
                      onStartPlan: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BudgetPlannerScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SCategoryCard(
                          label: "Budget",
                          icon: Icons.account_balance_wallet_outlined,
                          iconColor: SColors.sdarkgreen,
                        ),
                        SCategoryCard(
                          label: "Akses",
                          icon: Icons.accessible_forward,
                          iconColor: SColors.sblue,
                        ),
                        SCategoryCard(
                          label: "Peta",
                          icon: Icons.map_outlined,
                          iconColor: SColors.spurple,
                        ),
                        SCategoryCard(
                          label: "Eco",
                          icon: Icons.eco_outlined,
                          iconColor: Colors.green,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Text("🔥 ", style: TextStyle(fontSize: 18)),
                            Text(
                              "Lagi tren minggu ini",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: SColors.sbold,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Lihat semua",
                          style: TextStyle(
                            color: SColors.sdarkgreen.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      child: Row(
                        children: [
                          const SDestinationCard(
                            title: "Pasar Beringharjo",
                            location: "Yogyakarta",
                            priceRange: "Rp 0 – 50K",
                            imageUrl:
                                "https://www.uii.ac.id/wp-content/uploads/2018/05/Jogja-1-1.jpg",
                            isVerified: true,
                          ),
                          SDestinationCard(
                            title: "Hutan Pinus Mangunan",
                            location: "Bantul, DIY",
                            priceRange: "Rp 5K – 15K",
                            imageUrl:
                                "https://res.klook.com/image/upload/w_500,h_313,c_fill,q_85/activities/fqzsr56zk5qoik90d0qm.jpg",
                            isVerified: false,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    const SEcoStreakCard(
                      streakDays: 5,
                      co2Saved: "2.4",
                      progress: 0.6,
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: SBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          }
        },
      ),
    );
  }
}
