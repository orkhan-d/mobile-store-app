import 'package:flutter/material.dart';
import 'package:store/components/product.dart';
import 'package:store/services/products_service.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  Future<List<Product>> products = getProducts();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          products = getProducts();
        });
      },
      child: FutureBuilder(
        future: products,
        builder: (context, snapshot) {
          return GridView.count(
            padding: const EdgeInsets.all(8),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.6,
            crossAxisCount: 2,
            children: List.generate(snapshot.data?.length ?? 8, (index) {
              return ProductCard(
                product: snapshot.data?[index] ?? testProduct,
                loading: snapshot.connectionState!=ConnectionState.done || snapshot.data == null,
              );
            }),
          );
        },
      ),
    );
  }
}
