import 'package:credit_card_form/credit_card_form.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

const Color darkAccentColor = Color(0xFF212121);
const Color darkSecondaryColor = Color.fromARGB(255, 140, 140, 140);
const Color lightAccentColor = Color(0xFF212121);
const Color lightSecondaryColor = Color.fromARGB(255, 73, 73, 73);

const Color successColor = Colors.green;
const Color dangerColor = Colors.red;

final lightTheme = ThemeData(
  navigationBarTheme: const NavigationBarThemeData(
    shadowColor: Colors.white,
    indicatorColor: Colors.black,
    elevation: 100,
    backgroundColor: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
  brightness: Brightness.light,
  primaryColor: Colors.white,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w900,
      color: Colors.black
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Colors.black
    ),
  ),
  cardColor: Colors.white,
  colorScheme: ColorScheme.light(
    primary: Colors.purple.shade700,
    onPrimary: Colors.white,
    secondary: lightSecondaryColor,
    onSecondary: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
    error: dangerColor,
    onError: Colors.white,
    brightness: Brightness.light
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
      shape: WidgetStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        )
      ),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(horizontal: 16, vertical: 10)
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        )
      ),
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.all(6)
      ),
    )
  ),
  scaffoldBackgroundColor: Colors.white
);

final darkTheme = ThemeData(
  navigationBarTheme: const NavigationBarThemeData(
    shadowColor: Colors.black,
    indicatorColor: Colors.white,
    elevation: 100,
    backgroundColor: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    surfaceTintColor: Colors.black,
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 22, 22, 22),
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w900,
      color: Colors.white
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Colors.white
    ),
  ),
  cardColor: Colors.black,
  colorScheme: ColorScheme.dark(
    primary: Colors.purple.shade300,
    onPrimary: Colors.black,
    secondary: darkSecondaryColor,
    onSecondary: Colors.black,
    surface: Colors.black,
    onSurface: Colors.white,
    error: dangerColor,
    onError: Colors.white,
    brightness: Brightness.dark
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
      shape: WidgetStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        )
      ),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(horizontal: 16, vertical: 10)
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        )
      ),
      foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
      foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.all(6)
      ),
    )
  ),
);

class LightCreditCardTheme implements CreditCardTheme {
  @override
  Color backgroundColor = Colors.transparent;
  @override
  Color textColor = Colors.black;
  @override
  Color borderColor = lightSecondaryColor;
  @override
  Color labelColor = Colors.purple.shade700;
}

class DarkCreditCardTheme implements CreditCardTheme {
  @override
  Color backgroundColor = Colors.transparent;
  @override
  Color textColor = Colors.white;
  @override
  Color borderColor = darkSecondaryColor;
  @override
  Color labelColor = Colors.purple.shade300;
}

final lightShimmerEffect = ShimmerEffect(
  baseColor: Colors.grey[300]!,
  highlightColor: Colors.grey[100]!,
);

final darkShimmerEffect = ShimmerEffect(
  baseColor: Colors.grey[900]!,
  highlightColor: Colors.grey[700]!,
);