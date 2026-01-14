import 'package:dtbroker/splashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DTBrokerApp());
}

class DTBrokerApp extends StatelessWidget {
  const DTBrokerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
