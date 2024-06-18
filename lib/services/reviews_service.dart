import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store/services/auth_service.dart';
import 'package:store/services/products_service.dart';
import 'package:store/var.dart';

class Review {
  final int id;
  final Product product;
  final User user;
  final int rating;
  final String? info;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.user,
    required this.product,
    required this.rating,
    required this.info,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      user: User.fromJson(json['user']),
      product: Product.fromJson(json['product']),
      rating: json['rating'],
      info: json['comment'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

Future<List<Review>> getReviewsOfProduct(int productId) async {
  final res = await http.get(
    getAPI('/products/$productId/reviews'),
  );

  List<Review> reviews = [];

  if (res.statusCode==200) {
    for (var item in jsonDecode(res.body)) {
      reviews.add(Review.fromJson(item));
    }
  }

  return reviews;
}

Future<bool> addReview({
  required int productId,
  required int rating,
  required String info,
  required String token,
}) async {
  final res = await http.post(
    getAPI('/products/$productId/reviews'),
    headers: {
      'Authorization': 'Bearer $token',
    },
    body: {
      'rating': rating.toString(),
      'review': info,
    }
  );

  print(res.statusCode);
  print(res.body);

  if (res.statusCode == 200) {
    return true;
  } else {
    print(res.statusCode);
    print(res.body);
    return false;
  }
}