import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/presentation/pages/main/main_page.dart';
import 'package:shoes_app/presentation/providers/wishlist/wishlist_providers.dart';
import 'package:shoes_app/presentation/widget/product_tile_item.dart';
import 'package:shoes_app/utils/constant.dart';
import 'package:shoes_app/utils/helper_utils.dart';

import '../../../../data/models/table/product_table.dart';
import '../../../../utils/state_enum.dart';
import '../../../../utils/style/styles.dart';

class WishlistPage extends StatefulWidget {
  static const routeName = "favorite-page";
  const WishlistPage({Key? key}) : super(key: key);

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<WishlistProviders>(context, listen: false).getWishlistShoes()
    );
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context)!);
    super.didChangeDependencies();
  }

  @override
  void didPopNext() {
    Future.microtask(() {
      Provider.of<WishlistProviders>(context, listen: false).getWishlistShoes();
    });
    super.didPopNext();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: buildAppBar(context),
        body: Consumer<WishlistProviders>(
          builder: (context, providers, child) {
            final state = providers.state;
            if (state == ResultState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state == ResultState.Success) {
              if (providers.wishlistProduct.isNotEmpty) {
                return _buildListProduct(providers.wishlistProduct);
              } else{
                return _buildEmptyState(context);
              }
            } else if (state == ResultState.Error) {
              return Center(
                child: Text(providers.message),
              );
            } else{
              return Container();
            }
          },
        )
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
                  Navigator.pushReplacementNamed(context, MainPage.routeName);

                }
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListProduct(List<ProductTable> productTable){
    return ListView.builder(
      shrinkWrap: false,            // condition false mean listView builder take all screen space (match parrent)
      itemCount: productTable.length,
      itemBuilder: (context, index) {
        final product = productTable[index];
        return ProductTileItem(product: product);
      },
    );
  }
}
