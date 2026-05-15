import 'package:flutter/material.dart';
import '../../core/savelo_colors.dart';

class SStepperInput extends StatefulWidget {
  final String label;
  final int initialValue;
  final String suffix;
  final ValueChanged<int>? onChanged;

  const SStepperInput({
    super.key,
    required this.label,
    this.initialValue = 1,
    this.suffix = '',
    this.onChanged,
  });

  @override
  State<SStepperInput> createState() => _SStepperInputState();
}

class _SStepperInputState extends State<SStepperInput> {
  late int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  void _increment() {
    setState(() {
      _value++;
      widget.onChanged?.call(_value);
    });
  }

  void _decrement() {
    if (_value > 1) {
      setState(() {
        _value--;
        widget.onChanged?.call(_value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Icon(widget.label == 'Durasi' ? Icons.calendar_today_outlined : Icons.people_outline, color: Colors.grey, size: 16),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: _decrement,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.remove, size: 20),
                ),
              ),
              Expanded(
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "$_value ${widget.suffix}",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: SColors.sbold),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: _increment,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: SColors.sdarkgreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
