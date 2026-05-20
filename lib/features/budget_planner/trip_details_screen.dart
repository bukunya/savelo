import 'package:flutter/material.dart';
import '../../core/savelo_colors.dart';
import '../../shared/widgets/s_info_banner.dart';
import '../../shared/widgets/s_progress_bar.dart';
import '../../shared/widgets/s_choice_chip.dart';
import '../../shared/widgets/s_timeline_item.dart';
import 'check_in_screen.dart';

class TripDetailsScreen extends StatefulWidget {
  const TripDetailsScreen({super.key});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  int _selectedDayIndex = 0;

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
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
                        child: const Text(
                          "72%",
                          style: TextStyle(
                            color: SColors.sdarkgreen,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Rp 1.075.000",
                        style: TextStyle(
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
                          "/ Rp 1.500.000",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const SProgressBar(percentage: 0.72),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Destinasi: Rp 225.000",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        "Transport: Rp 850.000",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Smart Re-planner
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
                  "Sisa budget 3% — Gemini saran ganti taksi ke TransJogja, hemat ~Rp 80K.",
              textColor: Colors.brown.shade800,
              borderColor: Colors.orange.shade200,
              trailing: const Icon(Icons.chevron_right, color: Colors.orange),
            ),
            const SizedBox(height: 24),

            // Days Tabs
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SChoiceChip(
                    label: "Hari 1",
                    isSelected: _selectedDayIndex == 0,
                    onTap: () => setState(() => _selectedDayIndex = 0),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SChoiceChip(
                    label: "Hari 2",
                    isSelected: _selectedDayIndex == 1,
                    onTap: () => setState(() => _selectedDayIndex = 1),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SChoiceChip(
                    label: "Hari 3",
                    isSelected: _selectedDayIndex == 2,
                    onTap: () => setState(() => _selectedDayIndex = 2),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Timeline
            ..._buildTimelineItems(context),
            const SizedBox(height: 80), // Buffer for bottom actions
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
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
                  onPressed: () {},
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
                  onPressed: () {},
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

  List<Widget> _buildTimelineItems(BuildContext context) {
    if (_selectedDayIndex == 0) {
      // Hari 1: 5 items
      return [
        STimelineItem(
          stepNumber: "1",
          timeText: "08:00",
          title: "Stasiun Tugu (Tiba)",
          distance: "1.4 km",
          tagText: "Transit",
          tagColor: Colors.blueAccent,
          price: "Gratis",
          nodeColor: Colors.blueAccent,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckInScreen())),
        ),
        STimelineItem(
          stepNumber: "2",
          timeText: "10:00",
          title: "Pasar Beringharjo",
          distance: "1.8 km",
          tagText: "UMKM",
          tagColor: SColors.sdarkgreen,
          price: "Rp 50.000",
          nodeColor: SColors.sdarkgreen,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckInScreen())),
        ),
        STimelineItem(
          stepNumber: "3",
          timeText: "12:30",
          title: "Soto Kadipiro",
          distance: "2.2 km",
          tagText: "UMKM",
          tagColor: SColors.sdarkgreen,
          price: "Rp 35.000",
          nodeColor: SColors.sdarkgreen,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckInScreen())),
        ),
        STimelineItem(
          stepNumber: "4",
          timeText: "14:00",
          title: "Keraton Yogyakarta",
          distance: "5.7 km",
          tagText: "Heritage",
          tagColor: Colors.brown,
          price: "Rp 15.000",
          nodeColor: Colors.brown,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckInScreen())),
        ),
        STimelineItem(
          stepNumber: "5",
          timeText: "17:00",
          title: "Tugu Pal Putih",
          distance: "5.5 km",
          tagText: "Iconic",
          tagColor: Colors.blue,
          price: "Gratis",
          isLast: true,
          nodeColor: Colors.blue,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckInScreen())),
        ),
      ];
    } else if (_selectedDayIndex == 1) {
      // Hari 2: 3 items
      return [
        STimelineItem(
          stepNumber: "1",
          timeText: "09:00",
          title: "Prambanan Temple",
          distance: "15 km",
          tagText: "Heritage",
          tagColor: Colors.brown,
          price: "Rp 50.000",
          nodeColor: Colors.brown,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckInScreen())),
        ),
        STimelineItem(
          stepNumber: "2",
          timeText: "13:00",
          title: "Gudeg Yu Djum",
          distance: "4.0 km",
          tagText: "UMKM",
          tagColor: SColors.sdarkgreen,
          price: "Rp 40.000",
          nodeColor: SColors.sdarkgreen,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckInScreen())),
        ),
        STimelineItem(
          stepNumber: "3",
          timeText: "16:00",
          title: "Malioboro Walk",
          distance: "4.1 km",
          tagText: "Iconic",
          tagColor: Colors.blue,
          price: "Gratis",
          isLast: true,
          nodeColor: Colors.blue,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckInScreen())),
        ),
      ];
    } else {
      // Hari 3: 2 items
      return [
        STimelineItem(
          stepNumber: "1",
          timeText: "07:00",
          title: "Hutan Pinus Mangunan",
          distance: "22 km",
          tagText: "Nature",
          tagColor: Colors.green,
          price: "Rp 15.000",
          nodeColor: Colors.green,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckInScreen())),
        ),
        STimelineItem(
          stepNumber: "2",
          timeText: "11:00",
          title: "Kopi Klotok",
          distance: "10 km",
          tagText: "UMKM",
          tagColor: SColors.sdarkgreen,
          price: "Rp 35.000",
          isLast: true,
          nodeColor: SColors.sdarkgreen,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckInScreen())),
        ),
      ];
    }
  }
}
