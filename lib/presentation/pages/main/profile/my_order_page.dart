
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/data/models/transaction_model.dart';
import 'package:shoes_app/presentation/providers/transaction/transaction_providers.dart';
import 'package:shoes_app/presentation/widget/order_item_card.dart';
import 'package:shoes_app/utils/state_enum.dart';

import '../../../../utils/style/styles.dart';
import '../main_page.dart';

class MyOrderPage extends StatefulWidget {
  static const routeName = "my-order";
  const MyOrderPage({Key? key}) : super(key: key);

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<TransactionProviders>(context, listen: false).getTransaction(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: buildAppBar(context),
      body: Consumer<TransactionProviders>(
        builder: (context, providers, child) {
          final state = providers.state;
          if (state == ResultState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == ResultState.Success) {
            if (providers.transationList.isNotEmpty) {
              return buildListItem(providers.transationList);
            } else{
              return _buildEmptyState(context);
            }
          } else if(state == ResultState.Error){
            return Center(
              child: Text(providers.message),
            );
          }else{
            return Container();
          }
        },
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
            "Opss! Your Don't Have any order yet",
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

  Widget buildListItem(List<TransactiontModel> transactiontModel){
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      shrinkWrap: false,
      itemCount: transactiontModel.length,
      itemBuilder: (context, index) {
        final items = transactiontModel[index];
        return OrderItemCard(transaction: items);
      },
    );
  }
}
