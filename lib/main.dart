import 'package:dtbroker/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/profile_controller.dart';

void main() {
  Get.put(ProfileController(),permanent: true);
  runApp(const DTBrokerApp());

}

class DTBrokerApp extends StatelessWidget {
  const DTBrokerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nivesh Core',
      theme: ThemeData(
        primaryColor: const Color(0xffE6C56F),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SplashScreen(),
    );
  }
}
