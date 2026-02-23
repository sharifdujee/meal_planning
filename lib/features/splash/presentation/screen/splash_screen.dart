import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/icon_path.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(-0.8, -1.0), // top-left glow
            radius: 1.3,
            colors: [
              Color(0xFF1E5F46), // soft green glow
              Color(0xFF0B1F1A), // dark green fade
              Color(0xFF050B12), // deep navy
              Color(0xFF030712), // almost black
            ],
            stops: [0.0, 0.35, 0.75, 1.0],
          ),
        ),
        child: Stack(
          children: [
            /// Center Logo
            Center(
              child: Image.asset(
                IconPath.appLogo,
                width: 260.w,
                height: 150.h,
                fit: BoxFit.contain,
              ),
            ),

            /// Bottom Loader
            Positioned(
              bottom: 50.h,
              left: 0,
              right: 0,
              child: Center(
                child: SpinKitCircle(
                  size: 45.sp,
                  color: const Color(0xFF49B37D), // soft green loader
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}