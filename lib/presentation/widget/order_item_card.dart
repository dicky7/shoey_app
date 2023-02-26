import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoes_app/data/models/product_model.dart';
import 'package:shoes_app/utils/style/styles.dart';

class OrderItemCard extends StatelessWidget {
  const OrderItemCard({Key? key}) : super(key: key);

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
                // NAME PRODUCT AND ICON TRASH
                Text(
                  "Terrex Urban Lows ",
                  style: Theme.of(context).textTheme.headline6?.copyWith(color: kBlackColor, fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10),

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
                      "Qty = 3 items",
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
                    "In Delivery",
                    style: Theme.of(context).textTheme.caption?.copyWith(color: kBlackColor, fontWeight: FontWeight.w700),
                  ),
                ),

                // PRICE & TRACKING
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$100s5.0",
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
