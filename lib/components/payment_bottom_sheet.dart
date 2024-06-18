import 'package:flutter/material.dart';
import 'package:store/components/payment_loading.dart';
import 'package:store/pages/order_create_page.dart';

class OrderBottomSheet extends StatefulWidget {
  final void Function(bool) callback;
  const OrderBottomSheet(
    {
      required this.callback,
      super.key
    }
  );

  @override
  State<OrderBottomSheet> createState() => _OrderBottomSheetState();
}

class _OrderBottomSheetState extends State<OrderBottomSheet> {
  bool processing = false;

  @override
  Widget build(BuildContext context) {
    if (processing) {
      return const PaymentLoadingBottomSheet();
    } else {
      return OrderCreatePage(callback: () {
        processing = true;
        widget.callback(true);
        setState(() {});
      });
    }
  }
}