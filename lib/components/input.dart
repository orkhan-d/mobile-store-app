import 'package:flutter/material.dart';
import 'package:store/services/theme_service.dart';

class Input extends StatefulWidget {
  final String placeholder;
  final TextEditingController controller;
  final int maxLines;
  final bool obscure;
  final bool enabled;
  final IconData? icon;

  const Input({
    required this.placeholder,
    required this.controller,
    this.obscure = false,
    this.enabled = true,
    this.maxLines = 1,
    this.icon,
    super.key
  });

  @override
  InputState createState() => InputState();
}

class InputState extends State<Input> {
  bool _obscureText = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.maxLines > 1 ? TextInputType.multiline : TextInputType.text,
      controller: widget.controller,
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      obscureText: widget.obscure && !_obscureText,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: getTheme(context).colorScheme.primary,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0)
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: getTheme(context).colorScheme.secondary,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0)
        ),
        labelText: widget.placeholder,
        prefixIcon: widget.icon!=null ? Icon(widget.icon) : null,
        suffixIcon: widget.obscure
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
              )
            : null,
      ),
    );
  }
}