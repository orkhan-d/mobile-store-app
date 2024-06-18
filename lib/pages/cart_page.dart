import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/components/button.dart';
import 'package:store/components/cart_item.dart';
import 'package:store/components/payment_bottom_sheet.dart';
import 'package:store/enums.dart';
import 'package:store/providers/auth_provider.dart';
import 'package:store/providers/cart_provider.dart';
import 'package:store/providers/nav_provider.dart';
import 'package:store/providers/theme_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool paymentProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, cartProvider, child) {
      return RefreshIndicator(
          onRefresh: () async {
            setState(() {
              Provider.of<CartProvider>(context, listen: false).updateCart();
            });
          },
          child: (() {
            if (cartProvider.cart.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.remove_shopping_cart_rounded,
                      size: 100,
                      color: Provider.of<ThemeProvider>(context, listen: true)
                          .currentTheme?.colorScheme.primary
                    ),
                    const Text(
                      'No products in cart',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                )
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartProvider.cart.length,
                      itemBuilder: (context, index) =>
                        CartItem(item: cartProvider.cart[index])
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Total: ${cartProvider.cart.map((e) => 
                            e.product.price*e.amount).reduce((a,b) => a+b)}\$',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        Button(
                          callback: () {
                            cartProvider.clearCart();
                          },
                          type: ButtonType.danger,
                          icon: Icons.delete_forever_rounded,
                          text: 'Clear',
                        ),
                        Button(
                          callback: () async {
                            if (Provider.of<AuthProvider>(context, listen: false).currentUser == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Row(
                                    children: [
                                      Icon(Icons.lock_rounded, color: Colors.red),
                                      SizedBox(width: 10),
                                      Text(
                                        'You need to be logged in to checkout',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              );
                              Provider.of<NavigationProvider>(context, listen: false).setIndex(0);
                            }
                            else {
                              await showModalBottomSheet(
                                useSafeArea: true,
                                isDismissible: false,
                                enableDrag: false,
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => OrderBottomSheet(callback: (bool val) {
                                  paymentProcessing = val;
                                  setState(() {});
                                },)
                              );
                              if (paymentProcessing) {
                                Provider.of<CartProvider>(context, listen: false).clearCart();
                              }
                            }
                          },
                          type: ButtonType.primary,
                          icon: Icons.payment_rounded,
                          text: 'Checkout',
                        ),
                      ],
                    ),
                  ),
                ]
              );
            }
          })(),
      );
    });
  }
}