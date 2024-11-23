import 'package:flutter/material.dart';
import 'package:my_store_app/model/product/product.dart';
import 'package:my_store_app/page/product_page/detail_product_item.dart';
import 'package:my_store_app/page/product_page/detail_web_page.dart';

class DetailProductPage extends StatefulWidget {
  final Product product;
  const DetailProductPage({super.key, required this.product});

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  int quantity = 1;

  void updateQuantity(int newQuantity) {
    setState(() {
      quantity = newQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Product'),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return DetailWebPage(
            product: widget.product,
            quantity: quantity,
            updateQuantity: updateQuantity,
          );
        } else {
          return DetailProductItem(
            product: widget.product,
            quantity: quantity,
            updateQuantity: updateQuantity,
          );
        }
      }),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Total: \$ ${quantity * widget.product.price}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Spacer(),
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text('You bought ${widget.product.title}'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Buy Now',
                    style: TextStyle(fontSize: 18),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

