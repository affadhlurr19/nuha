import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/firebase_options.dart';
import 'package:sizer/sizer.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  timeago.setLocaleMessages('id', timeago.IdMessages());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder<User?>(
    //   stream: auth.authStateChanges(),
    //   builder: (context, snap) {
    //     if (snap.connectionState == ConnectionState.waiting) {
    //       return const CircularProgressIndicator();
    //     }
    //     return Sizer(
    //       builder: (context, orientation, deviceType) {
    //         return GetMaterialApp(
    //           debugShowCheckedModeBanner: false,
    //           theme: ThemeData(textTheme: myTextTheme),
    //           title: "Nuha Financial",
    //           initialRoute:
    //               snap.data != null && snap.data!.emailVerified == true
    //                   ? Routes.HOME
    //                   : Routes.LANDING,
    //           getPages: AppPages.routes,
    //         );
    //       },
    //     );
    //   },
    // );
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: myTextTheme,
          ),
          title: "Nuha Financial",
          initialRoute: Routes.LANDING,
          getPages: AppPages.routes,
        );
      },
    );
  }
}
