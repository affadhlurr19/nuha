import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/cashflow/views/cashflow_view.dart';
import 'package:nuha/app/modules/home/views/home_view.dart';
import 'package:nuha/app/modules/literasi/views/literasi_view.dart';
import 'package:nuha/app/modules/zis/views/zis_view.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sizer/sizer.dart';

class NavbarView extends StatefulWidget {
  const NavbarView({super.key});

  @override
  State<NavbarView> createState() => _NavbarView();
}

class _NavbarView extends State<NavbarView> {
  // final PersistentTabController _controller =
  //     PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreen() {
    return [
      HomeView(),
      CashflowView(),
      const LiterasiView(),
      HomeView(),
      ZisView(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItem() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        iconSize: 15.sp,
        title: "Beranda",
        textStyle:
            Theme.of(context).textTheme.labelSmall!.copyWith(letterSpacing: 0),
        activeColorPrimary: buttonColor1,
        inactiveColorPrimary: grey400,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.creditcard),
        iconSize: 15.sp,
        title: "Alur Kas",
        textStyle:
            Theme.of(context).textTheme.labelSmall!.copyWith(letterSpacing: 0),
        inactiveColorPrimary: grey500,
        activeColorPrimary: buttonColor1,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.book),
        iconSize: 15.sp,
        title: "Literasi",
        textStyle:
            Theme.of(context).textTheme.labelSmall!.copyWith(letterSpacing: 0),
        inactiveColorPrimary: grey500,
        activeColorPrimary: buttonColor1,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person_2),
        iconSize: 15.sp,
        title: "Konsultasi",
        textStyle:
            Theme.of(context).textTheme.labelSmall!.copyWith(letterSpacing: 0),
        inactiveColorPrimary: grey500,
        activeColorPrimary: buttonColor1,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.heart_circle),
        iconSize: 15.sp,
        title: "ZIS",
        textStyle:
            Theme.of(context).textTheme.labelSmall!.copyWith(letterSpacing: 0),
        inactiveColorPrimary: grey500,
        activeColorPrimary: buttonColor1,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreen(),
      items: _navBarItem(),
      backgroundColor: backgroundColor1,
      navBarHeight: 8.h,
      navBarStyle: NavBarStyle.style6,
      padding: NavBarPadding.fromLTRB(1.75.h, 1.25.h, 6.388889.w, 6.388889.w),
    );
  }
}
