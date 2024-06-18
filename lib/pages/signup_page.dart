import 'package:flutter/material.dart';
import 'package:store/components/button.dart';
import 'package:store/components/input.dart';
import 'package:store/enums.dart';
import 'package:store/services/auth_service.dart';

class SignUpPage extends StatefulWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String error = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Nice to meet you!",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w900,
            )
          ),
          const Divider(
            thickness: 2,
          ),
          const SizedBox(height: 8.0),
          Input(
            placeholder: "Your Name",
            controller: widget.nameController,
          ),
          const SizedBox(height: 16.0),
          Input(
            placeholder: "E-mail",
            controller: widget.emailController,
          ),
          const SizedBox(height: 16.0),
          Input(
            placeholder: "Password",
            controller: widget.passwordController,
            obscure: true
          ),
          const SizedBox(height: 8.0),
          error!="" ? Text(
            error,
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
            ),
          ) : const SizedBox.shrink(),
          const SizedBox(height: 8.0),
          Button(
            text: "Sign up",
            callback: () async {
              String? error = await signUp(widget.emailController.text, widget.nameController.text, widget.passwordController.text, context);
              if (error!=null) {
                setState(() {
                  this.error = error;
                });
              }
            },
            type: ButtonType.primary,
            icon: Icons.login_rounded,
          ),
        ],
      ),
    );
  }
}