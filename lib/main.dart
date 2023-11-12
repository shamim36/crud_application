import 'package:crud_application/Screen/ProductCreateScreen.dart';
import 'package:crud_application/Screen/ProductGridViewScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crud APP',
      debugShowCheckedModeBanner: false,
      home: ProductGridViewScreen(),
    );
  }
}