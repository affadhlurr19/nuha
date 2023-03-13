import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ResetPasswordView'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            autocorrect: false,
            controller: controller.emailC,
            keyboardType: TextInputType.emailAddress,
            style: Theme.of(context).textTheme.bodyText2,
            decoration: InputDecoration(
              labelText: "Email",
              labelStyle: Theme.of(context).textTheme.bodyText2,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Obx(
              () => ElevatedButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.resetPassword();
                  }
                },
                child: controller.isLoading.isFalse
                    ? Text(
                        "RESET PASSWORD",
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
    );
  }
}
