

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
import 'package:meal_planning/features/home/presentation/widget/generate_result_bottom_sheet.dart';
import 'package:meal_planning/features/home/presentation/widget/my_product_page.dart';
import 'package:meal_planning/features/navigation/presentation/nav_bar_screen.dart';
import 'package:meal_planning/features/onboarding/onboarding_screen.dart';
import 'package:meal_planning/features/profile/presentation/widget/break_time_screen.dart';
import 'package:meal_planning/features/profile/presentation/widget/dont_like_food_screen.dart';

import 'package:meal_planning/features/profile/presentation/widget/faq.dart';
import 'package:meal_planning/features/profile/presentation/widget/intolerancias.dart';

import 'package:meal_planning/features/profile/presentation/widget/privacy_policy.dart';
import 'package:meal_planning/features/profile/presentation/widget/profile_subscription.dart';
import 'package:meal_planning/features/profile/presentation/widget/regenerate_screen.dart';
import 'package:meal_planning/features/profile/presentation/widget/selection_days_screen.dart';
import 'package:meal_planning/features/profile/presentation/widget/terms_condition.dart';
import 'package:meal_planning/features/profile/presentation/widget/training_duration_screen.dart';


import 'features/profile/presentation/widget/payment_screen.dart';
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
      GoRoute(path: "/terms", builder: (context, state)=>const TermsCondition()),
      GoRoute(path: "/privacy", builder: (context, state)=>const PrivacyPolicy()),
      GoRoute(path: "/faq", builder: (context, state)=>const FrequentlyAskingQuestion()),
      GoRoute(path: "/foodDontLike", builder: (context, state)=> const DontLikeFoodScreen()),
      GoRoute(path: "/IntoleranciasScreen", builder: (context, state)=> const IntoleranciasScreen()),
      GoRoute(path: "/daySelection", builder: (context, state)=> const DaySelectionScreen()),
      GoRoute(path: "/breakTime", builder: (context, state)=> const BreakTimeScreen()),
      GoRoute(path: "/trainingDuration", builder: (context, state)=> const TrainingDurationScreen()),
      GoRoute(path: "/myProduct", builder: (context, state)=> const MyProductPage()),
      GoRoute(path: "/regenerate", builder: (context, state)=> const RegenerateScreen()),
      GoRoute(path: "/profileSubscription", builder: (context, state)=> const ProfileSubscription()),
      GoRoute(path: '/payment', builder: (context, state) =>  const  PaymentScreen(),),
      GoRoute(path: '/generateResult', builder: (context, state) => const GenerateResultBottomSheet(),),


    ],
  );
});