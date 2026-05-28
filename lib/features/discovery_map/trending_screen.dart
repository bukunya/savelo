import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/savelo_colors.dart';
import '../../core/utils/image_helper.dart';
import '../../shared/widgets/s_ai_gemini_badge.dart';
import '../destinations/providers/destinations_provider.dart';
import '../destinations/models/destination.dart';

class TrendingScreen extends ConsumerWidget {
  const TrendingScreen({super.key});

  Widget _buildTopTrendingCard(DestinationSummary topDest) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(ImageHelper.getImageForCategory(topDest.category, topDest.placeId)),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black.withOpacity(0.1), Colors.black.withOpacity(0.8)],
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.local_fire_department, color: Colors.white, size: 14),
                  SizedBox(width: 4),
                  Text("#1 Minggu ini", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                ],
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: const Icon(Icons.favorite, color: Colors.red, size: 16),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: SColors.sdarkgreen, borderRadius: BorderRadius.circular(8)),
                      child: Text(topDest.category.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(topDest.name, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, color: Colors.white70, size: 14),
                        const SizedBox(width: 4),
                        Text(topDest.city, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                    Text(topDest.priceRange.label, style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 14)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTrendingItemCard({
    required String rank,
    required String title,
    required String location,
    required String rating,
    required String reviews,
    required String tagText,
    required Color tagColor,
    required String price,
    required String imageUrl,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(width: 80, height: 80, color: Colors.grey.shade300, child: const Icon(Icons.image, color: Colors.grey)),
                ),
              ),
              Positioned(
                top: 4,
                left: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(rank, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), overflow: TextOverflow.ellipsis)),
                    const Icon(Icons.favorite_border, color: Colors.grey, size: 16),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, color: Colors.grey, size: 12),
                    const SizedBox(width: 4),
                    Text(location, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 12),
                    const SizedBox(width: 4),
                    Text("$rating ($reviews)", style: const TextStyle(color: Colors.grey, fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: tagColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(tagText, style: TextStyle(color: tagColor, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                    Text(price, style: const TextStyle(color: SColors.sdarkgreen, fontWeight: FontWeight.bold, fontSize: 12)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final destState = ref.watch(destinationsProvider(null));
    
    return Scaffold(
      backgroundColor: const Color(0xFFFBF9F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBF9F6),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Tren Minggu Ini",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Banner
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade400,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.local_fire_department, color: Colors.white, size: 32),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Tren Wisata Minggu Ini", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                              const SizedBox(height: 4),
                              Text("Update tiap Senin • Berbasis aktivitas pengguna SAVELO", style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 10)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const SAiGeminiBadge(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Search
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 12),
                        Text("Cari destinasi tren...", style: TextStyle(color: Colors.grey, fontSize: 14)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Filters
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: SColors.sdarkgreen,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            children: [
                              Text("Semua", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                              SizedBox(width: 4),
                              Icon(Icons.check, color: Colors.white, size: 14),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: const Text("Trending", style: TextStyle(color: Colors.black87, fontSize: 12)),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: const Text("UMKM", style: TextStyle(color: Colors.black87, fontSize: 12)),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: const Text("Accessible", style: TextStyle(color: Colors.black87, fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  destState.when(
                    data: (destinations) {
                      if (destinations.isEmpty) return const SizedBox.shrink();
                      
                      final random = math.Random(DateTime.now().hour); // shuffle per hour
                      final list = List.of(destinations)..shuffle(random);
                      final topDest = list.first;
                      final otherTrending = list.skip(1).take(5).toList();

                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(text: "${1 + otherTrending.length} ", style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                                    const TextSpan(text: "destinasi tren", style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.grey.shade300),
                                ),
                                child: const Row(
                                  children: [
                                    Text("Urutkan: ", style: TextStyle(color: Colors.grey, fontSize: 10)),
                                    Text("Trending", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 10)),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildTopTrendingCard(topDest),
                          const SizedBox(height: 16),
                          ...List.generate(otherTrending.length, (index) {
                            final dest = otherTrending[index];
                            return _buildTrendingItemCard(
                              rank: "#${index + 2}",
                              title: dest.name,
                              location: dest.city,
                              rating: dest.rating?.toStringAsFixed(1) ?? "4.5",
                              reviews: "${math.Random().nextInt(1000) + 100}",
                              tagText: "📈 Trending",
                              tagColor: Colors.orange.shade800,
                              price: dest.priceRange.label,
                              imageUrl: ImageHelper.getImageForCategory(dest.category, dest.placeId),
                            );
                          }),
                        ],
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (_, __) => const Text("Gagal memuat destinasi tren"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
