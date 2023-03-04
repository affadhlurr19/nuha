import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/fincheck/views/fincheck_satu_view.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../controllers/fincheck_controller.dart';

class FincheckView extends GetView<FincheckController> {
  FincheckView({Key? key}) : super(key: key);
  final appBarheight = AppBar().preferredSize.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: backgroundColor1,
        elevation: 0,
      ),
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
        children: [
          SizedBox(
            width: Get.width,
            height: Get.height * 0.85 - appBarheight,
            child: Column(
              children: [
                GradientText(
                  "Ulas Kondisi Kesehatan Finansialmu",
                  style: Theme.of(context).textTheme.headline2!,
                  colors: const [
                    buttonColor1,
                    buttonColor2,
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Financial Check Up merupakan sebuah upaya pemeriksaaan atau pengecekan kondisi keuangan untuk jangka waktu tertentu.",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: grey500),
                ),
              ],
            ),
          ),
          SizedBox(
            width: Get.width,
            height: Get.height * 0.15,
            child: Column(
              children: [
                const SizedBox(
                  height: 29,
                ),
                Center(
                  child: SizedBox(
                    width: 280,
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Text(
                        "Lakukan Tes",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Colors.white),
                      ),
                      onPressed: () => Get.to(FincheckSatuView()),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
