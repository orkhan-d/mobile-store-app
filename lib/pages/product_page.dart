import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/components/button.dart';
import 'package:store/components/product.dart';
import 'package:store/components/review_add_bottom_sheet.dart';
import 'package:store/components/reviews_bottom_sheet.dart';
import 'package:store/enums.dart';
import 'package:store/providers/cart_provider.dart';
import 'package:store/providers/theme_provider.dart';
import 'package:store/services/cart_service.dart';
import 'package:store/services/products_service.dart';

class ProductPage extends StatelessWidget {
  final Product product;
  
  const ProductPage({
    required this.product,
    // required this.cartProvider,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    CartProvider cartProvider = Provider.of<CartProvider>(context, listen: true);

    Cart? cartProduct;
    final productCardWidth = MediaQuery.of(context).size.width / 2 - 20;

    Future<List<Product>> products = getProducts();

    try {
      cartProduct = cartProvider.cart.firstWhere(
        (element) => element.product.id == product.id,
      );
    } catch (e) {
      cartProduct = null;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(themeProvider.currentTheme!.appBarTheme.backgroundColor),
          ),
          icon: Icon(
            themeProvider.currentTheme!.platform == TargetPlatform.iOS
                ? Icons.arrow_back_ios
                : Icons.arrow_back,
            color: themeProvider.currentTheme!.colorScheme.secondary,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.25,
                child: Center(
                  child: SizedBox.fromSize(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        product.imageUrl
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  product.name,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  product.description,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Button(
                      callback: () {
                        showModalBottomSheet(
                          showDragHandle: true,
                          context: context,
                          builder: (context) {
                            return ReviewsBottomSheet(product: product);
                          }
                        );
                      },
                      text: "Reviews",
                      icon: Icons.star_rounded,
                      type: ButtonType.primary
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Button(
                      callback: () {
                        showModalBottomSheet(
                          isScrollControlled: false,
                          enableDrag: false,
                          context: context,
                          builder: (context) => ReviewAddBottomSheet(productId: product.id)
                        );
                      },
                      type: ButtonType.primary,
                      icon: Icons.edit,
                      text: "Add review",
                    ),
                  )
                ]
              ),
              // Divider(
              //   color: themeProvider.currentTheme!.colorScheme.primary,
              //   thickness: 2,
              // ),
              const SizedBox(height: 16),
              Text(
                "Other products you might like",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                height: productCardWidth*10/6+8*2,
                child: FutureBuilder(
                  future: products,
                  builder: (context, snapshot) {
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data?.length ?? 8,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: index<(snapshot.data?.length ?? 8)
                            ? const EdgeInsets.only(right: 8)
                            : EdgeInsets.zero,
                          width: productCardWidth+8,
                          child: ProductCard(
                            loading: snapshot.connectionState != ConnectionState.done,
                            product: snapshot.data?[index] ?? testProduct
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ListTile(
                    leading: Icon(
                      Icons.shopping_cart,
                      color: themeProvider.currentTheme!.colorScheme.primary,
                      size: 32,
                    ),
                    title: Text(
                      '${product.price}\$',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                      'In cart ${cartProduct?.amount ?? 0} items',
                    )
                  )
                ),
                Button(
                  icon: Icons.remove,
                  type: ButtonType.primary,
                  callback: () {
                    cartProvider.reduceProductAmountInCart(product);
                  },
                ),
                Button(
                  icon: Icons.add,
                  type: ButtonType.primary,
                  callback: () {
                    cartProvider.addProductToCart(product);
                  },
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}