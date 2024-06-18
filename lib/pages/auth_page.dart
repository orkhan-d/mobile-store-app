import 'package:flutter/material.dart';
import 'package:store/pages/login_page.dart';
import 'package:store/pages/signup_page.dart';

class AuthPage extends StatefulWidget {
  final Widget loginPage = LoginPage();
  final Widget signUpPage = SignUpPage();
  AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLoginPage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoginPage ? widget.loginPage : widget.signUpPage,
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                setState(() {
                  isLoginPage = !isLoginPage;
                });
              },
              child: Text(
                "Or ${isLoginPage ? "Sign up" : "Sign in"}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}