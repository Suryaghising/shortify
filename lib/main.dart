import 'package:flutter/material.dart';
import 'package:shortify/utils/constants.dart';

import 'views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: kBackgroundColor,
      ),
      home: const HomeView(),
    );
  }
}
