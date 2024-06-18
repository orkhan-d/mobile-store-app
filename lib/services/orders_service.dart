import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dioLib;
import 'package:http/http.dart' as http;
import 'package:store/services/auth_service.dart';
import 'package:store/services/cart_service.dart';
import 'package:store/var.dart';

class Order {
  int id;
  List<OrderProduct> products;

  Order({required this.id, required this.products});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      products: json['products'].map<OrderProduct>((item) => OrderProduct.fromJson(item)).toList()
    );
  }
}

class OrderProduct {
  final int id;
  final String name;
  final String description;
  final num price;
  final String imageUrl;
  final int amount;

  const OrderProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.amount
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'] is String ? num.parse(json['price']) : json['price'],
      imageUrl: json['imageLink'],
      amount: json['quantity']
    );
  }
}

Future<List<Order>> getOrdersAPI() async {
  String? token = await getToken();
  if (token!=null) {
    http.Response res = await http.get(
      getAPI('/orders'), headers: {
        'Authorization': 'Bearer $token'
      }
    );
    if (res.statusCode==200) {
      final List<dynamic> data = json.decode(res.body);
      return data.map<Order>((item) => Order.fromJson(item)).toList();
    }
  }
  return [];
}

Future<void> createOrderAPI({
  required String shippingAddress,
  required String paymentMethod,
  required List<Cart> products
}) async {
  final dio = Dio();
  String? token = await getToken();

  if (token!=null) {
    dioLib.Response res = await dio.post(
      getAPIString('/orders'),
      data: {
        'products': products.map((e) => e.toJson()).toList(),
        'shipping_address': shippingAddress,
        'payment_method': paymentMethod
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token'
        }
      )
    );
    print(res.statusCode);
    print(res.statusMessage);
  }
}