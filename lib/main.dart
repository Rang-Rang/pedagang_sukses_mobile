import 'package:flutter/material.dart';
import 'package:pedagang_sukses/function/Pallette.dart';
import 'package:pedagang_sukses/postscreen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PostScreen(),
      theme: ThemeData(
        primarySwatch: Palette.FavoriteColor
      ),
    );
  }
}