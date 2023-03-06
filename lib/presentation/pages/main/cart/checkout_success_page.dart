import 'package:flutter/material.dart';
import 'package:shoes_app/presentation/widget/custom_button.dart';

import '../../../../utils/style/styles.dart';
import '../main_page.dart';
import '../profile/my_order_page.dart';

class CheckoutSuccessPage extends StatelessWidget {
  static const routeName = 'checkout-success';
  const CheckoutSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: buildAppBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: kBlackColor,
          ),
          const SizedBox(height: 20),
          Text(
            "You made a transaction",
            style: Theme.of(context).textTheme.headline6?.copyWith(color: kBlackColor),
          ),
          const SizedBox(height: 12),
          Text(
            "Stay at home while we prepare your dream shoes",
            style: Theme.of(context).textTheme.subtitle1?.copyWith(color: kGreyColor),
            textAlign: TextAlign.center,
          ),
          CustomButton(
              margin: const EdgeInsets.only(left: 90, right: 90, top: 30, bottom: 10),
              title: "Order Other Shoes",
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, MainPage.routeName, (route) => false);
              },
          ),
          CustomButton(
            color: kBlackColor.withOpacity(0.7),
            margin: const EdgeInsets.symmetric(horizontal: 90),
            title: "View My Order",
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, MyOrderPage.routeName, (route) => false);
            },
          )
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 87,
      centerTitle: true,
      backgroundColor: kPrimaryColor,
      title: Text(
        "Checkout Success",
        style: Theme.of(context).textTheme.headline6?.copyWith(color: kGreyColor),
      ),
    );
  }
}
