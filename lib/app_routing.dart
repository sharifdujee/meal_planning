

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planning/features/authentication/presentation/screen/create_account_screen.dart';
import 'package:meal_planning/features/authentication/presentation/screen/forgot_otp_screen.dart';
import 'package:meal_planning/features/authentication/presentation/screen/forgot_password_screen.dart';
import 'package:meal_planning/features/authentication/presentation/screen/login_screen.dart';
import 'package:meal_planning/features/authentication/presentation/screen/profile_set_up.dart';
import 'package:meal_planning/features/authentication/presentation/screen/reset_password_screen.dart';
import 'package:meal_planning/features/authentication/presentation/screen/sign_up_otp_verification.dart';
import 'package:meal_planning/features/authentication/presentation/screen/verify_login_otp.dart';
import 'package:meal_planning/features/navigation/presentation/nav_bar_screen.dart';
import 'package:meal_planning/features/onboarding/onboarding_screen.dart';

import 'features/splash/presentation/screen/splash_screen.dart';
import 'features/splash/provider/splash_provider.dart';



final goRouterProvider = Provider<GoRouter>((ref) {
  final isLoading = ref.watch(splashProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final location = state.uri.toString();

      if (isLoading) {
        // While loading, stay on splash
        if (location != '/splash') return '/splash';
      }else {
        // After loading, navigate to onboarding if still on splash
        if (location == '/splash') return '/onBoarding';
      }


      return null; // no redirect
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(path: '/onBoarding',
      builder: (context, state)=> const OnboardingScreen()),
      GoRoute(path: "/login", builder: (context, state)=>const LoginScreen()),
      GoRoute(path: "/loginVerifyOtp", builder: (context, state)=>const LoginVerificationCodeScreen()),
      GoRoute(path: "/forgotPassword", builder: (context, state)=>const ForgotPasswordScreen()),
      GoRoute(path: "/forgotOtpVerification", builder: (context, state)=>const ForgotOtpVerificationCodeScreen()),
      GoRoute(path: "/resetPassword", builder: (context, state)=>const ResetPasswordScreen()),
      GoRoute(path: "/createAccount", builder: (context, state)=>const CreateAccountScreen()),
      GoRoute(path: "/signUpOtpVerification", builder: (context, state)=>const SignupOtpVerificationCodeScreen()),
      GoRoute(path: "/profileSetUp", builder: (context, state)=>const ProfileSetUp()),
      GoRoute(path: "/navBar", builder: (context, state)=>const CustomBottomNavBar()),


    ],
  );
});