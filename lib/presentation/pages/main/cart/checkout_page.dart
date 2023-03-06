import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/presentation/pages/main/cart/checkout_success_page.dart';
import 'package:shoes_app/presentation/providers/cart/checkout_providers.dart';
import 'package:shoes_app/presentation/widget/checkout_item_card.dart';
import 'package:shoes_app/presentation/widget/custom_button.dart';
import 'package:shoes_app/utils/state_enum.dart';
import 'package:shoes_app/utils/style/styles.dart';

import '../../../../data/models/table/cart_table.dart';
import '../../../../utils/app_utils.dart';

class CheckoutPage extends StatefulWidget {
  static const routeName = "checkout-page";
  final List<CartTable> cartList;
  const CheckoutPage({Key? key, required this.cartList}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      //calling this method is to set the list of items in the cart to a new value, provided as a parameter to the method.
      () => Provider.of<CheckoutProviders>(context, listen: false)
          ..setCartItems(widget.cartList)
          ..getTotalItem(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: buildAppBar(context),
        body: Consumer<CheckoutProviders>(
          builder: (context, providers, child) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildListItem(context, providers.cartList),
                    buildDetailAdress(context),
                    buildPaymentSummary(context, providers.totalItem, providers.totalPrice),
                    const SizedBox(height: 35),
                    buildCheckout(context)
                  ],
                ),
              ),
            );
          },
        )
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: BackButton(color: kBlackColor),
      toolbarHeight: 87,
      centerTitle: true,
      backgroundColor: kPrimaryColor,
      title: Text(
        "Checkout Details",
        style: Theme.of(context).textTheme.headline6?.copyWith(color: kGreyColor),
      ),
    );
  }

  Widget buildListItem(BuildContext context, List<CartTable> cartList){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Order List",
          style: Theme.of(context).textTheme.headline6?.copyWith(color: kBlackColor, fontSize: 22),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.cartList.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final cartItem = widget.cartList[index];
            return CheckoutItemCard(cartItem: cartItem);
          },
        ),
      ],
    );
  }

  Container buildDetailAdress(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: kPrimaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Adress Details",
            style: Theme.of(context).textTheme.headline6?.copyWith(color: kBlackColor),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                maxRadius: 20,
                backgroundColor: kGreyColor.withOpacity(0.3),
                child: Center(
                  child: Icon(Icons.my_location, color: kBlackColor, size: 20),
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Store Location",
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(color: kGreyColor),
                  ),
                  Text(
                    "Adidas Singapore",
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(color: kBlackColor, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
          Container(
              margin: const EdgeInsets.only(left: 12),
              height: 25,
              child: VerticalDivider(color: kGreyColor, thickness: 3)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                maxRadius: 20,
                backgroundColor: kGreyColor.withOpacity(0.3),
                child: Center(
                  child: Icon(Icons.location_on_rounded, color: kBlackColor, size: 20),
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My Address",
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(color: kGreyColor),
                  ),
                  Text(
                    "Jakarta",
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(color: kBlackColor, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),

        ],
      ),
    );
  }

  Widget buildPaymentSummary(BuildContext context, int totalItems, int totalPrice){
    return Container(
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kPrimaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Adress Details",
            style: Theme.of(context).textTheme.headline6?.copyWith(color: kBlackColor),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Product Quantity",
                style: Theme.of(context).textTheme.subtitle2?.copyWith(color: kGreyColor),
              ),
              Text(
                totalItems.toString(),
                style: Theme.of(context).textTheme.headline6?.copyWith(color: kBlackColor, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Product Price",
                style: Theme.of(context).textTheme.subtitle2?.copyWith(color: kGreyColor),
              ),
              Text(
                NumberFormat.currency(
                    locale: "en_us",
                    symbol: "\$",
                    decimalDigits: 0
                ).format(totalPrice),
                style: Theme.of(context).textTheme.headline6?.copyWith(color: kBlackColor, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shipping",
                style: Theme.of(context).textTheme.subtitle2?.copyWith(color: kGreyColor),
              ),
              Text(
                "\$15",
                style: Theme.of(context).textTheme.headline6?.copyWith(color: kRedColor, fontSize: 16),
              ),
            ],
          ),
          Divider(thickness: 1, color: kGreyColor),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: Theme.of(context).textTheme.headline6?.copyWith(color: kBlackColor, fontSize: 16),
              ),
              Text(
                NumberFormat.currency(
                    locale: "en_us",
                    symbol: "\$",
                    decimalDigits: 0
                ).format(totalPrice + 15),
                style: Theme.of(context).textTheme.headline6?.copyWith(color: kGreenColor, fontSize: 16),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildCheckout(BuildContext context) {
    return CustomButton(
      title: "Checkout Now",
      onPressed: () {
        Provider.of<CheckoutProviders>(context, listen: false).checkoutOrder(
          onFailure: (message) => showErrorSnackbar(context, message),
          onSuccess: (success) => Navigator.pushNamed(context, CheckoutSuccessPage.routeName),
        );
        Provider.of<CheckoutProviders>(context, listen: false).removeAllItem();

      },
    );
  }
}
