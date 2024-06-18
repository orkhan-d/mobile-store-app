import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/app.dart';
import 'package:store/colors.dart';
import 'package:store/providers/auth_provider.dart';
import 'package:store/providers/cart_provider.dart';
import 'package:store/providers/nav_provider.dart';
import 'package:store/providers/theme_provider.dart';

void main() {
  runApp(
    MultiProvider( // create the provider
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeProvider>(context, listen: true).currentTheme ?? lightTheme,
        title: 'Store',
        home: const MainApp()
      ),
    );
  }
}