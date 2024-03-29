import 'package:get/get.dart';

import '../modules/cashflow/bindings/cashflow_binding.dart';
import '../modules/cashflow/views/anggaran_create_view.dart';
import '../modules/cashflow/views/anggaran_view.dart';
import '../modules/cashflow/views/cashflow_view.dart';
import '../modules/cashflow/views/laporankeuangan_view.dart';
import '../modules/daftar_lembaga/bindings/daftar_lembaga_binding.dart';
import '../modules/daftar_lembaga/views/daftar_lembaga_view.dart';
import '../modules/fincheck/bindings/fincheck_binding.dart';
import '../modules/fincheck/views/fincheck_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/konsultasi/bindings/konsultasi_binding.dart';
import '../modules/konsultasi/views/create_jadwal_konsultasi_view.dart';
import '../modules/konsultasi/views/create_pesanan_konsultasi_view.dart';
import '../modules/konsultasi/views/history_consultation_view.dart';
import '../modules/konsultasi/views/list_konsultasi_view.dart';
import '../modules/landing/bindings/landing_binding.dart';
import '../modules/landing/views/landing_view.dart';
import '../modules/literasi/bindings/literasi_binding.dart';
import '../modules/literasi/views/bookmarked_artikel_view.dart';
import '../modules/literasi/views/bookmarked_video_view.dart';
import '../modules/literasi/views/bookmarked_view.dart';
import '../modules/literasi/views/cari_artikel_view.dart';
import '../modules/literasi/views/cari_video_view.dart';
import '../modules/literasi/views/detail_artikel_view.dart';
import '../modules/literasi/views/detail_video_view.dart';
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
import '../modules/perencanaan_keuangan/views/pk_darurat_view.dart';
import '../modules/perencanaan_keuangan/views/pk_kendaraan_view.dart';
import '../modules/perencanaan_keuangan/views/pk_pendidikan_view.dart';
import '../modules/perencanaan_keuangan/views/pk_pensiun_view.dart';
import '../modules/perencanaan_keuangan/views/pk_pernikahan_view.dart';
import '../modules/perencanaan_keuangan/views/pk_rumah_view.dart';
import '../modules/perencanaan_keuangan/views/pk_umroh_view.dart';
import '../modules/perencanaan_keuangan/views/rs_darurat_view.dart';
import '../modules/perencanaan_keuangan/views/rs_kendaraan_view.dart';
import '../modules/perencanaan_keuangan/views/rs_pendidikan_view.dart';
import '../modules/perencanaan_keuangan/views/rs_pensiun_view.dart';
import '../modules/perencanaan_keuangan/views/rs_pernikahan_view.dart';
import '../modules/perencanaan_keuangan/views/rs_rumah_view.dart';
import '../modules/perencanaan_keuangan/views/rs_umroh_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/auth_pin_view.dart';
import '../modules/profile/views/bantuan_view.dart';
import '../modules/profile/views/confirmation_pin_view.dart';
import '../modules/profile/views/create_pin_view.dart';
import '../modules/profile/views/edit_pin_view.dart';
import '../modules/profile/views/edit_profile_view.dart';
import '../modules/profile/views/ganti_foto_profil_view.dart';
import '../modules/profile/views/ganti_kata_sandi_view.dart';
import '../modules/profile/views/hubungi_kami_view.dart';
import '../modules/profile/views/pengaturan_keamanan_view.dart';
import '../modules/profile/views/pengaturan_notifikasi_view.dart';
import '../modules/profile/views/pin_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profile/views/reset_pin_on_auth_view.dart';
import '../modules/profile/views/reset_pin_view.dart';
import '../modules/profile/views/snk_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/zis/bindings/zis_binding.dart';
import '../modules/zis/views/zis_view.dart';

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
      page: () => PengaturanKeamananView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.GANTI_KATA_SANDI,
      page: () => GantiKataSandiView(),
      binding: ProfileBinding(),
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
      name: _Paths.BOOKMARKED,
      page: () => const BookmarkedView(),
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
      name: _Paths.ANGGARAN,
      page: () => AnggaranView(),
      binding: CashflowBinding(),
    ),
    GetPage(
      name: _Paths.PERENCANAAN_KEUANGAN,
      page: () => PerencanaanKeuanganView(),
      binding: PerencanaanKeuanganBinding(),
    ),
    GetPage(
      name: _Paths.DAFTAR_LEMBAGA,
      page: () => DaftarLembagaView(),
      binding: DaftarLembagaBinding(),
    ),
    GetPage(
      name: _Paths.BOOKMARKED_ARTIKEL,
      page: () => BookmarkedArtikelView(),
      binding: LiterasiBinding(),
    ),
    GetPage(
      name: _Paths.BOOKMARKED_VIDEO,
      page: () => BookmarkedVideoView(),
      binding: LiterasiBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_VIDEO,
      page: () => DetailVideoView(),
      binding: LiterasiBinding(),
    ),
    GetPage(
      name: _Paths.LIST_KONSULTASI,
      page: () => ListKonsultasiView(),
      binding: KonsultasiBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_JADWAL_KONSULTASI,
      page: () => CreateJadwalKonsultasiView(),
      binding: KonsultasiBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT_KONSULTASI,
      page: () => HistoryConsultationView(),
      binding: KonsultasiBinding(),
    ),
    GetPage(
      name: _Paths.CARI_VIDEO,
      page: () => CariVideoView(),
      binding: LiterasiBinding(),
    ),
    GetPage(
      name: _Paths.PENGATURAN_NOTIFIKASI,
      page: () => PengaturanNotifikasiView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_PESANAN_KONSULTASI,
      page: () => CreatePesananKonsultasiView(),
      binding: KonsultasiBinding(),
    ),
    GetPage(
      name: _Paths.PIN,
      page: () => PinView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PIN,
      page: () => EditPinView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_PIN,
      page: () => CreatePinView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.CONFIRM_PIN,
      page: () => ConfirmationPinView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_PIN,
      page: () => AuthPinView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ZIS,
      page: () => const ZisView(),
      binding: ZisBinding(),
    ),
    GetPage(
      name: _Paths.LAPORAN_KEUANGAN,
      page: () => LaporankeuanganView(),
      binding: CashflowBinding(),
    ),
    GetPage(
      name: _Paths.SETEL_ULANG_PIN,
      page: () => ResetPinView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SETEL_ULANG_PIN_AUTH,
      page: () => ResetPinOnAuthView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.RS_DARURAT,
      page: () => RsDaruratView(),
      binding: PerencanaanKeuanganBinding(),
    ),
    GetPage(
      name: _Paths.RS_KENDARAAN,
      page: () => RsKendaraanView(),
      binding: PerencanaanKeuanganBinding(),
    ),
    GetPage(
      name: _Paths.RS_PENDIDIKAN,
      page: () => RsPendidikanView(),
      binding: PerencanaanKeuanganBinding(),
    ),
    GetPage(
      name: _Paths.RS_PENSIUN,
      page: () => RsPensiunView(),
      binding: PerencanaanKeuanganBinding(),
    ),
    GetPage(
      name: _Paths.RS_PERNIKAHAN,
      page: () => RsPernikahanView(),
      binding: PerencanaanKeuanganBinding(),
    ),
    GetPage(
      name: _Paths.RS_RUMAH,
      page: () => RsRumahView(),
      binding: PerencanaanKeuanganBinding(),
    ),
    GetPage(
      name: _Paths.RS_UMROH,
      page: () => RsUmrohView(),
      binding: PerencanaanKeuanganBinding(),
    ),
    GetPage(
      name: _Paths.PK_DARURAT,
      page: () => PkDaruratView(),
      binding: PerencanaanKeuanganBinding(),
    ),
    GetPage(
      name: _Paths.PK_KENDARAAN,
      page: () => PkKendaraanView(),
      binding: PerencanaanKeuanganBinding(),
    ),
    GetPage(
      name: _Paths.PK_PENDIDIKAN,
      page: () => PkPendidikanView(),
      binding: PerencanaanKeuanganBinding(),
    ),
    GetPage(
      name: _Paths.PK_PENSIUN,
      page: () => PkPensiunView(),
      binding: PerencanaanKeuanganBinding(),
    ),
    GetPage(
      name: _Paths.PK_PERNIKAHAN,
      page: () => PkPernikahanView(),
      binding: PerencanaanKeuanganBinding(),
    ),
    GetPage(
      name: _Paths.PK_RUMAH,
      page: () => PkRumahView(),
      binding: PerencanaanKeuanganBinding(),
    ),
    GetPage(
      name: _Paths.PK_UMROH,
      page: () => PkUmrohView(),
      binding: PerencanaanKeuanganBinding(),
    ),
    GetPage(
      name: _Paths.ANGGARAN_CREATE,
      page: () => FormAnggaranView(),
      binding: CashflowBinding(),
    ),
    GetPage(
      name: _Paths.SNK,
      page: () => const SnkView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.BANTUAN,
      page: () => const BantuanView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.HUBUNGI_KAMI,
      page: () => const HubungiKamiView(),
      binding: ProfileBinding(),
    ),
  ];
}
