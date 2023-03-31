import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/cashflow/views/anggaran_view.dart';
import 'package:nuha/app/modules/cashflow/views/transaksi_view.dart';
import 'package:sizer/sizer.dart';
import '../controllers/cashflow_controller.dart';

class CashflowView extends GetView<CashflowController> {
  CashflowView({Key? key}) : super(key: key);

  @override
  final CashflowController controller = Get.put(CashflowController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor2,
        body: Row(
          children: [
            SizedBox(
              width: 25.83333.w,
              height: 11.625.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: backgroundColor1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                child: Text(
                  "Transaksi",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: buttonColor1),
                ),
                onPressed: () => Get.to(TransaksiView()),
              ),
            ),
            SizedBox(
              width: 3.333.w,
            ),
            SizedBox(
              width: 25.83333.w,
              height: 11.625.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: backgroundColor1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                child: Text(
                  "Anggaran",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: buttonColor1),
                ),
                onPressed: () => Get.to(AnggaranView()),
              ),
            ),
          ],
        ));
  }
}
