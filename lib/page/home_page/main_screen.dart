import 'package:flutter/material.dart';
import 'package:my_store_app/page/home_page/home_page.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store'),
      ),
      body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 800) {
          return HomePage(gridCount: 2);
        } else if (constraints.maxWidth <= 1200) {
          return HomePage(gridCount: 4);
        } else {
          return HomePage(gridCount: 6);          
        }
      }),
    );
  }
}