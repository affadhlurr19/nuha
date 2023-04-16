import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/icons8.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/tabler.dart';
import 'package:iconify_flutter/icons/iconoir.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/cashflow/views/cashflow_view.dart';
import 'package:nuha/app/modules/fincheck/views/fincheck_view.dart';
import 'package:nuha/app/modules/home/views/home_view.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../controllers/navbar_controller.dart';

class NavbarView extends GetView<NavbarController> {
  NavbarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        children: [
          HomeView(),
          CashflowView(),
          HomeView(),
          FincheckView(),
          HomeView()
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 0,
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _bottomAppBarItem(
                    context,
                    icon: MaterialSymbols.home_outline_rounded,
                    page: 0,
                    label: "Beranda",
                  ),
                  _bottomAppBarItem(
                    context,
                    icon: Icons8.bank_card,
                    page: 1,
                    label: "Budgeting",
                  ),
                  _bottomAppBarItem(
                    context,
                    icon: Ph.book_open,
                    page: 2,
                    label: "Literasi",
                  ),
                  _bottomAppBarItem(
                    context,
                    icon: Tabler.users,
                    page: 3,
                    label: "Konsultasi",
                  ),
                  _bottomAppBarItem(
                    context,
                    icon: Iconoir.donate,
                    page: 4,
                    label: "ZIS",
                  )
                ],
              )),
        ),
      ),
    );
  }

  Widget _bottomAppBarItem(BuildContext context,
      {required icon, required page, required label}) {
    return ZoomTapAnimation(
      onTap: () => controller.goToTab(page),
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Iconify(
              icon,
              color:
                  controller.currentPage.value == page ? buttonColor1 : grey400,
            ),
            Text(
              label,
              style: TextStyle(
                color: controller.currentPage.value == page
                    ? buttonColor1
                    : grey400,
                fontWeight: controller.currentPage.value == page
                    ? FontWeight.w600
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
