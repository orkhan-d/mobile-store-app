import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/providers/theme_provider.dart';

class DropdownButtonElement extends StatefulWidget {
  final List<String> items;
  final String placeholder;
  final void Function(String) onChanged;

  const DropdownButtonElement(
    {
      required this.placeholder,
      required this.items,
      required this.onChanged,
      super.key
    }
  );

  @override
  // ignore: library_private_types_in_public_api
  _DropdownButtonElementState createState() => _DropdownButtonElementState();
}

class _DropdownButtonElementState extends State<DropdownButtonElement> {
  String? _selectedItem;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: true);

    return DropdownButtonFormField2<String>(
      value: _selectedItem,
      onChanged: (String? newValue) {
        setState(() {
          _selectedItem = newValue ?? _selectedItem;
          widget.onChanged(newValue ?? '');
        });
      },
      isExpanded: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      hint: Text(widget.placeholder),
      // hint: Row(
      //   children: [
      //     const Icon(Icons.payment_rounded),
      //     const SizedBox(width: 8),
      //     Text(widget.placeholder)
      //   ],
      // ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: themeProvider.currentTheme!.colorScheme.onPrimary,
          border: Border.all(
            color: themeProvider.currentTheme!.colorScheme.primary,
          ),
        ),
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(40),
          thickness: WidgetStateProperty.all<double>(6),
          thumbVisibility: WidgetStateProperty.all<bool>(true),
        ),
      ),
      items: widget.items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList()
    );
  }
}