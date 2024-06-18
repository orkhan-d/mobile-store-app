import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/components/button.dart';
import 'package:store/components/input.dart';
import 'package:store/enums.dart';
import 'package:store/providers/auth_provider.dart';
import 'package:store/providers/theme_provider.dart';
import 'package:store/services/reviews_service.dart';

class ReviewAddBottomSheet extends StatefulWidget {
  final int productId;

  const ReviewAddBottomSheet({
    required this.productId,
    super.key
  });

  @override
  State<ReviewAddBottomSheet> createState() => _ReviewAddBottomSheetState();
}

class _ReviewAddBottomSheetState extends State<ReviewAddBottomSheet> {
  TextEditingController reviewTextController = TextEditingController();
  
  int rating = 0;

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: true);
    
    if (authProvider.currentUser == null) {
      return Center(
        child: Text(
          "You need to be logged in to add a review",
          style: themeProvider.currentTheme!.textTheme.bodyMedium,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add review",
              textAlign: TextAlign.center,
              style: themeProvider.currentTheme!.textTheme.displayLarge,
            ),
            const SizedBox(height: 16.0),
            Column(
              children: [
                Input(
                  placeholder: "Text of review",
                  controller: reviewTextController,
                  maxLines: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(5, (index) {
                        int starRating = index + 1;
                        return GestureDetector(
                          child: Icon(
                            Icons.star,
                            size: 40,
                            color: rating >= starRating
                            ? Colors.yellow.shade600
                            : themeProvider.currentTheme!.colorScheme.secondary
                          ),
                          onTap: () {
                            setState(() {
                              rating = starRating;
                            });
                          },
                        );
                      }
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Button(
              callback: () {
                addReview(
                  productId: widget.productId,
                  rating: rating,
                  info: reviewTextController.text,
                  token: authProvider.currentUser!.token!
                );
              },
              text: "Submit",
              type: ButtonType.primary
            ),
          ],
        ),
      ),
    );
  }
}