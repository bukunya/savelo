import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/savelo_colors.dart';
import '../../core/utils/image_helper.dart';
import 'providers/favorites_provider.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoritesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFBF9F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBF9F6),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Tersimpan",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: favoritesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: SColors.sdarkgreen)),
        error: (err, stack) => Center(child: Text("Gagal memuat: $err")),
        data: (favorites) {
          if (favorites.isEmpty) {
            return const Center(child: Text("Belum ada destinasi tersimpan."));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.75, // Adjust for card height
            ),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final dest = favorites[index];
              return _buildCard(
                context,
                ref,
                id: dest.id,
                title: dest.name,
                location: dest.address ?? dest.city,
                rating: dest.rating?.toString() ?? "-",
                price: dest.priceRange ?? dest.priceTier ?? "-",
                imageUrl: ImageHelper.getImageForCategory(dest.category, dest.placeId),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    WidgetRef ref, {
    required int id,
    required String title,
    required String location,
    required String rating,
    required String price,
    String? imageUrl,
    bool hasDiscount = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                  child: imageUrl != null
                      ? Image.network(
                          imageUrl,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
                        )
                      : _buildPlaceholder(),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      ref.read(favoritesProvider.notifier).toggleFavorite(id);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.favorite, color: Colors.red.shade600, size: 16),
                    ),
                  ),
                ),
                if (hasDiscount)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDF1DC), // Light orange
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.discount_outlined, color: Colors.orange.shade800, size: 10),
                          const SizedBox(width: 4),
                          Text("Harga turun", style: TextStyle(color: Colors.orange.shade800, fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  )
              ],
            ),
          ),
          // Info Section
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, color: Colors.grey, size: 12),
                    const SizedBox(width: 4),
                    Expanded(child: Text(location, style: const TextStyle(color: Colors.grey, fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 12),
                        const SizedBox(width: 4),
                        Text(rating, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                    Expanded(
                      child: Text(
                        price, 
                        style: const TextStyle(color: SColors.sdarkgreen, fontWeight: FontWeight.bold, fontSize: 12),
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey.shade100,
      child: Center(
        child: Icon(Icons.image_outlined, color: Colors.grey.shade400, size: 48),
      ),
    );
  }
}
