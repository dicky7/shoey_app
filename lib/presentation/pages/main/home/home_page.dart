import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/data/models/category_model.dart';
import 'package:shoes_app/presentation/providers/home/home_providers.dart';
import 'package:shoes_app/presentation/widget/product_item.dart';
import 'package:shoes_app/utils/helper_utils.dart';
import 'package:shoes_app/utils/state_enum.dart';
import 'package:shoes_app/utils/style/styles.dart';

import '../../../../data/models/product_model.dart';

class HomePage extends StatefulWidget {
  static const routeName = "home-page";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask((){
      //when tha app running or open for the first time, it will fetch list category product with id 0;
      Provider.of<HomeProviders>(context, listen: false)
        ..getProductByCategory(0)
        ..getUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headerGreetings(context),
              _banner(context),
              _category(context),
              _productCategory()
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerGreetings(BuildContext context) {
    final hour = DateTime.now().hour;
    return Consumer<HomeProviders>(
      builder: (context, state, _) {
        if (state.stateUser == ResultState.Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if(state.stateUser == ResultState.Success){
          return Container(
            margin: const EdgeInsets.only(top: 20, left: 24, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (hour >= 0 && hour <= 12)
                            ? "Howdy, Good Morning ☀️"
                            : (hour >= 12 && hour <= 18)
                            ? "Aloha, Good Afternoon 🌤️"
                            : "Hey, Good Night 🌘",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(color: kGreyColor),
                      ),
                      Text(
                        state.userModel.name,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(color: kBlackColor, fontSize: 24),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 50),
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: state.userModel.profilePhotoUrl,
                      width: 54,
                      height: 54,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.close),
                    )
                )
              ],
            ),
          );
        } else if(state.stateUser == ResultState.Error) {
          return Center(
            child: Text(state.messageUser),
          );
        }else{
          return const Center(
            child: Text('Something Wrong, please try again later...',),
          );
        }
      },
    );
  }

  Widget _banner(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: BoxDecoration(
          color: kRedColor, borderRadius: BorderRadius.circular(25)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "25%",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(color: kPrimaryColor, fontSize: 32),
                ),
                const SizedBox(height: 10),
                Text(
                  "Today's Special!",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: kPrimaryColor, fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  "Get, discount for every \norder. only valid for today",
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(color: kPrimaryColor),
                )
              ],
            ),
          ),
          Image.asset(
            "assets/image_shoes_banner.png",
            height: 135,
            width: 135,
          )
        ],
      ),
    );
  }

  Widget _category(BuildContext context) {
    return Consumer<HomeProviders>(
      builder: (context, state, child) {
        if (state.stateCategory == ResultState.Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.stateCategory == ResultState.Success) {
          return Container(
            margin: const EdgeInsets.only(left: 24),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                state.catagoryTitle,
                style: Theme
                    .of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(color: kBlackColor),
              ),
              Container(
                height: 45,
                margin: const EdgeInsets.only(top: 12),
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.categoryList.length,
                  itemBuilder: (context, index) {
                    final category = state.categoryList[index];
                    return _chipCategory(context, category);
                  },
                ),
              ),
            ]),
          );
        } else if (state.stateUser == ResultState.Error) {
          return Center(
            child: Text(state.messageCatagory),
          );
        } else {
          return const Center(
            child: Text('Something Wrong, please try again later...',),
          );
        }
      }
    );
  }

  Widget _chipCategory(BuildContext context, CategoryModel category) {
    return GestureDetector(
      onTap: () {

        Provider.of<HomeProviders>(context, listen: false).setSelectedCategory(category.id);
        print("category ${category.isSelected}");
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15,
        ),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: category.isSelected ? kBlackColor : kGreyColor.withOpacity(0.1),
        ),
        child: Center(
          child: Text(
            category.name,
            style: Theme.of(context).textTheme.subtitle2?.copyWith(
                color: category.isSelected ? kPrimaryColor : kBlackColor),
          ),
        ),
      ),
    );
  }

  Widget _productCategory() {
    return Consumer<HomeProviders>(
      builder: (context, value, _) {
        final state = value.stateProductByCatagory;
        if (state == ResultState.Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state == ResultState.Success) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: GridView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: value.productListCategory.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 20,
              ),
              itemBuilder: (context, index) {
                final product = value.productListCategory[index];
                return Transform.translate(
                  offset: Offset(0.0, index.isOdd ? 35 : 0),
                  //this code to make ProductItem look stagered or not "sejajar"
                  child: ProductItem(
                    product: product,
                  ),
                );
              },
            ),
          );
        } else if (state == ResultState.Empty) {
          return Container(
            margin: const EdgeInsets.only(top: 100),
            child: Center(
              child: Text(value.messageProductByCatagory),
            ),
          );
        } else if (state == ResultState.Error) {
          return Center(
            child: Text(value.messageProductByCatagory),
          );
        } else {
          return const Center(
            child: Text('Something Wrong, please try again later...',),
          );
        }
      }
    );
  }
}
