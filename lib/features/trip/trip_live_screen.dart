import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/savelo_colors.dart';
import '../../core/utils/image_helper.dart';
import '../../shared/widgets/s_timeline_item.dart';
import '../budget_planner/models/itinerary.dart';
import '../budget_planner/providers/itinerary_provider.dart';
import '../budget_planner/check_in_screen.dart';

class TripLiveScreen extends ConsumerStatefulWidget {
  final int itineraryId;

  const TripLiveScreen({super.key, required this.itineraryId});

  @override
  ConsumerState<TripLiveScreen> createState() => _TripLiveScreenState();
}

class _TripLiveScreenState extends ConsumerState<TripLiveScreen> {
  int _completedItemsCount = 0;

  @override
  void initState() {
    super.initState();
    _loadCompletedCount();
  }

  Future<void> _loadCompletedCount() async {
    final prefs = await SharedPreferences.getInstance();
    final count = prefs.getInt('completed_items_${widget.itineraryId}') ?? 0;
    if (mounted) {
      setState(() {
        _completedItemsCount = count;
      });
    }
  }

  Future<void> _saveCompletedCount(int count) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('completed_items_${widget.itineraryId}', count);
  }

  Widget _buildSummaryMetric(String title, String mainValue, String subValue) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white70, fontSize: 10)),
            const SizedBox(height: 4),
            Text(mainValue, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 4),
            Text(subValue, style: TextStyle(color: Colors.orange.shade200, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingCard(ItineraryItemData item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(item.visitTime, style: const TextStyle(color: SColors.sdarkgreen, fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.schedule, color: Colors.grey, size: 10),
                  const SizedBox(width: 2),
                  const Text("~1 jam", style: TextStyle(color: Colors.grey, fontSize: 10)),
                ],
              )
            ],
          ),
          const SizedBox(width: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              ImageHelper.getImageForCategory(item.category, item.name ?? item.placeId),
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name ?? 'Destinasi', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text("${item.costLabel} • ${item.mapCategory}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Color _getTagColor(String? mapCategory) {
    switch (mapCategory) {
      case 'umkm': return SColors.sdarkgreen;
      case 'heritage': return Colors.brown;
      case 'iconic': return Colors.blue;
      case 'hidden_gem': return Colors.purple;
      case 'transit': return Colors.orange;
      case 'hotel': return Colors.red;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(itineraryDetailProvider(widget.itineraryId));

    return Scaffold(
      backgroundColor: const Color(0xFFFBF9F6),
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: SColors.sdarkgreen)),
        error: (err, stack) => Center(child: Text("Gagal memuat: $err")),
        data: (detail) {
          // Flatten all items
          List<ItineraryItemData> allItems = [];
          for (var day in detail.itinerary.days) {
            allItems.addAll(day.items);
          }

          final totalItems = allItems.length;
          final completedItems = allItems.sublist(0, _completedItemsCount);
          final currentItem = _completedItemsCount < totalItems ? allItems[_completedItemsCount] : null;
          final upcomingItems = _completedItemsCount + 1 < totalItems ? allItems.sublist(_completedItemsCount + 1) : <ItineraryItemData>[];

          final int budget = detail.itinerary.totalEstimate ~/ (detail.itinerary.budgetPercent / 100);
          final int terpakai = detail.itinerary.totalEstimate.toInt();
          final int tersisa = budget - terpakai;

          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Container(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 16,
                        left: 24,
                        right: 24,
                        bottom: 32,
                      ),
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
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                              ),
                              const Expanded(
                                child: Center(
                                  child: Text("Live Trip", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                                ),
                              ),
                              const SizedBox(width: 20),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle),
                              ),
                              const SizedBox(width: 8),
                              Text("LIVE • PROGRESS ${_completedItemsCount}/${totalItems}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text("Liburan ${detail.request.destinationLabel}", style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              _buildSummaryMetric("Terpakai", "Rp $terpakai", "dari Rp $budget"),
                              _buildSummaryMetric("Tersisa", "Rp $tersisa", "aman ✓"),
                              _buildSummaryMetric("Progress", "${(_completedItemsCount / totalItems * 100).toInt()}%", "selesai"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (currentItem != null) ...[
                            const Text("SEKARANG", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 1.2)),
                            const SizedBox(height: 16),
                            Container(
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
                                          ImageHelper.getImageForCategory(currentItem.category, currentItem.name ?? currentItem.placeId),
                                          height: 140,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: 12,
                                        left: 12,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                          decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(12)),
                                          child: Text("Sedang di sini", style: TextStyle(color: Colors.orange.shade900, fontSize: 10, fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(currentItem.name ?? 'Destinasi', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            const Icon(Icons.location_on_outlined, color: Colors.grey, size: 14),
                                            const SizedBox(width: 4),
                                            Text("${currentItem.mapCategory} • ${currentItem.costLabel}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: SColors.sdarkgreen,
                                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                                                  elevation: 0,
                                                ),
                                                onPressed: () async {
                                                  final isLast = (_completedItemsCount + 1) == totalItems;
                                                  final success = await Navigator.push<bool>(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => CheckInScreen(
                                                      itineraryId: widget.itineraryId,
                                                      item: currentItem,
                                                      isLastItem: isLast,
                                                      detail: detail,
                                                      currentProgress: _completedItemsCount + 1,
                                                      totalItems: totalItems,
                                                    )),
                                                  );
                                                  
                                                  if (success == true) {
                                                    setState(() {
                                                      _completedItemsCount++;
                                                    });
                                                    _saveCompletedCount(_completedItemsCount);
                                                  }
                                                },
                                                icon: const Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
                                                label: const Text("Check-in", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),
                          ],

                          if (upcomingItems.isNotEmpty) ...[
                            const Text("BERIKUTNYA", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 1.2)),
                            const SizedBox(height: 16),
                            ...upcomingItems.take(2).map((item) => _buildUpcomingCard(item)),
                            const SizedBox(height: 32),
                          ],

                          // TIMELINE LIST
                          const Text("TIMELINE", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 1.2)),
                          const SizedBox(height: 16),
                          ...allItems.map((item) {
                            final idx = allItems.indexOf(item);
                            final isCompleted = idx < _completedItemsCount;
                            
                            return Opacity(
                              opacity: isCompleted ? 0.5 : 1.0,
                              child: STimelineItem(
                                stepNumber: (idx + 1).toString(),
                                timeText: item.visitTime,
                                title: item.name ?? 'Destinasi',
                                distance: "0 km",
                                tagText: item.mapCategory ?? "DESTINASI",
                                tagColor: _getTagColor(item.mapCategory),
                                price: item.costLabel,
                                isLast: idx == allItems.length - 1,
                                nodeColor: isCompleted ? Colors.grey : _getTagColor(item.mapCategory),
                                onTap: null, // Disabled in live trip unless we want to allow jump checkin
                              ),
                            );
                          }),
                          
                          if (completedItems.isNotEmpty) ...[
                            const SizedBox(height: 32),
                            const Text("SELESAI", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 1.2)),
                            const SizedBox(height: 16),
                            ...completedItems.map((item) => _buildUpcomingCard(item)),
                          ],

                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              Positioned(
                bottom: 24,
                left: 24,
                right: 24,
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SColors.sdarkgreen,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                      elevation: 5,
                    ),
                    onPressed: () {},
                    child: const Text("Buka Navigasi", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
