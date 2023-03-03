import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/data/models/product_model.dart';
import 'package:shoes_app/data/models/table/product_table.dart';
import 'package:shoes_app/presentation/pages/main/home/detail_product_page.dart';
import 'package:shoes_app/presentation/providers/wishlist/wishlist_providers.dart';
import 'package:shoes_app/utils/constant.dart';
import 'package:shoes_app/utils/style/styles.dart';

import '../../utils/app_utils.dart';

class ProductTileItem extends StatelessWidget {
  final ProductTable product;
  const ProductTileItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailProductPage.routeName, arguments: product.id);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 30, right: 30, top: 20),
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: kPrimaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: product.photo,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.headline6?.copyWith(color: kBlackColor, fontSize: 16),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    NumberFormat.currency(
                      locale: "en_US",
                      decimalDigits: 0,
                      symbol: "\$ "
                    ).format(product.price),
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(color: kRedColor),
                  )
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.favorite),
              iconSize: 30,
              onPressed: () async{
                //when on user pressed it remove the item
                await Provider.of<WishlistProviders>(context,listen: false).removeWishlist(product.id);

                //for showing status message success or not
                final message = Provider.of<WishlistProviders>(context,listen: false).wishlistMessage;
                if (message == wishlistRemoveSuccessMessage) {
                  showSuccessSnackbar(context, message);
                }else{
                  showSuccessSnackbar(context, message);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
