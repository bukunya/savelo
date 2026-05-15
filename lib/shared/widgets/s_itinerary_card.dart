import 'package:flutter/material.dart';
import '../../core/savelo_colors.dart';
import 's_badge.dart';
import 's_progress_bar.dart';

class SItineraryCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final String price;
  final String budgetPercentageText;
  final double budgetPercentage;
  final List<String> tags;
  final bool isTopPick;
  final VoidCallback onTap;

  const SItineraryCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.budgetPercentageText,
    required this.budgetPercentage,
    required this.tags,
    this.isTopPick = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Header
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Stack(
                children: [
                  Image.network(
                    imagePath,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 100,
                        width: double.infinity,
                        color: Colors.grey.shade200,
                        alignment: Alignment.center,
                        child: const Text('Oops!', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                      );
                    },
                  ),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 16,
                    child: Row(
                      children: [
                        if (title == "Seimbang" || title == "Experience") 
                          Icon(title == "Seimbang" ? Icons.balance : Icons.star_border, color: Colors.white, size: 20),
                        if (title == "Seimbang" || title == "Experience")
                           const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            if (isTopPick)
                              const Text(
                                "Direkomendasikan",
                                style: TextStyle(color: Colors.white70, fontSize: 10),
                              )
                            else if (title == "Experience")
                              const Text(
                                "Maksimalin pengalaman",
                                style: TextStyle(color: Colors.white70, fontSize: 10),
                              )
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (isTopPick)
                    const Positioned(
                      bottom: 12,
                      right: 16,
                      child: SBadge(text: "★ TOP PICK", color: Colors.orange),
                    )
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(description, style: const TextStyle(color: SColors.sparagraph, fontSize: 13)),
                  const SizedBox(height: 16),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total estimasi", style: TextStyle(color: Colors.grey, fontSize: 11)),
                      Text(budgetPercentageText, style: TextStyle(color: budgetPercentage > 0.9 ? Colors.orange : SColors.sdarkgreen, fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(price, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: SColors.sbold)),
                  const SizedBox(height: 8),
                  
                  SProgressBar(
                    percentage: budgetPercentage,
                    activeColor: budgetPercentage > 0.9 ? Colors.orange : SColors.sdarkgreen,
                  ),
                  const SizedBox(height: 16),
                  
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: tags.map((tag) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Text(tag, style: const TextStyle(fontSize: 10, color: SColors.sparagraph, fontWeight: FontWeight.w600)),
                    )).toList(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
