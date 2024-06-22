import 'package:flutter/material.dart';
import 'package:store/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  User? currentUser;
  bool isLoading = true;

  AuthProvider() {
    getSavedUser().then((user) {
      setUser(user);
    }).then((_) => getSavedToken()).then((token) {
      setToken(token);
    });
    isLoading = false;
    // getSavedToken().then((token) {
    //   setToken(token);
      
    // });
  }

  setUser(User? user) {
    currentUser = user;
    notifyListeners();
  }

  setToken(String? token) {
    if (currentUser!=null) {
      currentUser!.token = token;
    }
    notifyListeners();
  }
}