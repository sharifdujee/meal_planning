

import 'package:flutter/material.dart';

class FeatureTableRow extends StatelessWidget {
  final String feature;
  final bool hasGratis;
  final bool hasPro;

  const FeatureTableRow({super.key,
    required this.feature,
    required this.hasGratis,
    required this.hasPro,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.07),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Text(
              feature,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 13.5,
                height: 1.4,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: hasGratis
                  ? const Icon(Icons.check_rounded,
                  color: Colors.white, size: 18)
                  : Text(
                '–',
                style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.25), fontSize: 16),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: hasPro
                  ? const Icon(Icons.check_rounded,
                  color: Color(0xFF469271), size: 18)
                  : Text(
                '–',
                style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.25), fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}