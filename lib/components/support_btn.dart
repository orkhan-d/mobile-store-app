import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/colors.dart';
import 'package:store/pages/support_form_page.dart';
import 'package:store/providers/theme_provider.dart';

class SupportButton extends StatelessWidget {
  const SupportButton({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: true);

    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SupportFormPage()
          )
        );
      },
      backgroundColor: (themeProvider.currentTheme ?? lightTheme).colorScheme.primary,
      foregroundColor: (themeProvider.currentTheme ?? lightTheme).colorScheme.onPrimary,
      // shape: const CircleBorder(),
      child: const Icon(Icons.chat),
    );
  }
}