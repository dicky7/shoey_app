import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shoes_app/data/models/product_model.dart';
import 'package:shoes_app/utils/style/styles.dart';

import '../../data/models/table/cart_table.dart';

class CheckoutItemCard extends StatelessWidget {
  final CartTable cartItem;
  const CheckoutItemCard({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 17),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              imageUrl: cartItem.photo,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              width: 110,
              height: 105,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // NAME PRODUCT AND ICON TRASH
                Text(
                  cartItem.name,
                  style: Theme.of(context).textTheme.headline6?.copyWith(color: kBlackColor, fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),

                // COLOR and Size
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: kBlackColor,
                      maxRadius: 8,

                    ),
                    const SizedBox(width: 5),
                    Text(
                      "Black | Size = 42",
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(color: kGreyColor),
                    ),
                  ],
                ),
                const SizedBox(height: 15,),

                // PRICE & COUNTER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      NumberFormat.currency(
                        locale: "en_us",
                        customPattern: "\$",
                        decimalDigits: 0
                      ).format(cartItem.quantity * cartItem.price),
                      style: Theme.of(context).textTheme.headline6?.copyWith(color: kRedColor, fontSize: 16),
                    ),
                    const SizedBox(width: 5),
                    CircleAvatar(
                      maxRadius: 20,
                      backgroundColor: kGreyColor.withOpacity(0.5),
                      child: Center(
                        child: Text(
                          cartItem.quantity.toString(),
                          style: Theme.of(context).textTheme.headline6?.copyWith(color: kBlackColor, fontSize: 17),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
