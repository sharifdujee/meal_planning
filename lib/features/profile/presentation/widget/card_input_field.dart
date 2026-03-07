import 'package:flutter/material.dart';

class CardInputField extends StatelessWidget {
  final String hint;
  final IconData icon;
  const CardInputField({super.key, required this.hint, required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white, fontSize: 14),
      cursorColor: const Color(0xFF469271),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 13),
        prefixIcon: Icon(icon, color: Colors.white.withValues(alpha: 0.3), size: 18),
        filled: true,
        fillColor: const Color(0xFF1A1F24),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF469271), width: 1.5),
        ),
      ),
    );
  }
}