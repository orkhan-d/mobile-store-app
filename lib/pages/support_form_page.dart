import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/components/button.dart';
import 'package:store/components/input.dart';
import 'package:store/enums.dart';
import 'package:store/pages/login_page.dart';
import 'package:store/providers/auth_provider.dart';
import 'package:store/providers/theme_provider.dart';

class SupportFormPage extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  SupportFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    
    if (Provider.of<AuthProvider>(context).currentUser==null) {
      return Scaffold(
        body: LoginPage()
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(themeProvider.currentTheme!.appBarTheme.backgroundColor),
          ),
          icon: Icon(
            themeProvider.currentTheme!.platform == TargetPlatform.iOS
                ? Icons.arrow_back_ios
                : Icons.arrow_back,
            color: themeProvider.currentTheme!.colorScheme.secondary,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Support Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Contact Support',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Input(placeholder: "Title", controller: titleController),
            const SizedBox(height: 16.0),
            Input(
              placeholder: "Type your question", controller: messageController,
              maxLines: 10,
            ),
            const SizedBox(height: 16.0),
            Button(
              text: "Send",
              callback: () {
                // Send support form
              },
              fillWidth: true,
              type: ButtonType.primary,
            ),
          ],
        ),
      ),
    );
  }
}