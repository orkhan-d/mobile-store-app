import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/components/button.dart';
import 'package:store/enums.dart';
import 'package:store/providers/cart_provider.dart';
import 'package:store/services/cart_service.dart';

class CartItem extends StatelessWidget {
  final Cart item;
  const CartItem({
    required this.item,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.product.name),
      subtitle: Text("${item.amount} x ${item.product.price}\$"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Button(
            icon: Icons.delete,
            type: ButtonType.invertedDanger,
            callback: () {
              Provider.of<CartProvider>(context, listen: false).removeProductFromCart(item.product);
            },
          ),
          Button(
            icon: Icons.remove,
            type: ButtonType.inverted,
            callback: () {
              Provider.of<CartProvider>(context, listen: false).reduceProductAmountInCart(item.product);
            },
          ),
          Button(
            icon: Icons.add,
            type: ButtonType.inverted,
            callback: () {
              Provider.of<CartProvider>(context, listen: false).addProductToCart(item.product);
            },
          ),
        ],
      ),
    );
  }
}