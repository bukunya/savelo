import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/savelo_colors.dart';
import '../../shared/widgets/s_ai_gemini_badge.dart';
import '../destinations/providers/destinations_provider.dart';

class DestinasiDetailScreen extends ConsumerWidget {
  final String placeId;
  const DestinasiDetailScreen({super.key, required this.placeId});

  Widget _buildInfoCard(String title, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            Text(title, style: const TextStyle(color: SColors.sparagraph, fontSize: 10, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(color: Colors.black87, fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildAksesibilitasTag(IconData icon, String label) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: SColors.sdarkgreen),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(color: SColors.sdarkgreen, fontSize: 11, fontWeight: FontWeight.bold)),
          const SizedBox(width: 4),
          const Icon(Icons.verified, size: 12, color: SColors.sdarkgreen),
        ],
      ),
    );
  }

  Widget _buildContactAction(IconData icon, String label) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            Icon(icon, color: SColors.sdarkgreen, size: 20),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(color: SColors.sdarkgreen, fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(destinationDetailProvider(placeId));

    return Scaffold(
      backgroundColor: const Color(0xFFFBF9F6), // Slightly warm white background like image
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: SColors.sdarkgreen)),
        error: (err, stack) => Center(child: Text("Gagal memuat: $err")),
        data: (detail) => CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 280.0,
              pinned: true,
              backgroundColor: SColors.sbackground,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      detail.photos.isNotEmpty ? detail.photos.first['url'] ?? "https://www.uii.ac.id/wp-content/uploads/2018/05/Jogja-1-1.jpg" : "https://www.uii.ac.id/wp-content/uploads/2018/05/Jogja-1-1.jpg",
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.4),
                            Colors.transparent,
                            Colors.black.withOpacity(0.8),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 24,
                      left: 24,
                      right: 24,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: SColors.sdarkgreen,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(detail.mapCategory?.toUpperCase() ?? "UMKM", style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.star, color: Colors.orange, size: 14),
                              const SizedBox(width: 4),
                              Text("${detail.rating ?? 'N/A'} (${detail.userRatingCount ?? 0})", style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            detail.name,
                            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, color: Colors.white70, size: 14),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(detail.address ?? detail.city, style: const TextStyle(color: Colors.white70, fontSize: 12), maxLines: 2, overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info Cards
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoCard("Buka", "06:00–17:00"), // TODO: Parse from opening_hours
                      _buildInfoCard("Harga", detail.priceRange.label),
                      _buildInfoCard("Jarak", "1.2 km"), // TODO: Calculate distance
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Aksesibilitas
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.verified_user_outlined, color: SColors.sdarkgreen, size: 18),
                                SizedBox(width: 8),
                                Text("Aksesibilitas Terverifikasi", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text("Tim SAVELO", style: TextStyle(color: SColors.sdarkgreen, fontSize: 10, fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          children: [
                            _buildAksesibilitasTag(Icons.accessible, "Wheelchair"),
                            _buildAksesibilitasTag(Icons.child_friendly, "Stroller"),
                            _buildAksesibilitasTag(Icons.health_and_safety, "Child-Safe"),
                            Container(
                              margin: const EdgeInsets.only(right: 8, bottom: 8),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade50,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.elderly, size: 14, color: Colors.orange.shade800),
                                  const SizedBox(width: 4),
                                  Text("Lansia", style: TextStyle(color: Colors.orange.shade800, fontSize: 11, fontWeight: FontWeight.bold)),
                                  const SizedBox(width: 4),
                                  Icon(Icons.error_outline, size: 12, color: Colors.orange.shade800),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text("Diverifikasi 12 Mar 2026 • Re-check 12 Jun 2026", style: TextStyle(color: Colors.grey, fontSize: 10)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // MicroStory
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const SAiGeminiBadge(),
                            const SizedBox(width: 8),
                            const Text("MicroStory", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          detail.aiMicrostory ?? detail.description ?? "Deskripsi belum tersedia.",
                          style: const TextStyle(color: Colors.black87, fontSize: 13, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Review Trust Score
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Review Trust Score", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            const SAiGeminiBadge(),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text("92", style: TextStyle(color: SColors.sdarkgreen, fontSize: 32, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 4),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 6),
                              child: Text("/ 100 — Trusted", style: TextStyle(color: Colors.grey, fontSize: 12)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const SizedBox(width: 120, child: Text("Google Maps (4.6★)", style: TextStyle(color: Colors.grey, fontSize: 11))),
                            Expanded(
                              child: Container(
                                height: 6,
                                decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: 0.94,
                                  child: Container(decoration: BoxDecoration(color: SColors.sdarkgreen, borderRadius: BorderRadius.circular(4))),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text("94", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const SizedBox(width: 120, child: Text("TikTok Sentiment", style: TextStyle(color: Colors.grey, fontSize: 11))),
                            Expanded(
                              child: Container(
                                height: 6,
                                decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: 0.88,
                                  child: Container(decoration: BoxDecoration(color: SColors.sdarkgreen, borderRadius: BorderRadius.circular(4))),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text("88", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Gemini cocokkan 1.4K review Google Maps & 320 video TikTok — sentimen konsisten positif.",
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  const Text("Kontak Cepat", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildContactAction(Icons.call_outlined, "Call"),
                      _buildContactAction(Icons.chat_bubble_outline, "WhatsApp"),
                      _buildContactAction(Icons.language, "Website"),
                    ],
                  ),
                  const SizedBox(height: 40), // Buffer for bottom nav
                ],
              ),
            ),
          )
        ],
      ),
    ),
    bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -4)),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 56,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: SColors.sdarkgreen),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Lihat Peta", style: TextStyle(color: SColors.sdarkgreen, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SColors.sdarkgreen,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                      elevation: 0,
                    ),
                    onPressed: () {},
                    child: const Text("Tambah ke Itinerary", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
