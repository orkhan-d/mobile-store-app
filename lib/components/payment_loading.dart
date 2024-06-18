import 'package:flutter/material.dart';
import 'package:store/colors.dart';
import 'package:store/components/button.dart';
import 'package:store/enums.dart';

class PaymentLoadingBottomSheet extends StatelessWidget {
  const PaymentLoadingBottomSheet({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) => FutureBuilder(
        future: Future.delayed(const Duration(seconds: 3)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Column(
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      size: 80,
                      color: successColor
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Payment successful',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16,),
                Button(
                  text: 'Dismiss',
                  type: ButtonType.inverted,
                  callback: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          } else {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text(
                  'Processing payment...',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}