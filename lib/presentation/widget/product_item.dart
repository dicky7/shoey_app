import 'package:flutter/material.dart';
import 'package:shoes_app/presentation/pages/main/home/detail_product_page.dart';
import 'package:shoes_app/utils/style/styles.dart';

import '../../data/models/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailProductPage.routeName, arguments: product.id);
      },
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(34)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: product.galleries[1].url,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                  height: double.infinity,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 19,
          ),
          Expanded(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    product.price.toString(),
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(color: kRedColor)
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.headline5?.copyWith(color: kBlackColor, fontSize: 19),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
