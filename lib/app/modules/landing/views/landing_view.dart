import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';

import '../controllers/landing_controller.dart';

class LandingView extends GetView<LandingController> {
  const LandingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              width: Get.width,
              height: Get.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 16,
                    height: 4,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: buttonColor1),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 16,
                    height: 4,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Color(0XFFF1F1F1)),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 16,
                    height: 4,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Color(0XFFF1F1F1)),
                  )
                ],
              ),
            ),
            SizedBox(
              width: Get.width,
              height: Get.height * 0.7,
              child: Column(
                children: [
                  const Expanded(
                      child: Image(
                          image: AssetImage('assets/images/landing_page.png'))),
                  Container(
                      margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Halo, Selamat datang di Nuha. Solusi Keuanganmu",
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(color: titleColor),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Nuha merupakan solusi keuangan yang mudah diakses kapan saja dan dimana saja. Dilengkapi dengan fitur yang pasti ngebantu banget.",
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: grey500),
                          ),
                        ],
                      ))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              width: Get.width,
              height: Get.height * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 44,
                    child: TextButton(
                      child: Text(
                        "Lewati",
                        style: Theme.of(context)
                            .textTheme
                            .button!
                            .copyWith(color: grey500),
                      ),
                      onPressed: () => Get.toNamed("/home"),
                    ),
                  ),
                  SizedBox(
                    width: 143,
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Text(
                        "Selanjutnya",
                        style: Theme.of(context).textTheme.button!.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      onPressed: () => Get.to(const SecondLanding()),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondLanding extends StatelessWidget {
  const SecondLanding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              width: Get.width,
              height: Get.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 16,
                    height: 4,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Color(0XFFF1F1F1)),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 16,
                    height: 4,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: buttonColor1),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 16,
                    height: 4,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Color(0XFFF1F1F1)),
                  )
                ],
              ),
            ),
            SizedBox(
              width: Get.width,
              height: Get.height * 0.7,
              child: Column(
                children: [
                  const Expanded(
                      child: Image(
                          image: AssetImage('assets/images/landing_page.png'))),
                  Container(
                      margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Kami Hadir Untuk Membantu Kebutuhan Finansialmu",
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(color: titleColor),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Ayo tingkatkan kemampuan finansial dan wujudkan kesehatan finansial dimulai dari diri sendiri menggunakan aplikasi Nuha",
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: grey500),
                          ),
                        ],
                      ))
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                width: Get.width,
                height: Get.height * 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 44,
                      child: TextButton(
                        child: Text(
                          "Lewati",
                          style: Theme.of(context)
                              .textTheme
                              .button!
                              .copyWith(color: grey500),
                        ),
                        onPressed: () => Get.toNamed("/home"),
                      ),
                    ),
                    SizedBox(
                      width: 143,
                      height: 44,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: Text(
                          "Selanjutnya",
                          style: Theme.of(context).textTheme.button!.copyWith(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        onPressed: () => Get.to(const ThirdLanding()),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class ThirdLanding extends StatelessWidget {
  const ThirdLanding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //APPBAR
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              width: Get.width,
              height: Get.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 16,
                    height: 4,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Color(0XFFF1F1F1)),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 16,
                    height: 4,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Color(0XFFF1F1F1)),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 16,
                    height: 4,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: buttonColor1),
                  )
                ],
              ),
            ),
            SizedBox(
              width: Get.width,
              height: Get.height * 0.7,
              child: Column(
                children: [
                  const Expanded(
                      child: Image(
                          image: AssetImage('assets/images/landing_page.png'))),
                  Container(
                      margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Kini, kamu tidak perlu repot untuk membayar ZIS",
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(color: titleColor),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Aplikasi Nuha merupakan solusi keuangan untuk kamu yang ingin sekaligus menginginkan kemudahan dalam melakukan amalan",
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: grey500),
                          ),
                        ],
                      ))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              width: Get.width,
              height: Get.height * 0.2,
              child: Center(
                child: SizedBox(
                  width: 280,
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Text(
                      "Memulai",
                      style: Theme.of(context).textTheme.button!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    onPressed: () => Get.toNamed("/fincheck"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
