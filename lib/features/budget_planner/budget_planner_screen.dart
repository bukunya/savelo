import 'package:flutter/material.dart';
import '../../core/savelo_colors.dart';
import '../../shared/widgets/s_stepper_input.dart';
import '../../shared/widgets/s_choice_chip.dart';
import '../../shared/widgets/s_info_banner.dart';
import '../../shared/widgets/s_location_input.dart';
import '../../shared/widgets/s_ai_gemini_badge.dart';
import 'loading_itinerary_screen.dart';

class BudgetPlannerScreen extends StatefulWidget {
  const BudgetPlannerScreen({super.key});

  @override
  State<BudgetPlannerScreen> createState() => _BudgetPlannerScreenState();
}

class _BudgetPlannerScreenState extends State<BudgetPlannerScreen> {
  final TextEditingController _budgetController = TextEditingController(text: "1.500.000");
  final List<int> _budgetOptions = List.generate(20, (index) => (index + 1) * 500000);
  
  final List<String> _filters = ["Wheelchair", "Stroller Friendly", "Child-Safe", "Lansia Friendly"];
  final Set<int> _selectedFilters = {};

  final TextEditingController _asalController = TextEditingController(text: "Jakarta");
  final TextEditingController _destinasiController = TextEditingController(text: "Surabaya");

  int _durationDays = 3;
  int _numPeople = 2;

  String _formatCurrency(int value) {
    return value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
  }

  void _onBudgetSubmitted(String value) {
    String cleanValue = value.replaceAll(".", "").replaceAll("Rp", "").replaceAll(" ", "");
    int parsed = int.tryParse(cleanValue) ?? 1500000;
    if (parsed < 100000) parsed = 100000;
    if (parsed > 10000000) parsed = 10000000;
    
    setState(() {
      _budgetController.text = _formatCurrency(parsed);
    });
  }

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
        title: const Text("Buat Itinerary", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Berapa budget kamu?", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: SColors.sbold)),
            const SizedBox(height: 4),
            const Text("Total untuk seluruh trip - kami akan susun supaya cukup.", style: TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 24),

            // Budget Input Box
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 4, right: 4),
                        child: Text("Rp", style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold)),
                      ),
                      IntrinsicWidth(
                        child: TextField(
                          controller: _budgetController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: SColors.sdarkgreen, height: 1),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                          onSubmitted: _onBudgetSubmitted,
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            _onBudgetSubmitted(_budgetController.text);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Rp 100K", style: TextStyle(color: Colors.grey, fontSize: 11)),
                      Text("Rp 10jt", style: TextStyle(color: Colors.grey, fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(_budgetOptions.length, (index) {
                        int amount = _budgetOptions[index];
                        String label = "Rp ${_formatCurrency(amount)}";
                        String cleanCurrent = _budgetController.text.replaceAll(".", "");
                        bool isSelected = amount.toString() == cleanCurrent;
                        
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: SChoiceChip(
                            label: label,
                            isSelected: isSelected,
                            onTap: () {
                              setState(() {
                                _budgetController.text = _formatCurrency(amount);
                              });
                            },
                          ),
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Locations
            SLocationInput(
              label: "Asal",
              hint: "Masukkan kota asal",
              icon: const Icon(Icons.location_on_outlined, color: SColors.sdarkgreen, size: 20),
              controller: _asalController,
            ),
            SLocationInput(
              label: "Destinasi",
              hint: "Masukkan kota tujuan",
              icon: const Icon(Icons.location_on_outlined, color: Colors.orange, size: 20),
              controller: _destinasiController,
            ),
            const SizedBox(height: 12),

            // Duration & People
            Row(
              children: [
                Expanded(child: SStepperInput(
                  label: "Durasi", 
                  initialValue: 3, 
                  suffix: "hari",
                  onChanged: (val) => setState(() => _durationDays = val),
                )),
                const SizedBox(width: 12),
                Expanded(child: SStepperInput(
                  label: "Orang", 
                  initialValue: 2,
                  onChanged: (val) => setState(() => _numPeople = val),
                )),
              ],
            ),
            const SizedBox(height: 32),

            // Filters
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Filter Inklusivitas", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text("opsional", style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 4),
            const Text("Hanya destinasi terverifikasi yang ditampilkan.", style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 12,
              children: List.generate(_filters.length, (index) {
                return SChoiceChip(
                  label: _filters[index],
                  isSelected: _selectedFilters.contains(index),
                  onTap: () {
                    setState(() {
                      if (_selectedFilters.contains(index)) {
                        _selectedFilters.remove(index);
                      } else {
                        _selectedFilters.add(index);
                      }
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 32),

            // Info Banner
            SInfoBanner(
              backgroundColor: const Color(0xFFF0F4FF),
              icon: const Padding(
                padding: EdgeInsets.only(top: 2),
                child: SAiGeminiBadge(),
              ),
              text: "Berdasarkan input kamu, Gemini akan mempertimbangkan ~24 destinasi UMKM & ikonik di Yogyakarta.",
              textColor: const Color(0xFF3F51B5),
              borderColor: const Color(0xFFE3E8FF),
            ),
            
            const SizedBox(height: 40),

            // Bottom Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: SColors.sdarkgreen,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                  elevation: 0,
                ),
                onPressed: () {
                  String cleanBudget = _budgetController.text.replaceAll(".", "").replaceAll("Rp", "").replaceAll(" ", "");
                  int parsedBudget = int.tryParse(cleanBudget) ?? 1500000;
                  
                  final requestBody = {
                    "origin": _asalController.text,
                    "destination_label": _destinasiController.text,
                    "duration_days": _durationDays,
                    "num_people": _numPeople,
                    "budget": parsedBudget
                  };
                  
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoadingItineraryScreen(requestBody: requestBody)));
                },
                child: const Text("Generate Itinerary", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
