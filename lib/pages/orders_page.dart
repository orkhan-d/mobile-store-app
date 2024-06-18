import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/components/order_item.dart';
import 'package:store/providers/theme_provider.dart';
import 'package:store/services/orders_service.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: true);

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
        title: const Text('Orders'),
      ),
      body: FutureBuilder(
        future: getOrdersAPI(),
        builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Order> orders = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: orders.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    
                  },
                  child: OrderItem(order: orders[index])
                );
              },
            );
          }
        },
      ),
    );
  }
}