import 'dart:convert';

import 'package:store/services/auth_service.dart';
import 'package:store/services/products_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:store/var.dart';

class Cart {
  final Product product;
  int amount;

  Cart({
    required this.product,
    required this.amount,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      product: Product.fromJson(json['product']),
      amount: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': product.id,
      'quantity': amount,
    };
  }
}

Future<List<Cart>> getUserCartAPI () async {
  String? token = await getToken();
  if (token!=null) {
    Response res = await http.get(
      getAPI('/cart'), headers: {
        'Authorization': 'Bearer $token'
      }
    );
    if (res.statusCode==200) {
      final List<dynamic> data = json.decode(res.body);
      return data.map((item) => Cart.fromJson(item)).toList();
    }
  }
  return [];
}

Future<bool> addProductToCartAPI (Product product, {int amount = 1}) async {
  String? token = await getToken();
  if (token!=null) {
    for (var i = 0; i < amount; i++) {
      await http.get(
        getAPI('/cart/${product.id}/increment'), headers: {
          'Authorization': 'Bearer $token'
        }
      );
    }
  }
  return true;
}

Future<bool> removeProductFromCartAPI (Product product) async {
  String? token = await getToken();
  if (token!=null) {
    await http.delete(
      getAPI('/cart/${product.id}'), headers: {
        'Authorization': 'Bearer $token'
      }
    );
  }
  return true;
}

Future<bool?> reduceProductInCartAPI (Product product) async {
  String? token = await getToken();
  if (token!=null) {
    await http.get(
      getAPI('/cart/${product.id}/decrement'), headers: {
        'Authorization': 'Bearer $token'
      }
    );
  }
  return true;
}

Future<bool> clearCartAPI () async {
  String? token = await getToken();
  if (token!=null) {
    await http.get(
      getAPI('/cart/clear'), headers: {
        'Authorization': 'Bearer $token'
      }
    );
  }
  return true;
}