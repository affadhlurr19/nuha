import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nuha/app/routes/app_pages.dart';
import 'package:nuha/main.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    if(box.read("rememberMe") != null) {
      controller.emailC.text = box.read("rememberMe")["email"];
      controller.passC.text = box.read("rememberMe")["pass"];
      controller.rememeberMe.value = true;
    }
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              autocorrect: false,
              controller: controller.emailC,
              style: Theme.of(context).textTheme.bodyText2,
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: Theme.of(context).textTheme.bodyText2,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => TextField(
                obscureText: controller.isHidden.value,
                autocorrect: false,
                style: Theme.of(context).textTheme.bodyText2,
                controller: controller.passC,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: Theme.of(context).textTheme.bodyText2,
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () => controller.isHidden.toggle(),
                    icon: Icon(controller.isHidden.isTrue
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Obx(
              () => CheckboxListTile(
                value: controller.rememeberMe.value,
                onChanged: (_) => controller.rememeberMe.toggle(),
                title: Text(
                  "Remember Me",
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 150,
                  child: TextButton(
                    onPressed: () => Get.toNamed(Routes.RESET_PASSWORD),
                    child: const Text('Lupa Password'),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Obx(
              () => ElevatedButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.login();
                  }
                },
                child: controller.isLoading.isFalse
                    ? Text(
                        "LOGIN",
                        style: Theme.of(context).textTheme.button!.copyWith(
                              color: Colors.white,
                            ),
                      )
                    : const SizedBox(
                        height: 10,
                        width: 10,
                        child: CircularProgressIndicator(
                          color: Colors.white,
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
