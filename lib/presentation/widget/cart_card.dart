import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/data/models/product_model.dart';
import 'package:shoes_app/presentation/providers/cart/cart_providers.dart';
import 'package:shoes_app/utils/app_utils.dart';
import 'package:shoes_app/utils/style/styles.dart';

import '../../data/models/table/cart_table.dart';

class CartCard extends StatelessWidget {
  final CartTable cartProduct;
  const CartCard({Key? key, required this.cartProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      padding: const EdgeInsets.all(13),
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
              imageUrl: cartProduct.photo,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        cartProduct.name,
                        style: Theme.of(context).textTheme.headline6?.copyWith(color: kBlackColor, fontSize: 20),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                      icon: Icon(Icons.delete_outlined, color: kBlackColor),
                      iconSize: 30,
                      onPressed: () async{
                        await Provider.of<CartProviders>(context, listen: false).removeCartItem(cartProduct.id);

                        final message = Provider.of<CartProviders>(context, listen: false).removeMessage;
                        showSuccessSnackbar(context, message);
                      },
                    )
                  ],
                ),

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
                        symbol: "\$",
                        decimalDigits: 0
                      ).format(cartProduct.price),
                      style: Theme.of(context).textTheme.headline6?.copyWith(color: kRedColor, fontSize: 16),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      width: 115,
                      height: 30,
                      decoration: BoxDecoration(
                        color: kGreyColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(13)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          //decrease button
                          Center(
                            child: IconButton(
                              icon: Icon(Icons.remove, color: kBlackColor),
                              iconSize: 15,
                              onPressed:() async{
                                await Provider.of<CartProviders>(context, listen: false).decreaseCartItem(cartProduct);

                              },
                            ),
                          ),
                          Text(
                            cartProduct.quantity.toString(),
                            style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.bold),
                          ),

                          //increase button
                          Center(
                            child: IconButton(
                              icon: Icon(Icons.add, color: kBlackColor),
                              iconSize: 15,
                              onPressed: () async{
                                await Provider.of<CartProviders>(context, listen: false).increaseCartItem(cartProduct);

                              },
                            ),
                          )
                        ],
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
