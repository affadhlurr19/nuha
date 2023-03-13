import 'package:get/get.dart';
import 'package:nuha/app/modules/profile/bindings/profile_binding.dart';
import 'package:nuha/app/modules/profile/views/profile_view.dart';
import 'package:nuha/app/modules/reset_password/bindings/reset_password_binding.dart';
import 'package:nuha/app/modules/reset_password/views/reset_password_view.dart';

import '../modules/fincheck/bindings/fincheck_binding.dart';
import '../modules/fincheck/views/fincheck_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/landing/bindings/landing_binding.dart';
import '../modules/landing/views/landing_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/memulai/bindings/memulai_binding.dart';
import '../modules/memulai/views/memulai_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LANDING;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LANDING,
      page: () => const LandingView(),
      binding: LandingBinding(),
    ),
    GetPage(
      name: _Paths.FINCHECK,
      page: () => FincheckView(),
      binding: FincheckBinding(),
    ),
    GetPage(
      name: _Paths.MEMULAI,
      page: () => const MemulaiView(),
      binding: MemulaiBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
