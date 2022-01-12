import 'package:flutter/material.dart';
import 'package:mobile/screens/welcome_screen.dart';
import 'package:mobile/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tuale',
      theme: ThemeData(primarySwatch: Palette.tualeSwatchLight),
      home: const Welcome(),
    );
  }
}
