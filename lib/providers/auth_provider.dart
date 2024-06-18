import 'package:flutter/material.dart';
import 'package:store/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  User? currentUser;
  bool isLoading = true;

  AuthProvider() {
    getSavedUser().then((user) {
      setUser(user);
      isLoading = false;
    });
    getSavedToken().then((token) {
      setToken(token);
      isLoading = false;
    });
  }

  setUser(User? user) {
    currentUser = user;
    notifyListeners();
  }

  setToken(String? token) {
    currentUser!.token = token;
    notifyListeners();
  }
}