import 'package:flutter/material.dart';
import '../../core/savelo_colors.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.75, // Adjust for card height
        children: [
          _buildCard(
            context,
            title: "Pasar Beringharjo",
            location: "Yogyakarta",
            rating: "4.6",
            price: "Rp 0",
            imageUrl: "https://images.unsplash.com/photo-1596404981149-8d07018301ec?auto=format&fit=crop&q=80&w=400",
          ),
          _buildCard(
            context,
            title: "Hutan Pinus Mangunan",
            location: "Bantul, DIY",
            rating: "4.8",
            price: "Rp 5K",
            imageUrl: "https://images.unsplash.com/photo-1590118367980-863a3d5f30cb?auto=format&fit=crop&q=80&w=400",
            hasDiscount: true,
          ),
          _buildCard(
            context,
            title: "Candi Prambanan",
            location: "Sleman",
            rating: "4.7",
            price: "Rp 50K",
            imageUrl: null, // to show placeholder
          ),
          _buildCard(
            context,
            title: "Kopi Klotok",
            location: "Sleman",
            rating: "4.7",
            price: "Rp 20K",
            imageUrl: "https://images.unsplash.com/photo-1511920170033-f8396924c348?auto=format&fit=crop&q=80&w=400",
          ),
          _buildCard(
            context,
            title: "Tugu Pal Putih",
            location: "Yogyakarta",
            rating: "4.5",
            price: "Gratis",
            imageUrl: "https://images.unsplash.com/photo-1555513220-db63c1a8bd32?auto=format&fit=crop&q=80&w=400",
          ),
          _buildCard(
            context,
            title: "Gudeg Yu Djum",
            location: "Yogyakarta",
            rating: "4.6",
            price: "Rp 30K",
            imageUrl: "https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&q=80&w=400",
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
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
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.favorite, color: Colors.red.shade600, size: 16),
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
                    Text(price, style: const TextStyle(color: SColors.sdarkgreen, fontWeight: FontWeight.bold, fontSize: 12)),
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
