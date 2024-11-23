import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_store_app/models/product/product.dart';
import 'package:my_store_app/pages/product_detail/detail_product_page.dart';
import 'package:my_store_app/services/product_service.dart';

class ProductList extends StatefulWidget {
  final int gridCount;
  const ProductList({super.key, required this.gridCount});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late Future<List<Product>> _products;
  final ProductService _productService = ProductService();

  @override
  void initState() {
    super.initState();
    _products = _productService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _products,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text('No products available'),
          );
        } else {
          final products = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              crossAxisCount: widget.gridCount,
              children: products.map((product) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DetailProductPage(
                        product: product,
                      );
                    }));
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        Flexible(
                          flex: 3,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Stack(children: [
                              Align(
                                alignment: Alignment.center,
                                child: Hero(
                                  tag: product.title,
                                  child: Image.network(
                                    product.image,
                                    fit: BoxFit.contain,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
                                                      1)
                                              : null,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Hero(
                                    tag: 'rate${product.title}',
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 15,
                                          color: Colors.amber,
                                        ),
                                        SizedBox(width: 2),
                                        Text('${product.rating.rate}'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                product.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: 16.0,
                              right: 16.0,
                            ),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Price \$ ${product.price}',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }
}
