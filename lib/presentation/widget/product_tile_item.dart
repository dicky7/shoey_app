import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoes_app/data/models/product_model.dart';
import 'package:shoes_app/utils/styles.dart';

class ProductTileItem extends StatelessWidget {
  final ProductModel product;
  const ProductTileItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              imageUrl: "https://shamo-backend.buildwithangga.id/storage/gallery/sW4VtliQPYnwvlbpxL5x6ZhKvbgBWT84OoiDyRsE.png",
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
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(color: kBlackColor),
                ),
                const SizedBox(height: 3),
                Text(
                  product.price.toString(),
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(color: kRedColor),
                )
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            iconSize: 30,
            onPressed: () {
            },
          ),
        ],
      ),
    );
  }
}
