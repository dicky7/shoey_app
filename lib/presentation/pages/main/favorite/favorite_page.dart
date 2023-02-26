import 'package:flutter/material.dart';
import 'package:shoes_app/presentation/widget/product_tile_item.dart';
import 'package:shoes_app/utils/helper_utils.dart';

import '../../../../utils/style/styles.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = "favorite-page";
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: buildAppBar(context),
        body: _buildListProduct(BuildContext)
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: kPrimaryColor,
        toolbarHeight: 87,
        centerTitle: true,
        elevation: 3,
        title: Text(
          "Shoey Wishlist",
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
            Icons.favorite,
            size: 80,
            color: kBlackColor,
          ),
          const SizedBox(height: 20),
          Text(
            " You don't have dream shoes?",
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

                }
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListProduct(BuildContext){
    return ListView.builder(
      shrinkWrap: false,            // condition false mean listView builder take all screen space (match parrent)
      itemCount: productList.length,
      itemBuilder: (context, index) {
        final product = productList[index];
        return ProductTileItem(product: product);
      },
    );
  }
}
