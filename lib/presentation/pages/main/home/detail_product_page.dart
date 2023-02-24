import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoes_app/utils/app_utils.dart';
import 'package:shoes_app/utils/helper_utils.dart';
import 'package:shoes_app/utils/styles.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DetailProductPage extends StatefulWidget {
  static const routeName = "detail-product";
  const DetailProductPage({Key? key}) : super(key: key);

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  int currentIndexIndicator = 0; // this index for indicator for image
  final product = productList[0];
  int colorSelectedIndex = 0;
  int? valueDropdown;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor2,
        bottomNavigationBar: buildButton(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeader(context),
              buildContent(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context){
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
            onPressed: () => Navigator.pop(context),
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
            imageUrl: image,
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

  Widget buildContent(BuildContext context){
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
            buildNameProduct(context),
            const SizedBox(height: 10),
            Divider(color: kGreyColor, thickness: 1),
            const SizedBox(height: 15),
            buildProductDesc(context),
            const SizedBox(height: 25),
          ]
      ),
    );
  }

  Widget buildNameProduct(BuildContext context) {
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
                    "\$ 50.0",
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
              icon: const Icon(Icons.favorite),
              onPressed: () {
                showSuccessSnackbar(context, "Success");


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

  Widget buildProductDesc(BuildContext context) {
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

  Widget buildButton(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          color: kPrimaryColor,
          boxShadow: [ // so here your custom shadow goes:
            BoxShadow(
              color: Colors.black.withAlpha(20), // the color of a shadow, you can adjust it
              spreadRadius: 3, //also play with this two values to achieve your ideal result
              blurRadius: 5,
              offset: Offset(0, -3), // changes position of shadow, negative value on y-axis makes it appering only on the top of a container
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
              onPressed: () {
                showSuccessDialog(context);

              },
            ),
          )
        ],
      ),
    );
  }
}
