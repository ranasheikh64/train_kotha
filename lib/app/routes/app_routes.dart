part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const ONBOARDING = _Paths.ONBOARDING;
  static const LOGIN = _Paths.LOGIN;
  static const FORGOT_PASSWORD = _Paths.FORGOT_PASSWORD;
  static const VERIFY_OTP = _Paths.VERIFY_OTP;
  static const RESET_PASSWORD = _Paths.RESET_PASSWORD;
  static const SIGNUP = _Paths.SIGNUP;
  static const SELECT_ROUTE = _Paths.SELECT_ROUTE;
  static const DASHBOARD = _Paths.DASHBOARD;
  static const SHARE_LOCATION = _Paths.SHARE_LOCATION;
  static const MAP_TRACKING = _Paths.MAP_TRACKING;
  static const HOME = _Paths.HOME;
  static const ADD_POST = _Paths.ADD_POST;
  static const CHANGE_PASSWORD = _Paths.CHANGE_PASSWORD;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const ONBOARDING = '/onboarding';
  static const LOGIN = '/login';
  static const FORGOT_PASSWORD = '/forgot-password';
  static const VERIFY_OTP = '/verify-otp';
  static const RESET_PASSWORD = '/reset-password';
  static const SIGNUP = '/signup';
  static const SELECT_ROUTE = '/select-route';
  static const DASHBOARD = '/dashboard';
  static const SHARE_LOCATION = '/share-location';
  static const MAP_TRACKING = '/map-tracking';
  static const HOME = '/home';
  static const ADD_POST = '/add-post';
  static const CHANGE_PASSWORD = '/change-password';
}
