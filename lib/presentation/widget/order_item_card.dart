import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shoes_app/data/models/product_model.dart';
import 'package:shoes_app/data/models/transaction_model.dart';
import 'package:shoes_app/utils/style/styles.dart';

class OrderItemCard extends StatelessWidget {
  final TransactiontModel transaction;
  const OrderItemCard({Key? key, required this.transaction}) : super(key: key);

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
              imageUrl: "https://shamo-backend.buildwithangga.id/storage/gallery/sW4VtliQPYnwvlbpxL5x6ZhKvbgBWT84OoiDyRsE.png",
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              width: 115,
              height: 125,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // NAME PRODUCT
                Text(
                  transaction.items[0].product.name,
                  style: Theme.of(context).textTheme.headline6?.copyWith(color: kBlackColor, fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),

                // COLOR and Size
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: kRedColor,
                      maxRadius: 8,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "Red  |  ",
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(color: kGreyColor),
                    ),
                    Text(
                      "Qty = ${transaction.items[0].quantity}",
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(color: kGreyColor),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Container(
                  margin: const EdgeInsets.only(top: 7, bottom: 10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: kGreyColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(
                    transaction.status,
                    style: Theme.of(context).textTheme.caption?.copyWith(color: kBlackColor, fontWeight: FontWeight.w700),
                  ),
                ),

                // PRICE & TRACKING
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      NumberFormat.currency(
                        decimalDigits: 0,
                        symbol: "\$",
                        locale: "en_us"
                      ).format(transaction.totalPrice),
                      style: Theme.of(context).textTheme.headline6?.copyWith(color: kRedColor, fontSize: 16),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      height: 30,
                      width: 105,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: kBlackColor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Text(
                          "Track Order",
                          style: Theme.of(context).textTheme.headline6?.copyWith(color: kPrimaryColor, fontSize: 14),
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
