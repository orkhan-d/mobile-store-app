import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/providers/theme_provider.dart';

class CustomBadge extends StatefulWidget {
  final Widget label;
  final Widget child;
  final bool inverted;

  const CustomBadge({
    required this.label,
    required this.child,
    this.inverted = false,
    super.key
  });

  @override
  State<CustomBadge> createState() => _CustomBadgeState();
}

class _CustomBadgeState extends State<CustomBadge> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    Color textColor = !widget.inverted
      ? themeProvider.currentTheme!.colorScheme.surface
      : themeProvider.currentTheme!.colorScheme.onSurface;
    
    Color backgroundColor = widget.inverted
      ? themeProvider.currentTheme!.colorScheme.surface
      : themeProvider.currentTheme!.colorScheme.onSurface;

    return Badge(
      textColor: textColor,
      backgroundColor: backgroundColor,
      textStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w800,
      ),
      label: widget.label,
      child: widget.child
    );
  }
}