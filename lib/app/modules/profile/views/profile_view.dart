import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ProfileView'),
          centerTitle: true,
        ),
        body: FutureBuilder<Map<String, dynamic>?>(
            future: controller.getProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data == null) {
                return const Center(
                  child: Text("Tidak ada data user."),
                );
              } else {
                controller.emailC.text = snapshot.data!["email"];
                controller.phoneC.text = snapshot.data!["phone"];
                controller.nameC.text = snapshot.data!["name"];
                return ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    TextField(
                      readOnly: true,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
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
                      autocorrect: false,
                      controller: controller.nameC,
                      style: Theme.of(context).textTheme.bodyText2,
                      decoration: InputDecoration(
                        labelText: "Nama",
                        labelStyle: Theme.of(context).textTheme.bodyText2,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      autocorrect: false,
                      keyboardType: TextInputType.number,
                      controller: controller.phoneC,
                      style: Theme.of(context).textTheme.bodyText2,
                      decoration: InputDecoration(
                        labelText: "Nomor Telepon",
                        labelStyle: Theme.of(context).textTheme.bodyText2,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => TextField(
                        obscureText: controller.isHidden.value,
                        controller: controller.passC,
                        style: Theme.of(context).textTheme.bodyText2,
                        decoration: InputDecoration(
                          labelText: "Password Baru",
                          labelStyle: Theme.of(context).textTheme.bodyText2,
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () =>
                                controller.isHidden.toggle(),
                            icon: Icon(controller.isHidden.isTrue
                                ? Icons.remove_red_eye
                                : Icons.remove_red_eye_outlined),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Created At: ",
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      DateFormat.yMMMEd().add_jms().format(
                            DateTime.parse(snapshot.data!['created_at']),
                          ),
                      style: Theme.of(context).textTheme.caption,
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: Obx(
                        () => ElevatedButton(
                          onPressed: () {
                            if (controller.isLoading.isFalse) {
                              controller.updateProfile();
                            }
                          },
                          child: controller.isLoading.isFalse
                              ? Text(
                                  "UPDATE PROFILE",
                                  style: Theme.of(context)
                                      .textTheme
                                      .button!
                                      .copyWith(
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
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => controller.logout(),
                        child: Text(
                          "LOGOUT",
                          style: Theme.of(context).textTheme.button!.copyWith(
                                color: Colors.white,
                              ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }));
  }
}
