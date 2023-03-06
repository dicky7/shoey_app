import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/data/models/table/cart_table.dart';
import 'package:shoes_app/presentation/pages/main/cart/checkout_page.dart';
import 'package:shoes_app/presentation/pages/main/main_page.dart';
import 'package:shoes_app/presentation/providers/cart/cart_providers.dart';
import 'package:shoes_app/presentation/widget/cart_card.dart';
import 'package:shoes_app/utils/state_enum.dart';
import 'package:shoes_app/utils/style/styles.dart';

class CartPage extends StatefulWidget {
  static const routeName = "cart-page";
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<CartProviders>(context, listen: false).getCartList(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          toolbarHeight: 87,
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          leading: BackButton(color: kBlackColor),
          title: Text(
            "My Cart",
            style: Theme.of(context).textTheme.headline6?.copyWith(color: kGreyColor),
          ),
        ),
        body: Consumer<CartProviders>(
          builder: (context, providers, child) {
            final state = providers.state;
            if (state == ResultState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } if (state == ResultState.Success) {
              if (providers.cartList.isNotEmpty) {
                return buildCartList(context, providers.cartList);
              }else{
                return _buildEmptyState(context);
              }
            } else if(state ==ResultState.Error){
              return Center(
                child: Text(providers.message),
              );
            }else{
              return Container();
            }
          },

      ),
        bottomNavigationBar: Consumer<CartProviders>(
          builder: (context, providers, child) {
            final state = providers.state;
            if (state == ResultState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } if (state == ResultState.Success) {
              if (providers.cartList.isNotEmpty) {
                return buildButtonPrice(context, providers.totalPrice, providers.cartList);
              }else{
                return _buildEmptyState(context);
              }
            } else if(state ==ResultState.Error){
              return Center(
                child: Text(providers.message),
              );
            }else{
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context){
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart,
            size: 80,
            color: kBlackColor,
          ),
          const SizedBox(height: 20),
          Text(
            "Opss! Your Cart is Empty",
            style: Theme.of(context).textTheme.subtitle1?.copyWith(color: kBlackColor),
          ),
          const SizedBox(height: 12),
          Text(
            "Let's find your favorite shoes",
            style: Theme.of(context).textTheme.subtitle2?.copyWith(color: kGreyColor),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 115, vertical: 20),
            child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: kBlueDark,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                child: Text(
                  "Explore Store",
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(color: kPrimaryColor),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, MainPage.routeName);

                }
            ),
          )
        ],
      ),
    );
  }

  Widget buildCartList(BuildContext context, List<CartTable> cartList){
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 25, left: 20, right: 20),
      itemCount: cartList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final cart = cartList[index];
        return CartCard(cartProduct: cart);

      },
    );
  }

  Widget buildButtonPrice(BuildContext context, int totalPrice, List<CartTable> carts){
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(13),
          topRight: Radius.circular(13)
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              Text(
                "Total Price",
                style: Theme.of(context).textTheme.subtitle2?.copyWith(color: kGreyColor),
              ),
              const SizedBox(height: 3),
              Text(
                NumberFormat.currency(
                  locale: "en_us",
                  symbol: "\$",
                  decimalDigits: 0
                ).format(totalPrice),
                style: Theme.of(context).textTheme.headline6?.copyWith(color: kRedColor, fontSize: 22),
              ),
                          ],
          ),
          const SizedBox(width: 30),
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: kBlackColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)
                ),
                elevation: 3,
                padding: const EdgeInsets.all(14)
              ),
              child: Text(
                "Checkout",
                style: Theme.of(context).textTheme.button?.copyWith(color: kPrimaryColor),
              ),
              onPressed: () {
                Navigator.pushNamed(context, CheckoutPage.routeName, arguments: carts);

              },
            ),
          )
        ],
      ),
    );
  }
}
