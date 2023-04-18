import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nuha/app/modules/literasi/controllers/literasi_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/video_controller.dart';

class ListVideoView extends GetView<LiterasiController> {
  ListVideoView({Key? key}) : super(key: key);
  final c = Get.find<VideoController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        c.count.toString(),
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
