import 'package:flutter/material.dart';
import 'package:my_store_app/pages/home_page/product_list.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store'),
      ),
      body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 800) {
          return ProductList(gridCount: 2);
        } else if (constraints.maxWidth <= 1200) {
          return ProductList(gridCount: 4);
        } else {
          return ProductList(gridCount: 6);          
        }
      }),
    );
  }
}