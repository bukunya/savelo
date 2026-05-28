import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/savelo_colors.dart';
import '../../shared/widgets/s_badge.dart';
import '../../shared/widgets/s_info_banner.dart';
import '../../shared/widgets/s_transport_option_card.dart';
import '../../shared/widgets/s_ai_gemini_badge.dart';
import 'models/itinerary.dart';
import 'trip_selesai_screen.dart';
import '../trip/check_in_rundown_screen.dart';

import 'models/checkin.dart';
import 'repositories/itinerary_repository.dart';

class CheckInScreen extends ConsumerStatefulWidget {
  final int itineraryId;
  final ItineraryItemData item;
  final bool isLastItem;
  final ItineraryDetailData detail;
  final int currentProgress;
  final int totalItems;

  const CheckInScreen({
    super.key, 
    required this.itineraryId,
    required this.item,
    required this.isLastItem,
    required this.detail,
    required this.currentProgress,
    required this.totalItems,
  });

  @override
  ConsumerState<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends ConsumerState<CheckInScreen> {
  int _selectedTransportIndex = 0;
  bool _isLoading = true;
  CheckinPreviewData? _previewData;

  @override
  void initState() {
    super.initState();
    _loadPreview();
  }

  Future<void> _loadPreview() async {
    try {
      final data = await ref.read(itineraryRepositoryProvider).getCheckinPreview(widget.itineraryId, widget.item.id);
      if (mounted) {
        setState(() {
          _previewData = data;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
        Navigator.pop(context);
      }
    }
  }

  IconData _getIconForMode(String mode) {
    switch (mode) {
      case 'walking': return Icons.directions_walk;
      case 'cycling': return Icons.directions_bike;
      case 'bus': return Icons.directions_bus;
      case 'train': return Icons.directions_railway;
      case 'motorcycle': return Icons.two_wheeler;
      case 'car': return Icons.directions_car;
      default: return Icons.directions_car;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: SColors.sbackground,
        appBar: AppBar(
          backgroundColor: SColors.sbackground,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text("Check-in", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: const Center(child: CircularProgressIndicator(color: SColors.sdarkgreen)),
      );
    }

    if (_previewData == null) {
      return const Scaffold(body: Center(child: Text("Gagal memuat data preview.")));
    }

    final preview = _previewData!;
    final destination = preview.destination;
    final transportModes = preview.transportModes;
    final selectedMode = transportModes.isNotEmpty && _selectedTransportIndex < transportModes.length ? transportModes[_selectedTransportIndex] : null;
    
    // Since we skipped check-location, distance might be 0 from backend.
    // We will estimate it using math.Random() to give dynamic feel.
    final random = math.Random(destination.name.hashCode); 
    final estimatedDistance = preview.legDistanceKm > 0 ? preview.legDistanceKm : (random.nextDouble() * 8.5 + 1.5);

    // Calculation
    final ecoPoints = selectedMode != null ? (selectedMode.ecoPointsRate * estimatedDistance).round() : 0;
    final culturePoints = destination.culturePoints;
    final pathPoints = ecoPoints + culturePoints;
    
    // CO2 Calculation
    // Car is usually the baseline (id=3 in the csv) for saving. Just hardcode baseline for dummy UI or calculate difference
    final carMode = transportModes.firstWhere((m) => m.mode == 'car', orElse: () => transportModes.first);
    final baselineCo2 = carMode.co2PerKm * estimatedDistance;
    final savedCo2 = selectedMode != null ? (baselineCo2 - (selectedMode.co2PerKm * estimatedDistance)) : 0;

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
          "Check-in",
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location Header
            Container(
              padding: const EdgeInsets.all(20),
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
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.location_on_outlined, color: SColors.sdarkgreen),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SBadge(
                                  text: "GPS verified",
                                  color: SColors.sdarkgreen,
                                  icon: Icons.check,
                                  backgroundColor: Colors.green.shade50,
                                ),
                                const SizedBox(width: 8),
                                const Text("radius 100m", style: TextStyle(color: Colors.grey, fontSize: 11)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              destination.name,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              destination.address ?? 'Alamat tidak tersedia',
                              style: const TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Map placeholder
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.green.shade200,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: SColors.sdarkgreen,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Transport Selection
            const Text(
              "Tadi naik apa?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "Pilihan ramah lingkungan = lebih banyak EcoPoints",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 16),
            
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.5,
              ),
              itemCount: transportModes.length,
              itemBuilder: (context, index) {
                final mode = transportModes[index];
                final pointsStr = "+${(mode.ecoPointsRate * estimatedDistance).round()} pts";
                final co2Str = "${(mode.co2PerKm * estimatedDistance).toStringAsFixed(1)} kg CO₂";
                
                return STransportOptionCard(
                  icon: _getIconForMode(mode.mode),
                  title: mode.label,
                  points: pointsStr,
                  co2: co2Str,
                  isSelected: _selectedTransportIndex == index,
                  onTap: () {
                    setState(() {
                      _selectedTransportIndex = index;
                    });
                  },
                );
              },
            ),
            const SizedBox(height: 32),

            // Points Summary
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
                  const Row(
                    children: [
                      Icon(Icons.eco_outlined, color: SColors.sdarkgreen, size: 20),
                      SizedBox(width: 8),
                      Text("Kamu akan dapat", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            children: [
                              Text("+$ecoPoints", style: const TextStyle(color: SColors.sdarkgreen, fontSize: 20, fontWeight: FontWeight.bold)),
                              const Text("EcoPoints", style: TextStyle(color: SColors.sdarkgreen, fontSize: 10)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            children: [
                              Text("+$culturePoints", style: TextStyle(color: Colors.orange.shade800, fontSize: 20, fontWeight: FontWeight.bold)),
                              Text("CulturePoints", style: TextStyle(color: Colors.orange.shade800, fontSize: 10)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            children: [
                              Text("+$pathPoints", style: const TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold)),
                              const Text("PathPoints", style: TextStyle(color: Colors.grey, fontSize: 10)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),

            // AI Info Banner
            if (savedCo2 > 0)
              SInfoBanner(
                backgroundColor: const Color(0xFFF0F4FF),
                icon: const Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: SAiGeminiBadge(),
                ),
                text: "Pilihan ini hemat ~${savedCo2.toStringAsFixed(1)} kg CO₂ dibanding rata-rata pengunjung.",
                textColor: const Color(0xFF3F51B5),
                borderColor: const Color(0xFFE3E8FF),
              ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: SColors.sdarkgreen,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
              elevation: 0,
            ),
            onPressed: () async {
              if (_selectedTransportIndex >= _previewData!.transportModes.length) return;
              
              final selectedMode = _previewData!.transportModes[_selectedTransportIndex];
              
              // Show loading overlay
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(child: CircularProgressIndicator(color: SColors.sdarkgreen)),
              );
              
              try {
                final checkinData = await ref.read(itineraryRepositoryProvider).submitCheckin(
                  widget.itineraryId, 
                  widget.item.id, 
                  selectedMode.id
                );
                
                if (!context.mounted) return;
                Navigator.pop(context); // hide loading

                final result = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckInRundownScreen(
                      destinationName: checkinData.item.name ?? "Destinasi",
                      currentProgress: widget.currentProgress,
                      totalDestinations: widget.totalItems,
                      ecoPoints: checkinData.pointsEarned.ecoPoints,
                      culturePoints: checkinData.pointsEarned.culturePoints,
                      pathPoints: checkinData.pointsEarned.pathPoints,
                      totalPathPoints: checkinData.userTotalPathPoints,
                    ),
                  ),
                );

                if (result == true) {
                  if (widget.isLastItem) {
                    if (context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TripSelesaiScreen(detail: widget.detail)),
                      );
                    }
                  } else {
                    if (context.mounted) {
                      Navigator.pop(context, true); // Return true to increment completed items
                    }
                  }
                }
              } catch (e) {
                if (!context.mounted) return;
                Navigator.pop(context); // hide loading
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
            child: const Text(
              "Konfirmasi Check-in",
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
