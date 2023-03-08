import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nuha/app/routes/app_pages.dart';

import '../controllers/memulai_controller.dart';

class MemulaiView extends GetView<MemulaiController> {
  const MemulaiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'MemulaiView is working',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.LOGIN);
                    },
                    child: const Text("LOGIN"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.REGISTER);
                    },
                    child: const Text("REGISTER"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
