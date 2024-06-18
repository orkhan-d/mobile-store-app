import 'package:credit_card_form/credit_card_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/colors.dart';
import 'package:store/components/button.dart';
import 'package:store/components/dropdown_button.dart';
import 'package:store/components/input.dart';
import 'package:store/enums.dart';
import 'package:store/providers/theme_provider.dart';
import 'package:store/services/cart_service.dart';
import 'package:store/services/orders_service.dart';

class OrderCreatePage extends StatefulWidget {
  final void Function() callback;
  
  const OrderCreatePage({
    required this.callback,
    super.key
  });

  @override
  State<OrderCreatePage> createState() => _OrderCreatePageState();
}

class _OrderCreatePageState extends State<OrderCreatePage> {
  TextEditingController shippingAddressController = TextEditingController();
  String? paymentMethod;
  CreditCardResult? result;
  String error = "";

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Order details",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 4),
          Divider(thickness: 2, color: themeProvider.currentTheme!.colorScheme.primary,),
          const SizedBox(height: 4),
          Input(
            placeholder: "Shipping address",
            controller: shippingAddressController,
            icon: Icons.local_shipping_rounded,
          ),
          const SizedBox(height: 16),
          DropdownButtonElement(
            items: const [
              'Sberbank',
              'Tinkoff',
            ],
            onChanged: (String value) {
              setState(() {
                paymentMethod = value;
              });
            },
            placeholder: "Payment method"
          ),
          const SizedBox(height: 16),
          CreditCardForm(
            theme: themeProvider.currentTheme==lightTheme ? LightCreditCardTheme() : DarkCreditCardTheme(),
            onChanged: (CreditCardResult result) {
              setState(() {
                this.result = result;
              });
            },
            hideCardHolder: true,
          ),
          error.isNotEmpty ? Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: Text(
                error,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
            ),
          ) : const SizedBox.shrink(),
          const SizedBox(height: 4),
          Divider(thickness: 2, color: themeProvider.currentTheme!.colorScheme.primary,),
          const SizedBox(height: 4),
          Button(
            callback: () async {
              if (paymentMethod!=null && shippingAddressController.text.isNotEmpty &&
                  ![result!.cardNumber, result!.expirationMonth,
                  result!.expirationYear, result!.cvc].contains("")) {
                widget.callback();
                createOrderAPI(
                  shippingAddress: shippingAddressController.text,
                  paymentMethod: paymentMethod!,
                  products: await getUserCartAPI()
                );
              } else {
                setState(() {
                  error = "Please fill in all fields";
                });
              }
            } ,
            type: ButtonType.primary,
            text: "Continue",
          ),
          Button(
            callback: Navigator.of(context).pop,
            type: ButtonType.inverted,
            text: "Cancel",
          )
        ],
      ),
    );
  }
}