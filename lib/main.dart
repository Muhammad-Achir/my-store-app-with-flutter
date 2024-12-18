import 'package:flutter/material.dart';
import 'package:my_store_app/pages/home_page/product_page.dart';

void main (){
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Store App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 22, 224, 36)),
        useMaterial3: true,
      ),
      home: ProductPage(),
    );
  }
}