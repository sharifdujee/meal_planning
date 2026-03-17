import 'dart:ui';

import 'package:flutter/material.dart';

import 'exercise_screen.dart';

class TimerPanel extends StatelessWidget {
  final String display;
  final double progress;
  final bool isRunning;
  final VoidCallback onPause;
  final VoidCallback onReset;
  final VoidCallback onClose;

  const TimerPanel({
    required this.display,
    required this.progress,
    required this.isRunning,
    required this.onPause,
    required this.onReset,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kTimerBg,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
        border: Border.all(color: kBorder, width: 1),
      ),
      child: Column(
        children: [
          // Progress bar
          ClipRRect(
            borderRadius:
            const BorderRadius.vertical(top: Radius.circular(0)),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: kBorder,
              valueColor:
              const AlwaysStoppedAnimation<Color>(kGreen),
              minHeight: 3,
            ),
          ),

          // Timer row
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Time display
                Text(
                  display,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(width: 8),
                // Bell icon
                const Icon(Icons.alarm_rounded,
                    color: kMuted, size: 18),

                const Spacer(),

                // Pause
                GestureDetector(
                  onTap: onPause,
                  child: Icon(
                    isRunning
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    color: kMuted,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 18),
                // Reset
                GestureDetector(
                  onTap: onReset,
                  child: const Icon(Icons.refresh_rounded,
                      color: kMuted, size: 22),
                ),
                const SizedBox(width: 18),
                // Close
                GestureDetector(
                  onTap: onClose,
                  child: const Icon(Icons.close_rounded,
                      color: kMuted, size: 22),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}