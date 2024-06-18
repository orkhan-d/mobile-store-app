import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/colors.dart';
import 'package:store/providers/theme_provider.dart';

Future<void> switchTheme(BuildContext context, {bool? value}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool currentTheme = prefs.getBool('theme') ?? false;

  // ignore: use_build_context_synchronously
  final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

  if (value!=null) {
    if (value) {
      themeProvider.setLightMode();
    } else {
      themeProvider.setDarkmode();
    }
  } else {
    if (currentTheme) {
      themeProvider.setLightMode();
    } else {
      themeProvider.setDarkmode();
    }
  }

  await prefs.setBool('theme', !currentTheme);
}

Future<bool> getSavedTheme() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print(prefs.getBool('theme'));
  return prefs.getBool('theme') ?? false;
}

ThemeData getTheme(BuildContext context) {
  return Provider.of<ThemeProvider>(context, listen: true).currentTheme ?? lightTheme;
}