import 'package:flutter/material.dart';
import 'package:store/enums.dart';
import 'package:store/services/theme_service.dart';

class Button extends StatelessWidget {
  final bool enabled;
  final IconData? icon;
  final bool fillWidth;
  final void Function() callback;
  final String? text;
  final ButtonType type;

  const Button({
    required this.callback,
    this.text,
    this.icon,
    this.fillWidth = false,
    this.enabled = true,
    required this.type,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget? button;
    assert (icon != null || text != null);
    if (icon != null && text != null) {
      button = ElevatedButton(
        onPressed: enabled ? callback : null,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            _getButtonColor(context, type),
          ),
          foregroundColor: WidgetStateProperty.all<Color>(
            _getIconColor(context, type),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(text!),
          ],
        ),
      );
    } else if (icon == null && text != null) {
      button = ElevatedButton(
        onPressed: enabled ? callback : null,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            _getButtonColor(context, type),
          ),
          foregroundColor: WidgetStateProperty.all<Color>(
            _getIconColor(context, type),
          ),
        ),
        child: Text(text!),
      );
    } else if (icon != null && text == null) {
      button = IconButton(
        onPressed: enabled ? callback : null,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            _getButtonColor(context, type),
          ),
          foregroundColor: WidgetStateProperty.all<Color>(
            _getIconColor(context, type),
          ),
        ),
        icon: Icon(icon!),
      );
    }
    if (fillWidth) {
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    } else {
      return button!; 
    }
  }

  Color _getButtonColor(BuildContext context, ButtonType type) {
    switch (type) {
      case ButtonType.primary:
        return getTheme(context).colorScheme.primary;
      case ButtonType.secondary:
        return getTheme(context).colorScheme.secondary;
      case ButtonType.danger:
        return getTheme(context).colorScheme.error;
      case ButtonType.inverted:
        return Colors.transparent;
      case ButtonType.invertedDanger:
        return Colors.transparent;
      case ButtonType.invertedPrimary:
        return Colors.transparent;
      // Add more cases for other button types
    }
  }

  Color _getIconColor(BuildContext context, ButtonType type) {
    switch (type) {
      case ButtonType.primary:
        return getTheme(context).colorScheme.onPrimary;
      case ButtonType.secondary:
        return getTheme(context).colorScheme.onSecondary;
      case ButtonType.danger:
        return getTheme(context).colorScheme.onError;
      case ButtonType.inverted:
        return getTheme(context).colorScheme.onSurface;
      case ButtonType.invertedDanger:
        return getTheme(context).colorScheme.error;
      case ButtonType.invertedPrimary:
        return getTheme(context).colorScheme.primary;
      // Add more cases for other button types
    }
  }
}
