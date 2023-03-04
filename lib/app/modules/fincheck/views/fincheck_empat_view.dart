import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/widgets/field_fincheck.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class FincheckEmpatView extends GetView {
  FincheckEmpatView({Key? key}) : super(key: key);
  final appBarheight = AppBar().preferredSize.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        backgroundColor: backgroundColor1,
        elevation: 0,
      ),
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
        children: [
          Text(
            "Langkah 4",
            style: Theme.of(context).textTheme.caption!.copyWith(
                  color: grey400,
                ),
          ),
          const SizedBox(
            height: 4,
          ),
          GradientText(
            "Berapa pengeluaranmu dalam sebulan?",
            style: Theme.of(context).textTheme.headline2!,
            colors: const [
              buttonColor1,
              buttonColor2,
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            "(Jika tidak ada, ketika 0)",
            style: Theme.of(context).textTheme.caption!.copyWith(
                  color: grey400,
                ),
          ),
          const SizedBox(
            height: 25,
          ),
          const FieldFincheck(labelText: "Belanja Kebutuhan"),
          const FieldFincheck(labelText: "Transportasi"),
          const FieldFincheck(labelText: "Sedekah/Donasi"),
          const FieldFincheck(labelText: "Pendidikan"),
          const FieldFincheck(labelText: "Pajak"),
          const FieldFincheck(labelText: "Premi Asuransi Bulanan"),
          const FieldFincheck(labelText: "Lainnya"),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 16,
                height: 4,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: grey50),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                width: 16,
                height: 4,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: grey50),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                width: 16,
                height: 4,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: grey50),
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
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 143,
                height: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      side: const BorderSide(width: 1, color: buttonColor2),
                      backgroundColor: backgroundColor1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Text(
                    "Kembali",
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: buttonColor2),
                  ),
                  onPressed: () => Get.back(),
                ),
              ),
              SizedBox(
                width: 143,
                height: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Text(
                    "Lihat Hasil Tes",
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: Colors.white),
                  ),
                  onPressed: () => Get.toNamed("/home"),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      )),
    );
  }
}
