import 'package:get/get.dart';

import '../modules/add_note/bindings/add_note_binding.dart';
import '../modules/add_note/views/add_note_view.dart';
import '../modules/cashflow/bindings/cashflow_binding.dart';
import '../modules/cashflow/views/cashflow_view.dart';
import '../modules/daftar_lembaga/bindings/daftar_lembaga_binding.dart';
import '../modules/daftar_lembaga/views/daftar_lembaga_view.dart';
import '../modules/edit_note/bindings/edit_note_binding.dart';
import '../modules/edit_note/views/edit_note_view.dart';
import '../modules/fincheck/bindings/fincheck_binding.dart';
import '../modules/fincheck/views/fincheck_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/landing/bindings/landing_binding.dart';
import '../modules/landing/views/landing_view.dart';
import '../modules/literasi/bindings/literasi_binding.dart';
import '../modules/literasi/views/cari_artikel_view.dart';
import '../modules/literasi/views/detail_artikel_view.dart';
import '../modules/literasi/views/list_artikel_view.dart';
import '../modules/literasi/views/list_video_view.dart';
import '../modules/literasi/views/literasi_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/memulai/bindings/memulai_binding.dart';
import '../modules/memulai/views/memulai_view.dart';
import '../modules/navbar/bindings/navbar_binding.dart';
import '../modules/navbar/views/navbar_view.dart';
import '../modules/perencanaan_keuangan/bindings/perencanaan_keuangan_binding.dart';
import '../modules/perencanaan_keuangan/views/perencanaan_keuangan_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/edit_profile_view.dart';
import '../modules/profile/views/ganti_foto_profil_view.dart';
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
      name: _Paths.NAVBAR,
      page: () => const NavbarView(),
      binding: NavbarBinding(),
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
    GetPage(
      name: _Paths.LITERASI,
      page: () => const LiterasiView(),
      binding: LiterasiBinding(),
    ),
    GetPage(
      name: _Paths.LITERASI_LIST_ARTIKEL,
      page: () => ListArtikelView(),
      binding: LiterasiBinding(),
    ),
    GetPage(
      name: _Paths.LITERASI_LIST_VIDEO,
      page: () => ListVideoView(),
      binding: LiterasiBinding(),
    ),
    GetPage(
      name: _Paths.CARI_ARTIKEL,
      page: () => CariArtikelView(),
      binding: LiterasiBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_ARTIKEL,
      page: () => DetailArtikelView(),
      binding: LiterasiBinding(),
    ),
    GetPage(
      name: _Paths.CASHFLOW,
      page: () => CashflowView(),
      binding: CashflowBinding(),
    ),
    GetPage(
      name: _Paths.PERENCANAAN_KEUANGAN,
      page: () => const PerencanaanKeuanganView(),
      binding: PerencanaanKeuanganBinding(),
    ),
    GetPage(
      name: _Paths.DAFTAR_LEMBAGA,
      page: () => DaftarLembagaView(),
      binding: DaftarLembagaBinding(),
    ),
  ];
}
