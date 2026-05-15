import 'package:flutter/material.dart';
import 's_badge.dart';

class SDestinationCard extends StatelessWidget {
  final String title;
  final String location;
  final String priceRange;
  final String imageUrl;
  final bool isVerified;

  const SDestinationCard({
    super.key,
    required this.title,
    required this.location,
    required this.priceRange,
    required this.imageUrl,
    this.isVerified = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Image.network(
                  imageUrl,
                  height: 120,
                  width: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 120,
                      width: 200,
                      color: Colors.grey.shade200,
                      alignment: Alignment.center,
                      child: const Text('Oops!', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                    );
                  },
                ),
              ),
              if (isVerified)
                const Positioned(
                  top: 8,
                  left: 8,
                  child: SBadge(
                    text: "Verified",
                    color: Colors.blue,
                    icon: Icons.verified,
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  location,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Text(
                  priceRange,
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
