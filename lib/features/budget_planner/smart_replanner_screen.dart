import 'package:flutter/material.dart';
import '../../core/savelo_colors.dart';
import '../../shared/widgets/s_ai_gemini_badge.dart';

class SmartReplannerScreen extends StatefulWidget {
  const SmartReplannerScreen({super.key});

  @override
  State<SmartReplannerScreen> createState() => _SmartReplannerScreenState();
}

class _SmartReplannerScreenState extends State<SmartReplannerScreen> {
  final List<Map<String, dynamic>> _swapSuggestions = [
    {
      "tag": "Eco + Hemat",
      "savingsText": "Hemat Rp 85.000",
      "oldTitle": "Tebing Breksi (entry + parkir + ojek)",
      "oldPrice": "Rp 85.000",
      "newTitle": "Bukit Bintang (free + foto sunset)",
      "newPrice": "Gratis",
      "note": "Sama-sama spot sunset, view nggak kalah, gratis & 4.5★ (3.2K ulasan).",
      "isSelected": true,
    },
    {
      "tag": "UMKM",
      "savingsText": "Hemat Rp 40.000",
      "oldTitle": "Makan siang Resto Lokal",
      "oldPrice": "Rp 75.000",
      "newTitle": "Warung Bu Ageng (UMKM)",
      "newPrice": "Rp 35.000",
      "note": "UMKM lokal, halal, 4.8★, jarak 400m dari titik selanjutnya.",
      "isSelected": false,
    },
    {
      "tag": "Eco",
      "savingsText": "Hemat Rp 41.000",
      "oldTitle": "Grab ke hotel (12 km)",
      "oldPrice": "Rp 48.000",
      "newTitle": "TransJogja koridor 3A",
      "newPrice": "Rp 7.000",
      "note": "Hemat 41K + dapat +80 EcoPoints (transport publik).",
      "isSelected": true,
    }
  ];

  void _toggleAll(bool? value) {
    setState(() {
      for (var item in _swapSuggestions) {
        item["isSelected"] = value ?? false;
      }
    });
  }

  void _toggleItem(int index, bool? value) {
    setState(() {
      _swapSuggestions[index]["isSelected"] = value ?? false;
    });
  }

  int get _selectedCount => _swapSuggestions.where((e) => e["isSelected"] as bool).length;

  int get _totalSavings {
    int total = 0;
    for (var item in _swapSuggestions) {
      if (item["isSelected"] as bool) {
        String savingsStr = (item["savingsText"] as String).replaceAll("Hemat Rp ", "").replaceAll(".", "");
        total += int.tryParse(savingsStr) ?? 0;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    bool isAllSelected = _selectedCount == _swapSuggestions.length;

    return Scaffold(
      backgroundColor: const Color(0xFFFBF9F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBF9F6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Smart Re-Planner",
          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Top Section
                  Container(
                    width: double.infinity,
                    color: const Color(0xFFDF9739), // Orange background
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 24),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF5B71F3),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.auto_awesome, color: Colors.white, size: 12),
                                  const SizedBox(width: 4),
                                  const Text("AI Gemini", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text("Budget kamu hampir habis", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(color: Colors.white, fontSize: 14, height: 1.4),
                            children: [
                              TextSpan(text: "Sisa "),
                              TextSpan(text: "Rp 220.000", style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: " untuk 1.5 hari lagi. AI Gemini sudah analisa 12 aktivitas remaining dan menyarankan 3 swap."),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Rp 1.280.000 / Rp 1.500.000", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const Text("85% terpakai", style: TextStyle(color: Color(0xFFDF9739), fontSize: 11, fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: 0.85,
                                  backgroundColor: Colors.white.withOpacity(0.3),
                                  color: Colors.red.shade700,
                                  minHeight: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Suggestions Section
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Saran Swap (3)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            GestureDetector(
                              onTap: () => _toggleAll(!isAllSelected),
                              child: Text(
                                isAllSelected ? "Batal Pilih" : "Pilih Semua",
                                style: const TextStyle(color: SColors.sdarkgreen, fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ...List.generate(_swapSuggestions.length, (index) => _buildSwapCard(index)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Sticky Bottom Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total hemat ($_selectedCount swap)", style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(
                        "Rp ${_totalSavings.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}",
                        style: const TextStyle(color: SColors.sdarkgreen, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SColors.sdarkgreen,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Pop back as requested
                    },
                    child: const Text("Terapkan", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSwapCard(int index) {
    final item = _swapSuggestions[index];
    bool isSelected = item["isSelected"] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isSelected ? SColors.sdarkgreen : Colors.grey.shade200, width: isSelected ? 2 : 1),
        boxShadow: isSelected ? [
          BoxShadow(
            color: SColors.sdarkgreen.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ] : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => _toggleItem(index, !isSelected),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12, top: 4),
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: isSelected ? SColors.sdarkgreen : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: isSelected ? SColors.sdarkgreen : Colors.grey.shade400),
                    ),
                    child: isSelected ? const Icon(Icons.check, color: Colors.white, size: 16) : null,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(item["tag"] as String, style: const TextStyle(color: SColors.sdarkgreen, fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(width: 8),
                          Text(item["savingsText"] as String, style: const TextStyle(color: SColors.sdarkgreen, fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("SEMULA", style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text(
                                  item["oldTitle"] as String,
                                  style: const TextStyle(color: Colors.grey, fontSize: 13, decoration: TextDecoration.lineThrough),
                                ),
                                const SizedBox(height: 4),
                                Text(item["oldPrice"] as String, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                            child: Icon(Icons.arrow_forward, color: SColors.sdarkgreen, size: 16),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("SWAP KE", style: TextStyle(color: SColors.sdarkgreen, fontSize: 10, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text(
                                  item["newTitle"] as String,
                                  style: const TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(item["newPrice"] as String, style: const TextStyle(color: SColors.sdarkgreen, fontSize: 12, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFDF8E7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.auto_awesome, color: Colors.orange, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item["note"] as String,
                      style: const TextStyle(color: Colors.black87, fontSize: 12),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
