import 'dart:convert';

import 'package:my_store_app/models/product/product.dart';

import 'package:http/http.dart' as http;

class ProductService {
  static const String _baseUrl = 'https://fakestoreapi.com/products';

  Future<List<Product>> fetchProducts() async{
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> productList = json.decode(response.body);
      return productList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}