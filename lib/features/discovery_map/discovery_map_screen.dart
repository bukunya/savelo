import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../core/savelo_colors.dart';
import '../../shared/widgets/s_bottom_navbar.dart';
import 'destinasi_detail_screen.dart';
import '../../core/auth_guard.dart';
import '../trip/my_trip_screen.dart';
import '../reward/reward_screen.dart';
import '../profile/profile_screen.dart';
import '../destinations/providers/destinations_provider.dart';
import '../destinations/models/destination.dart';

class DiscoveryMapScreen extends ConsumerStatefulWidget {
  const DiscoveryMapScreen({super.key});

  @override
  ConsumerState<DiscoveryMapScreen> createState() => _DiscoveryMapScreenState();
}

class _DiscoveryMapScreenState extends ConsumerState<DiscoveryMapScreen> {
  int _currentIndex = 1; // Index 1 is Jelajah
  int _selectedFilterIndex = 0; // 0 = Semua
  bool _showBottomCard = false;

  final List<Map<String, dynamic>> _filters = [
    {"label": "Semua", "icon": Icons.check, "color": Colors.white},
    {"label": "UMKM", "icon": Icons.circle, "color": SColors.sdarkgreen},
    {"label": "Iconic", "icon": Icons.circle, "color": Colors.blue},
    {"label": "Heritage", "icon": Icons.circle, "color": Colors.brown},
  ];

  MapPin? _selectedPin;
  final MapController _mapController = MapController();

  Widget _buildMapPinWidget({
    required String letter,
    required Color color,
    VoidCallback? onTap,
    String? tooltip,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          if (tooltip != null)
            Positioned(
              top: -30,
              child: Container(
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
    );
  }

  Color _parseColor(String colorHex) {
    try {
      final hex = colorHex.replaceAll('#', '');
      return Color(int.parse('FF$hex', radix: 16));
    } catch (_) {
      return SColors.sdarkgreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    double safeTop = MediaQuery.of(context).padding.top;

    final String? currentCategory = _selectedFilterIndex == 0 
        ? null 
        : _filters[_selectedFilterIndex]["label"].toString().toLowerCase();
    
    final pinsAsync = ref.watch(mapPinsProvider(currentCategory));

    return Scaffold(
      backgroundColor: const Color(0xFFE3E8DD), // Light greenish map color
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: const MapOptions(
              initialCenter: LatLng(-7.7956, 110.3695), // Yogyakarta
              initialZoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.savelo.app',
              ),
              pinsAsync.when(
                data: (pins) => MarkerLayer(
                  markers: pins.map((pin) {
                    final isSelected = _selectedPin?.placeId == pin.placeId;
                    return Marker(
                      point: LatLng(pin.lat, pin.lng),
                      width: 80,
                      height: 80,
                      child: _buildMapPinWidget(
                        letter: pin.mapCategory.isNotEmpty ? pin.mapCategory[0].toUpperCase() : "P",
                        color: _parseColor(pin.pinColor),
                        tooltip: isSelected ? "Pilih" : null,
                        onTap: () {
                          setState(() {
                            _selectedPin = pin;
                            _showBottomCard = true;
                          });
                          _mapController.move(LatLng(pin.lat, pin.lng), 15.0);
                        },
                      ),
                    );
                  }).toList(),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, st) {
                  debugPrint('Error loading pins: $e');
                  return Center(
                    child: Container(
                      color: Colors.white70,
                      padding: const EdgeInsets.all(8),
                      child: Text('Error loading pins: $e', style: const TextStyle(color: Colors.red)),
                    ),
                  );
                },
              ),
            ],
          ),

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

          if (_showBottomCard && _selectedPin != null)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Consumer(
                builder: (context, ref, child) {
                  final detailAsync = ref.watch(destinationDetailProvider(_selectedPin!.placeId));
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DestinasiDetailScreen(placeId: _selectedPin!.placeId),
                        ),
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
                              color: _parseColor(_selectedPin!.pinColor),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                _selectedPin!.mapCategory.isNotEmpty ? _selectedPin!.mapCategory[0].toUpperCase() : "P",
                                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: detailAsync.when(
                              data: (detail) => Column(
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
                                        child: Text(
                                          detail.mapCategory?.toUpperCase() ?? "UMKM",
                                          style: TextStyle(color: Colors.blue.shade700, fontSize: 10, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(Icons.star, color: Colors.orange, size: 12),
                                      const SizedBox(width: 4),
                                      Text("${detail.rating ?? 'N/A'}", style: const TextStyle(color: Colors.grey, fontSize: 11)),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    detail.name,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        detail.priceRange.label,
                                        style: const TextStyle(color: SColors.sdarkgreen, fontWeight: FontWeight.bold, fontSize: 12),
                                      ),
                                      Text(
                                        "+ Tambah ➔",
                                        style: TextStyle(color: SColors.sdarkgreen.withOpacity(0.8), fontWeight: FontWeight.bold, fontSize: 12),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              loading: () => const Center(child: CircularProgressIndicator(color: SColors.sdarkgreen)),
                              error: (err, st) => const Text("Gagal memuat detail"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
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
          } else if (index == 2) {
            nextScreen = const MyTripScreen();
          } else if (index == 3) {
            nextScreen = const RewardScreen();
          } else if (index == 4) {
            nextScreen = const ProfileScreen();
          } else {
            return;
          }

          if (index == 2 || index == 3 || index == 4) {
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
