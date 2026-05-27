import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/savelo_colors.dart';
import '../../shared/widgets/s_info_banner.dart';
import '../../shared/widgets/s_progress_bar.dart';
import '../../shared/widgets/s_choice_chip.dart';
import '../../shared/widgets/s_timeline_item.dart';
import 'smart_replanner_screen.dart';
import 'providers/itinerary_provider.dart';
import 'models/itinerary.dart';

class TripDetailsScreen extends ConsumerStatefulWidget {
  final int itineraryId;

  const TripDetailsScreen({super.key, required this.itineraryId});

  @override
  ConsumerState<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends ConsumerState<TripDetailsScreen> {
  int _selectedDayIndex = 0;

  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(itineraryDetailProvider(widget.itineraryId));
    final detail = asyncData.valueOrNull?.itinerary;
    final request = asyncData.valueOrNull?.request;

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
          "Trip ke Yogyakarta",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: asyncData.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text("Error: $e")),
        data: (data) {
          final detail = data.itinerary;
          final request = data.request;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Live Budget Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.account_balance_wallet_outlined,
                                color: SColors.sdarkgreen,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                "Live Budget",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "${detail.budgetPercent}%",
                              style: const TextStyle(
                                color: SColors.sdarkgreen,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                // ignore: deprecated_member_use
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Rp ${_formatCurrency(detail.totalEstimate)}",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: SColors.sdarkgreen,
                              height: 1,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Text(
                              "/ Rp ${_formatCurrency(request.budget)}",
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SProgressBar(percentage: detail.budgetPercent / 100),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Smart Re-planner
                if (detail.budgetPercent >= 75)
                  SInfoBanner(
                    backgroundColor: const Color(0xFFFFF8E1),
                    icon: const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.orange,
                        size: 20,
                      ),
                    ),
                    text:
                        "Sisa budget ${100 - detail.budgetPercent}% — Gemini menyarankan itinerary ini yang sesuai preferensi.",
                    textColor: Colors.brown.shade800,
                    borderColor: Colors.orange.shade200,
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.orange,
                    ),
                  ),
                if (detail.budgetPercent >= 75) const SizedBox(height: 24),

                // Days Tabs
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: detail.days.map((day) {
                      int idx = detail.days.indexOf(day);
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SChoiceChip(
                          label: "Hari ${day.dayNumber}",
                          isSelected: _selectedDayIndex == idx,
                          onTap: () => setState(() => _selectedDayIndex = idx),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 32),

                // Timeline
                ..._buildTimelineItems(
                  context,
                  detail.days.isEmpty ? null : detail.days[_selectedDayIndex],
                ),
                const SizedBox(height: 80), // Buffer for bottom actions
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: detail == null || request == null
          ? null
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 56,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: SColors.sdarkgreen),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        icon: const Icon(
                          Icons.edit_outlined,
                          color: SColors.sdarkgreen,
                          size: 18,
                        ),
                        label: const Text(
                          "Edit",
                          style: TextStyle(
                            color: SColors.sdarkgreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SmartReplannerScreen(
                                currentEstimate: detail.totalEstimate.toInt(),
                                totalBudget: request.budget.toInt(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: SColors.sdarkgreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setInt(
                            'active_trip_id',
                            widget.itineraryId,
                          );

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Trip berhasil dimulai! Lihat di tab Trip Saya.',
                                ),
                              ),
                            );
                            Navigator.popUntil(
                              context,
                              (route) => route.isFirst,
                            );
                          }
                        },
                        child: const Text(
                          "Mulai Trip",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  String _formatCurrency(num value) {
    return value
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
  }

  Color _getTagColor(String? mapCategory) {
    switch (mapCategory) {
      case 'umkm':
        return SColors.sdarkgreen;
      case 'heritage':
        return Colors.brown;
      case 'iconic':
        return Colors.blue;
      case 'hidden_gem':
        return Colors.purple;
      case 'transit':
        return Colors.orange;
      case 'hotel':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  List<Widget> _buildTimelineItems(
    BuildContext context,
    ItineraryDayData? dayData,
  ) {
    if (dayData == null || dayData.items.isEmpty) {
      return [const Text("Tidak ada rencana untuk hari ini.")];
    }

    return dayData.items.map((item) {
      bool isLast = dayData.items.indexOf(item) == dayData.items.length - 1;
      return STimelineItem(
        stepNumber: "${item.orderIndex}",
        timeText: item.visitTime,
        title: item.name ?? "Destinasi",
        distance: item.legToNext != null
            ? "${item.legToNext!.distanceKm} km"
            : "",
        tagText: item.mapCategory != null
            ? item.mapCategory!.toUpperCase()
            : "UMUM",
        tagColor: _getTagColor(item.mapCategory),
        price: item.costLabel,
        isLast: isLast,
        nodeColor: _getTagColor(item.mapCategory),
        onTap: null, // Disabled in preview mode
      );
    }).toList();
  }
}
