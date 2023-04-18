import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:nuha/app/routes/app_pages.dart';
import 'package:sizer/sizer.dart';

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
        leading: IconButton(
          icon: const Icon(Icons.book),
          onPressed: () => Get.toNamed(Routes.LITERASI),
        ),
        actions: [
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: controller.streamProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircleAvatar(
                  backgroundColor: Colors.grey[400],
                );
              }
              Map<String, dynamic>? data = snapshot.data!.data();

              return GestureDetector(
                onTap: () => Get.toNamed(Routes.PROFILE),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[400],
                  backgroundImage: NetworkImage(data?["profile"] != null
                      ? data!["profile"].toString()
                      : "https://ui-avatars.com/api/?name=${data!["name"]}"),
                ),
              );
            },
          ),
          const SizedBox(width: 15),
        ],
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        elevation: 0.5,
        toolbarHeight: 7.375.h,
      ),
      // body: Column(
      //   children: [
      //     Text(auth.currentUser!.providerData.toString()),
      //     const SizedBox(height: 10),
      //     Text(auth.currentUser!.providerData[0].providerId),
      //     Text(auth.currentUser!.uid),
      //     const SizedBox(height: 10),
      //     auth.currentUser!.providerData[0].providerId == 'google.com'
      //         ? ElevatedButton(
      //             onPressed: () => controller.logoutGoogle(),
      //             child: const Text('Logout Google Account'),
      //           )
      //         : ElevatedButton(
      //             onPressed: () => controller.logout(),
      //             child: const Text('Logout'),
      //           ),

      //     // auth.currentUser.providerData.fo
      //   ],
      // ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: controller.streamNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data?.docs.length == 0 || snapshot.data == null) {
            return const Center(
              child: Text('Belum ada data notes'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var docNote = snapshot.data!.docs[index];
              Map<String, dynamic> note = docNote.data();
              return ListTile(
                onTap: () => Get.toNamed(
                  Routes.EDIT_NOTE,
                  arguments: docNote.id,
                ),
                leading: CircleAvatar(
                  child: Text("${index + 1}"),
                ),
                title: Text(
                  '${note['title']}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${note['desc']}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                  onPressed: () {
                    controller.deleteNote(docNote.id);
                  },
                  icon: const Icon(Icons.delete),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADD_NOTE),
        child: const Icon(Icons.add),
      ),
    );
  }
}
