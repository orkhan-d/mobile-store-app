import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/providers/theme_provider.dart';
import 'package:store/services/products_service.dart';
import 'package:store/services/reviews_service.dart';

class ReviewsBottomSheet extends StatefulWidget {
  final Product product;

  const ReviewsBottomSheet({
    required this.product,
    super.key
  });

  @override
  State<ReviewsBottomSheet> createState() => _ReviewsBottomSheetState();
}

class _ReviewsBottomSheetState extends State<ReviewsBottomSheet> {
  Future<List<Review>>? reviews;

  @override
  void initState() {
    super.initState();
    reviews = getReviewsOfProduct(widget.product.id);
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    
    return FutureBuilder(
      future: reviews,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              DateTime localCreatedAt = snapshot.data![index].createdAt.toLocal();
              return Container(
                width: MediaQuery.of(context).size.width-16,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: themeProvider.currentTheme!.colorScheme.primary,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data?[index].user.name ?? 'Anonymous',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            "  [${snapshot.data![index].rating.toString()}/5",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Icon(
                            Icons.star_rate,
                            color: Colors.yellow.shade600,
                          ),
                          Text(
                            "]",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Expanded(
                            child:Text(
                              "${localCreatedAt.day.toString().padLeft(2, '0')}-${localCreatedAt.month.toString().padLeft(2, '0')}-${localCreatedAt.year}",
                              textAlign: TextAlign.right,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: themeProvider.currentTheme!.colorScheme.secondary,
                      thickness: 1,
                    ),
                    Text(
                      snapshot.data?[index].info ?? '',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                )
              );
              // return ListTile(
              //   title: Text(
              //     snapshot.data?[index].user.name ?? 'Anonymous',
              //     style: Theme.of(context).textTheme.titleMedium,
              //   ),
              //   subtitle: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         snapshot.data?[index].info ?? '',
              //         style: Theme.of(context).textTheme.bodyMedium,
              //       ),
              //       Text(
              //         snapshot.data?[index].createdAt.toString() ?? '',
              //         style: Theme.of(context).textTheme.bodyMedium,
              //       ),
              //     ],
              //   ),
              // );
            },
          );
        }
        else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }
}