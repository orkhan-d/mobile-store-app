import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/colors.dart';
import 'package:store/components/button.dart';
import 'package:store/components/custom_badge.dart';
import 'package:store/enums.dart';
import 'package:store/pages/cart_page.dart';
import 'package:store/pages/products_page.dart';
import 'package:store/pages/profile_page.dart';
import 'package:store/providers/cart_provider.dart';
import 'package:store/providers/nav_provider.dart';
import 'package:store/providers/theme_provider.dart';
import 'package:store/services/theme_service.dart';

class MainScreen extends StatelessWidget {
  final List<Widget> _pages = const [
    ProfilePage(),
    ProductsPage(),
    CartPage()
  ];

  const MainScreen({super.key});

  Widget _getCartIcon(BuildContext context, bool outlined) {
    CartProvider cartProvider = Provider.of<CartProvider>(context, listen: true);

    if (cartProvider.cart.isEmpty) {
      return outlined ? const Icon(Icons.shopping_cart_outlined) : const Icon(Icons.shopping_cart);
    } else {
      int cartAmount = cartProvider.cart.map((e) => e.amount).reduce((a, b) => a+b);
      return CustomBadge(
        label: Text(cartAmount.toString()),
        child: outlined
        ? const Icon(Icons.shopping_cart_outlined)
        : const Icon(Icons.shopping_cart)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    NavigationProvider navigationProvider = Provider.of<NavigationProvider>(context, listen: true);

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(' Store'),
          ],
        ),
        actions: [
          Button(
            type: ButtonType.inverted,
            icon: Provider.of<ThemeProvider>(context, listen: true).currentTheme==lightTheme
                ? Icons.light_mode_rounded
                : Icons.dark_mode_rounded,
            callback: () {
              switchTheme(context);
            }
          )
        ],
      ),
      body: SafeArea(
        child: IndexedStack(
          index: navigationProvider.index,
          children: _pages,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationProvider.index,
        onDestinationSelected: (int index) {
          navigationProvider.setIndex(index);
        },
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: "Profile",
          ),
          const NavigationDestination(
            icon: Icon(Icons.apps_rounded),
            selectedIcon: Icon(Icons.apps_rounded),
            label: "Products",
          ),
          NavigationDestination(
            icon: _getCartIcon(context, true),
            selectedIcon: _getCartIcon(context, false),
            label: "Cart",
          ),
        ],
      ),
    );
  }
}