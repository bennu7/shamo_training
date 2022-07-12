import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shamo/pages/home/main_page.dart';

import '../theme.dart';

class CheckOutSuccessPage extends StatelessWidget {
  const CheckOutSuccessPage({Key? key}) : super(key: key);
  static const routeName = "/checkout-success";

  @override
  Widget build(BuildContext context) {
    Widget content() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon_empty_cart.png',
              width: 80,
            ),
            const SizedBox(height: 20),
            Text(
              "You made a transaction",
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Stay at home while we\nprepare your dream shoes",
              style: secondaryTextStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: defaultMargin),
            Container(
              width: 196,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: primaryColor,
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, MainPage.routeName, (route) => false);
                },
                child: Text(
                  "Order Other Shoes",
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: 196,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xff39374B),
              ),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "View My Order",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: medium,
                    color: const Color(0xffB7B6BF),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: AppBar(
        backgroundColor: backgroundColor1,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Checkout Success",
          style: primaryTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: content(),
    );
  }
}
