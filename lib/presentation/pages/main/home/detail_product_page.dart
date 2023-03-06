import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/presentation/pages/main/cart/cart_page.dart';
import 'package:shoes_app/presentation/pages/main/main_page.dart';
import 'package:shoes_app/presentation/providers/home/detail_product_providers.dart';
import 'package:shoes_app/utils/app_utils.dart';
import 'package:shoes_app/utils/constant.dart';
import 'package:shoes_app/utils/helper_utils.dart';
import 'package:shoes_app/utils/state_enum.dart';
import 'package:shoes_app/utils/style/styles.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../../data/models/product_model.dart';

class DetailProductPage extends StatefulWidget {
  static const routeName = "detail-product";

  final int id;
  const DetailProductPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  int currentIndexIndicator = 0; // this index for indicator for image
  int colorSelectedIndex = 0;
  int? valueDropdown;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<DetailProductProviders>(context,listen: false)
        ..getProductById(widget.id)
        ..productWishlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor2,
        body: Consumer<DetailProductProviders>(
          builder: (context, providers, child) {
            final state = providers.state;
            if (state == ResultState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }else if(state == ResultState.Success){
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeader(context, providers.product.galleries),
                    buildContent(context, providers.product, providers.isAddedToWishlist)
                  ],
                ),
              );
            }else if(state == ResultState.Error){
              return  Center(
                child: Text(providers.message),
              );
            }else{
              return Container();
            }
          },
        ),
        bottomNavigationBar: Consumer<DetailProductProviders>(
          builder: (context, providers, child) {
            final state = providers.state;
            if (state == ResultState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }else if(state == ResultState.Success){
              return buildButton(providers.product);
            }else if(state == ResultState.Error){
              return  Center(
                child: Text(providers.message),
              );
            }else{
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context, List<Gallery> images){
    int index = -1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //ICON BACK
        Container(
          margin: const EdgeInsets.only(
            top: 25,
            left: 15,
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: kBlackColor,
            ),
            onPressed: () => Navigator.pushReplacementNamed(context, MainPage.routeName),
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            initialPage: 0,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndexIndicator = index;
              });
            },
          ),
          items: images.map((image) => CachedNetworkImage(
            imageUrl: image.url,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            width: double.infinity,
            height: 310,
            fit: BoxFit.cover,
          )).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: images.map((e) {
            index++;
            return buildIndicator(index);
          }).toList()
        )
      ],
    );
  }

  Widget buildIndicator(int index){
    return Container(
      height: 8,
      width: currentIndexIndicator == index ? 16 : 8,  // check if currentIndex for image is equal to index indicator
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: currentIndexIndicator == index ? kBlueDark : kGreyColor
      ),
    );
  }

  Widget buildContent(BuildContext context, ProductModel product, bool isAddedWatchlist){
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20)
        ),
        color: kPrimaryColor
      ),
      child: Column(
          children: [
            buildNameProduct(context, product, isAddedWatchlist),
            const SizedBox(height: 10),
            Divider(color: kGreyColor.withOpacity(0.5), thickness: 1),
            const SizedBox(height: 15),
            buildProductDesc(context, product),
            const SizedBox(height: 35),
          ]
      ),
    );
  }

  Widget buildNameProduct(BuildContext context, ProductModel product, bool isAddedWatchlist) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //
        //NAME, PRICE AND FAVORITE ICON
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    NumberFormat.currency(
                      locale:"en_us",
                      symbol: "\$",
                      decimalDigits: 0,
                    ).format(product.price),
                    style: Theme.of(context).textTheme.headline5?.copyWith(color: kRedColor),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.headline6?.copyWith(color: kBlackColor),
                  )
                ],
              ),
            ),
            IconButton(
              iconSize: 35,
              icon:  isAddedWatchlist
              //initial value isAddedWatchlist is false, because we set if false in detailProviders
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border),
              onPressed: () async{
                //when condition is not equal with isAddedWatchlist and user press the button, product will add to wishlist
                if (isAddedWatchlist == false) {
                  await Provider.of<DetailProductProviders>(context, listen: false).addToWishlist(product);
                }else{
                  await Provider.of<DetailProductProviders>(context, listen: false).removeFromWishlist(product.id);
                }

                //get wishlistMessage when wishlist response is success
                final message = Provider.of<DetailProductProviders>(context, listen: false).wishlistMessage;
                if (message == wishlistAddSuccessMessage || message == wishlistRemoveSuccessMessage) {
                  showSuccessSnackbar(context, message);
                }else{
                  showErrorSnackbar(context, message);
                }
              },
            )
          ],
        ),
        const SizedBox(height: 13),
        //
        //SOLD AND REVIEW
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: kGreyColor.withOpacity(0.5)
              ),
              child: Text(
                "2,788 Sold",
                style: Theme.of(context).textTheme.caption?.copyWith(color: kBlackColor, fontSize: 11),
              ),
            ),
            const SizedBox(width: 20),
            Icon(Icons.star, color: kOrangeColor),
            const SizedBox(width: 5),
            Text(
              "4.6 (5.718 Reviews)",
              style: Theme.of(context).textTheme.caption?.copyWith(color: kBlackColor, fontSize: 11),
            )
          ],
        ),
      ],
    );
  }

  Widget buildProductDesc(BuildContext context, ProductModel product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: Theme.of(context).textTheme.headline6?.copyWith(color: kBlackColor),
        ),
        const SizedBox(height: 10),
        Text(
          product.description,
          style: Theme.of(context).textTheme.subtitle2?.copyWith(color: kGreyColor),
        ),
        const SizedBox(height: 15),
        //
        //COLOR & SIZE
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Color
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Color",
                  style: Theme.of(context).textTheme.headline6?.copyWith(color: kBlackColor),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  height: 38,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: colors.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            colorSelectedIndex = index;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 7.0),
                          child: CircleAvatar(
                            maxRadius: 18,
                            backgroundColor: colors[index],
                            child: Center(
                              child: colorSelectedIndex == index
                                  ? const Icon(Icons.check, color: Colors.white)
                                  : null,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            //SIZE
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Size",
                  style: Theme.of(context).textTheme.headline6?.copyWith(color: kBlackColor),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: kBlackColor),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: valueDropdown,
                      isExpanded: false,
                      hint: Text(
                        "Choose size",
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(color: kBlackColor),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 1,
                          child: Text("M 20"),
                        ),
                        DropdownMenuItem(
                          value: 2,
                          child: Text("L 16"),
                        ),
                        DropdownMenuItem(
                          value: 3,
                          child: Text("S 12"),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          valueDropdown = value ?? 0;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget buildButton(ProductModel product){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          color: kPrimaryColor,
          boxShadow: [ // so here your custom shadow goes:
            BoxShadow(
              color: kGreyColor.withOpacity(0.1), // the color of a shadow, you can adjust it
              spreadRadius: 1, //also play with this two values to achieve your ideal result
              blurRadius: 4,
              offset: Offset(0, -4), // changes position of shadow, negative value on y-axis makes it appering only on the top of a container
            ),
          ],
      ),
      child: Row(
        children: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: kBlackColor),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
            ),
            child: Icon(Icons.chat_outlined, color: kBlackColor.withOpacity(0.8), size: 25,),
            onPressed: () {

            },
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: kBlackColor,
              ),
              child: Text(
                "Add To Cart",
                style: Theme.of(context).textTheme.button?.copyWith(color: kPrimaryColor),
              ),
              onPressed: () async{
                await Provider.of<DetailProductProviders>(context,listen: false).addToCart(
                    product,
                    onSuccess: (message) => showCustomDialog(
                      context: context,
                      icons: Icons.check_circle_outline,
                      title: "Success",
                      content: "Addedd Shoes To Cart",
                      buttonTitle: "View My Cart",
                      onPressed: () => Navigator.pushNamed(context, CartPage.routeName),
                    ),
                    onFailure: (message) => showErrorSnackbar(context, message),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
