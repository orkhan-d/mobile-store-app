import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store/var.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final num price;
  final String imageUrl;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'] is String ? num.parse(json['price']) : json['price'],
      imageUrl: json['imageLink'],
    );
  }
}

const Product testProduct = Product(
  id: 1,
  name: 'iPhone 13',
  description: 'The latest iPhone model',
  price: 999,
  imageUrl: 'https://store.com/iphone13.jpg',
);

Future<List<Product>> getProducts() async {
  await Future.delayed(const Duration(seconds: 3));
  try {
    final response = await http.get(getAPI('/products'));
    
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Product> products = data.map((item) => Product.fromJson(item)).toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  } on TypeError catch (e) {
    print(e.stackTrace);
    print(e.toString());
    throw Exception('Failed to connect to the server');
  }
}