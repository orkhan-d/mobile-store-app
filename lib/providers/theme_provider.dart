import 'package:flutter/material.dart';
import 'package:store/colors.dart';
import 'package:store/services/theme_service.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData? currentTheme;

  ThemeProvider() {
    Future<bool> isDarkTheme = getSavedTheme();
    isDarkTheme.then((value) {
      currentTheme = value ? darkTheme : lightTheme;
      notifyListeners();
    });
  }

  setLightMode() {
    currentTheme = lightTheme;
    notifyListeners();
  }

  setDarkmode() {
    currentTheme = darkTheme;
    notifyListeners();
  }
}