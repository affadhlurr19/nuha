import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nuha/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.PROFILE),
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: Column(
        children: [
          Text(auth.currentUser!.providerData.toString()),
          const SizedBox(height: 10),
          Text(auth.currentUser!.providerData[0].providerId),
          Text(auth.currentUser!.uid),
          const SizedBox(height: 10),
          auth.currentUser!.providerData[0].providerId == 'google.com'
              ? ElevatedButton(
                  onPressed: () => controller.logoutGoogle(),
                  child: const Text('Logout Google Account'),
                )
              : ElevatedButton(
                  onPressed: () => controller.logout(),
                  child: const Text('Logout'),
                ),

          // auth.currentUser.providerData.fo
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
