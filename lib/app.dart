import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/providers/auth_provider.dart';
import 'package:store/screens/main_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider.of<AuthProvider>(context).isLoading
      ? const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        )
      : const MainScreen();
  }
}