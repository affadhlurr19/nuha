import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
            TextField(
              obscureText: true,
              autocorrect: false,
              style: Theme.of(context).textTheme.bodyText2,
              controller: controller.passC,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: Theme.of(context).textTheme.bodyText2,
                border: const OutlineInputBorder(),
              ),
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
