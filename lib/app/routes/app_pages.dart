import 'package:get/get.dart';
import 'package:nuha/app/modules/profile/views/ganti_foto_profil_view.dart';

import '../modules/add_note/bindings/add_note_binding.dart';
import '../modules/add_note/views/add_note_view.dart';
import '../modules/edit_note/bindings/edit_note_binding.dart';
import '../modules/edit_note/views/edit_note_view.dart';
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
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/edit_profile_view.dart';
import '../modules/profile/views/ganti_kata_sandi_view.dart';
import '../modules/profile/views/pengaturan_keamanan_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LANDING;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
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
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.PENGATURAN_KEAMANAN,
      page: () => const PengaturanKeamananView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.GANTI_KATA_SANDI,
      page: () => GantiKataSandiView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ADD_NOTE,
      page: () => const AddNoteView(),
      binding: AddNoteBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_NOTE,
      page: () => const EditNoteView(),
      binding: EditNoteBinding(),
    ),
    GetPage(
      name: _Paths.GANTI_FOTO_PROFIL,
      page: () => GantiFotoProfilView(),
      binding: ProfileBinding(),
    ),
  ];
}
