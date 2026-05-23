import 'package:flutter/material.dart';
import '../../core/savelo_colors.dart';
import '../../shared/widgets/s_bottom_navbar.dart';
import 'destinasi_detail_screen.dart';

class DiscoveryMapScreen extends StatefulWidget {
  const DiscoveryMapScreen({super.key});

  @override
  State<DiscoveryMapScreen> createState() => _DiscoveryMapScreenState();
}

class _DiscoveryMapScreenState extends State<DiscoveryMapScreen> {
  int _currentIndex = 1; // Index 1 is Jelajah
  int _selectedFilterIndex = 0; // 0 = Semua
  bool _showBottomCard = false;

  final List<Map<String, dynamic>> _filters = [
    {"label": "Semua", "icon": Icons.check, "color": Colors.white},
    {"label": "UMKM", "icon": Icons.circle, "color": SColors.sdarkgreen},
    {"label": "Iconic", "icon": Icons.circle, "color": Colors.blue},
    {"label": "Heritage", "icon": Icons.circle, "color": Colors.brown},
  ];

  Widget _buildMapPin({
    required String letter,
    required Color color,
    required double top,
    required double left,
    VoidCallback? onTap,
    String? tooltip,
  }) {
    return Positioned(
      top: top,
      left: left,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            if (tooltip != null)
              Container(
                margin: const EdgeInsets.only(bottom: 4),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2))
                  ],
                ),
                child: Text(tooltip, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
              ),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(color: color.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 4))
                ],
              ),
              child: Center(
                child: Text(
                  letter,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double safeTop = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFFE3E8DD), // Light greenish map color
      body: Stack(
        children: [
          // Map Background placeholder lines
          Positioned(
            top: 200,
            left: -50,
            right: -50,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.white.withOpacity(0.6), width: 8),
                  bottom: BorderSide(color: Colors.white.withOpacity(0.6), width: 8),
                ),
              ),
            ),
          ),
          Positioned(
            top: -100,
            bottom: -100,
            left: 100,
            child: Container(
              width: 12,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          Positioned(
            top: -100,
            bottom: -100,
            right: 80,
            child: Container(
              width: 12,
              color: Colors.white.withOpacity(0.6),
            ),
          ),

          // Pins
          _buildMapPin(letter: "I", color: Colors.blue, top: safeTop + 130, left: 240),
          _buildMapPin(letter: "U", color: SColors.sdarkgreen, top: safeTop + 180, left: 80),
          _buildMapPin(letter: "H", color: Colors.brown, top: safeTop + 380, left: 280),
          _buildMapPin(
            letter: "U",
            color: SColors.sdarkgreen,
            top: safeTop + 480,
            left: 70,
          ),
          _buildMapPin(
            letter: "H",
            color: Colors.deepPurple,
            top: safeTop + 580,
            left: 160,
            tooltip: "Kuliner Murah dekat sini",
            onTap: () {
              setState(() {
                _showBottomCard = true;
              });
            },
          ),
          _buildMapPin(
            letter: "A",
            color: Colors.white,
            top: safeTop + 600,
            left: 300,
            onTap: () {},
          ), // Navigation arrow
          _buildMapPin(letter: "H", color: Colors.orange, top: safeTop + 660, left: 260),

          // Top Controls
          Positioned(
            top: safeTop + 16,
            left: 16,
            right: 16,
            child: Column(
              children: [
                // Search Bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search, color: SColors.sparagraph),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "Cari di Yogyakarta...",
                          style: TextStyle(color: SColors.sparagraph, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Filters
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(_filters.length, (index) {
                      final filter = _filters[index];
                      final isSelected = _selectedFilterIndex == index;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedFilterIndex = index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected ? SColors.sdarkgreen : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected ? SColors.sdarkgreen : Colors.grey.shade300,
                              ),
                            ),
                            child: Row(
                              children: [
                                if (filter["icon"] != Icons.check)
                                  Icon(filter["icon"], color: filter["color"], size: 10),
                                if (filter["icon"] != Icons.check) const SizedBox(width: 6),
                                Text(
                                  filter["label"],
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.black87,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    fontSize: 12,
                                  ),
                                ),
                                if (isSelected && index == 0) ...[
                                  const SizedBox(width: 4),
                                  const Icon(Icons.check, color: Colors.white, size: 14),
                                ]
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Card Pop-up
          if (_showBottomCard)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DestinasiDetailScreen()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10))
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: SColors.sdarkgreen,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Text("U", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text("UMKM", style: TextStyle(color: Colors.blue.shade700, fontSize: 10, fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.star, color: Colors.orange, size: 12),
                                const SizedBox(width: 4),
                                const Text("4.6 • 1.2 km", style: TextStyle(color: Colors.grey, fontSize: 11)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Pasar Beringharjo",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Rp 0–50K",
                                  style: TextStyle(color: SColors.sdarkgreen, fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                                Text(
                                  "+ Tambah ➔",
                                  style: TextStyle(color: SColors.sdarkgreen.withOpacity(0.8), fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
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
          if (index == 0) {
            Navigator.pop(context);
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
      ),
    );
  }
}
