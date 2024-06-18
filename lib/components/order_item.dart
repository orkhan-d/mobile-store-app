import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/components/custom_badge.dart';
import 'package:store/providers/theme_provider.dart';
import 'package:store/services/orders_service.dart';

class OrderItem extends StatelessWidget {
  final Order order;

  const OrderItem({
    required this.order,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    int total = order.products.fold(0, (total, product) => total + product.price.toInt() * product.amount);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: true);

    double productImageSize = MediaQuery.of(context).size.width/6;

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Order #${order.id}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700
                ),
              ),
              Text(
                'Total: $total\$',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                )
              )
            ],
          ),
          const SizedBox(height: 8),
          Divider(
            thickness: 2,
            height: 2,
            color: themeProvider.currentTheme?.colorScheme.primary,
          ),
          const SizedBox(height: 8),
          const Text(
            "Products",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: productImageSize,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: order.products.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ProductPage(
                      //       product: order.products[index]
                      //     )
                      //   );
                      // )
                    },
                    child: CustomBadge(
                      label: Text(
                        'x${order.products[index].amount}',
                        style: TextStyle(
                          color: themeProvider.currentTheme?.colorScheme.onSecondary
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: themeProvider.currentTheme!.colorScheme.primary,
                            width: 1.5
                          )
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox.fromSize(
                            child: Image.network(
                              order.products[index].imageUrl,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}