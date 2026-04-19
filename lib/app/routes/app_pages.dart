import 'package:train_kotai/app/modules/map_tracking/bindings/map_tracking_binding.dart';
import 'package:train_kotai/app/modules/map_tracking/views/map_tracking_view.dart';
import 'package:train_kotai/app/modules/add_post/bindings/add_post_binding.dart';
import 'package:train_kotai/app/modules/add_post/views/add_post_view.dart';
import 'package:train_kotai/app/modules/change_password/bindings/change_password_binding.dart';
import 'package:train_kotai/app/modules/change_password/views/change_password_view.dart';
import 'package:train_kotai/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:train_kotai/app/modules/dashboard/views/dashboard_view.dart';
import 'package:train_kotai/app/modules/share_location/bindings/share_location_binding.dart';
import 'package:train_kotai/app/modules/share_location/views/share_location_view.dart';
import 'package:train_kotai/app/modules/select_route/bindings/select_route_binding.dart';
import 'package:train_kotai/app/modules/select_route/views/select_route_view.dart';
import 'package:train_kotai/app/modules/signup/bindings/signup_binding.dart';
import 'package:train_kotai/app/modules/signup/views/signup_view.dart';
import 'package:train_kotai/app/modules/reset_password/bindings/reset_password_binding.dart';
import 'package:train_kotai/app/modules/reset_password/views/reset_password_view.dart';
import 'package:train_kotai/app/modules/verify_otp/bindings/verify_otp_binding.dart';
import 'package:train_kotai/app/modules/verify_otp/views/verify_otp_view.dart';
import 'package:get/get.dart';
import 'package:train_kotai/app/modules/forgot_password/bindings/forgot_password_binding.dart';
import 'package:train_kotai/app/modules/forgot_password/views/forgot_password_view.dart';
import 'package:train_kotai/app/modules/login/bindings/login_binding.dart';
import 'package:train_kotai/app/modules/login/views/login_view.dart';
import 'package:train_kotai/app/modules/onboarding/bindings/onboarding_binding.dart';
import 'package:train_kotai/app/modules/onboarding/views/onboarding_view.dart';
import 'package:train_kotai/app/modules/splash/bindings/splash_binding.dart';
import 'package:train_kotai/app/modules/splash/views/splash_view.dart';
import 'package:flutter/material.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.DASHBOARD;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY_OTP,
      page: () => const VerifyOtpView(),
      binding: VerifyOtpBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_ROUTE,
      page: () => const SelectRouteView(),
      binding: SelectRouteBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.SHARE_LOCATION,
      page: () => const ShareLocationView(),
      binding: ShareLocationBinding(),
    ),
    GetPage(
      name: _Paths.MAP_TRACKING,
      page: () => const MapTrackingView(),
      binding: MapTrackingBinding(),
    ),
    GetPage(
      name: _Paths.ADD_POST,
      page: () => const AddPostView(),
      binding: AddPostBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(name: _Paths.HOME, page: () => const HomeViewPlaceholder()),
  ];
}

class HomeViewPlaceholder extends StatelessWidget {
  const HomeViewPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Home Page')));
  }
}

// Need to import StatelessWidget
