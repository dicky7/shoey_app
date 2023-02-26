import 'package:flutter/material.dart';
import 'package:shoes_app/presentation/widget/order_item_card.dart';

import '../../../../utils/style/styles.dart';

class MyOrderPage extends StatelessWidget {
  static const routeName = "my-order";
  const MyOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: buildAppBar(context),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildListItem()
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(

      backgroundColor: kPrimaryColor,
      toolbarHeight: 87,
      leading: BackButton(color: kBlackColor),
      centerTitle: true,
      elevation: 3,
      title:  Text(
        "My Orders",
        style: Theme.of(context).textTheme.headline6?.copyWith(color: kGreyColor),
      ),
    );
  }

  Widget buildListItem(){
    return Expanded(
      child: ListView(
        shrinkWrap: false,
        children: [
          OrderItemCard(),
          OrderItemCard(),
          OrderItemCard()
        ],
      ),
    );
  }
}
