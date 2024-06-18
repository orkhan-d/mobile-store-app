import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int index = 1;

  setIndex(int value) {
    index = value;
    notifyListeners();
  }
}