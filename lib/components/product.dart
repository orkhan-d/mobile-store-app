import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:store/colors.dart';
import 'package:store/components/button.dart';
import 'package:store/enums.dart';
import 'package:store/pages/product_page.dart';
import 'package:store/providers/cart_provider.dart';
import 'package:store/providers/theme_provider.dart';
import 'package:store/services/products_service.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final bool loading;
  
  const ProductCard(
    {
      required this.loading,
      this.product = testProduct,
      super.key
    }
  );

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  int getProductAmountInCart(Product product) {
    CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);
    try {
      return cartProvider.cart.firstWhere(
        (element) => element.product.id == product.id,
      ).amount;
    } catch (e) {
      return 0;
    };
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: true);

    if (loading) {
      return SizedBox(
        height: 800,
        child: Container(
          color: Colors.grey[900],
        )
      );
    } else {
      int amountInCart = getProductAmountInCart(widget.product);

      return Skeletonizer(
        effect: (themeProvider.currentTheme ?? lightTheme) == lightTheme
          ? lightShimmerEffect
          : darkShimmerEffect,
        enabled: widget.loading,
        child: GestureDetector(
          onTap: () {
            if (!widget.loading) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductPage(
                    product: widget.product,
                  ),
                ),
              
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: themeProvider.currentTheme?.cardColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    widget.product.imageUrl,
                    fit: BoxFit.contain,
                    height: 180,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      else {
                        return SizedBox(
                          height: 180,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                : null,
                            ),
                          ),
                        );
                      }
                    },
                    errorBuilder: (context, child, stackTrace) {
                      return const SizedBox(
                        height: 180,
                        child: Center(
                          child: Icon(
                            Icons.error,
                          ),
                        )
                      );
                    },
                  ),
                ),
                Text(
                  widget.product.name,
                  style: Theme.of(context).textTheme.titleLarge,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.fade,
                ),
                Text(
                  widget.product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Button(
                      callback: () {
                        if (!widget.loading) {
                          Provider.of<CartProvider>(context, listen: false)
                              .reduceProductAmountInCart(widget.product);
                        }
                      },
                      type: ButtonType.primary,
                      icon: Icons.remove,
                    ),
                    Text(
                      '${widget.product.price}\$',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Button(
                      callback: () {
                        if (!widget.loading) {
                          if (!widget.loading) {
                            Provider.of<CartProvider>(context, listen: false)
                                .addProductToCart(widget.product);
                          }
                        }
                      },
                      type: ButtonType.primary,
                      icon: Icons.add,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}