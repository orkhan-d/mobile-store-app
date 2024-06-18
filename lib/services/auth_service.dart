import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/providers/auth_provider.dart';
import 'package:store/providers/cart_provider.dart';
import 'package:store/services/cart_service.dart';
import 'package:store/var.dart';
import 'package:http/http.dart' as http;

class User {
  final int id;
  final String name;
  final String email;
  late String? token;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['username'],
      email: json['email'],
    );
  }

  String toJson() {
    return jsonEncode({
      'id': id,
      'username': name,
      'email': email,
    });
  }
}

Future<bool> isAuth() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Future.delayed(const Duration(seconds: 5));
  return prefs.getString('token')!=null;
}

Future<String?> signUp(
  String email,
  String name,
  String password,
  BuildContext context,
) async {
  Response res = await http.post(getAPI('/register'), body: {
    'username': name,
    'email': email,
    'password': password,
  });
  if (res.statusCode != 200) {
    return 'Registration failed';
  }
  String token = (jsonDecode(res.body) as Map<String, dynamic>)['token']!;
  
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', token);

  User user = await getUser();
  prefs.setString('userJson', user.toJson().toString());
  Provider.of<AuthProvider>(context, listen: false).setUser(user);
  Provider.of<AuthProvider>(context, listen: false).currentUser!.token = token;

  updateDBCart(token, context);
  
  return null;
}

Future<String?> signIn(
  String email,
  String password,
  BuildContext context,
) async {
  Response res = await http.post(getAPI('/login'), body: {
    'email': email,
    'password': password,
  });
  if (res.statusCode != 200) {
    return 'Login failed';
  }
  String token = (jsonDecode(res.body) as Map<String, dynamic>)['token']!;
  
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', token);

  User user = await getUser();
  prefs.setString('userJson', user.toJson().toString());
  Provider.of<AuthProvider>(context, listen: false).setUser(user);
  Provider.of<AuthProvider>(context, listen: false).currentUser!.token = token;

  updateDBCart(token, context);
  
  return null;
}

Future<bool> updateDBCart(String token, BuildContext context) async {
  List<Cart> cart = Provider.of<CartProvider>(context, listen: false).cart;
  for (Cart obj in cart) {
    addProductToCartAPI(obj.product, amount: obj.amount);
  }
  return false;
}

Future<bool> signOut(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('token');
  prefs.remove('userJson');
  Provider.of<AuthProvider>(context, listen: false).setUser(null);
  return true;
}

Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

Future<User> getUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token')!;
  
  Response res = await http.get(
    getAPI('/user/profile'),
    headers: {
      'Authorization': 'Bearer $token',
    }
  );
  return User.fromJson(jsonDecode(res.body));
}

Future<User?> getSavedUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userJson = prefs.getString('userJson');

  if (userJson==null) {
    return null;
  }

  return User.fromJson(jsonDecode(userJson));
}

Future<String?> getSavedToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  if (token==null) {
    return null;
  }

  return token;
}