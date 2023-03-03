import 'package:flutter/material.dart';
import 'package:shoes_app/presentation/pages/main/cart/cart_page.dart';
import 'package:shoes_app/presentation/pages/main/chat/chat_page.dart';
import 'package:shoes_app/presentation/pages/main/home/home_page.dart';
import 'package:shoes_app/presentation/pages/main/profile/profile_page.dart';
import 'package:shoes_app/presentation/pages/main/wishlist/wishlist_page.dart';
import 'package:shoes_app/utils/style/styles.dart';

class MainPage extends StatefulWidget {
  static const routeName = "main-page";
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: cartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: customBottomNavigation(),
      body: bodyPage()
    );
  }

  Widget bodyPage(){
    switch(currentIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const ChatPage();
      case 3:
        return const WishlistPage();
      case 4:
        return const ProfilePage();
      default:
        return const HomePage();

    }
  }


  Widget customBottomNavigation(){
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
      child: BottomAppBar(
        padding: const EdgeInsets.only(top: 7),
        shape: const CircularNotchedRectangle(),
        notchMargin: 13,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          backgroundColor: kPrimaryColor,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
                color: currentIndex == 0 ? kBlackColor : kGreyColor
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.chat,
                  color: currentIndex == 1 ? kBlackColor : kGreyColor
              ),
              label: ""
            ),
            BottomNavigationBarItem(
                icon: Icon(null, color: kTransparentColor),
                label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  Icons.favorite,
                  color: currentIndex == 3 ? kBlackColor : kGreyColor
              ),
                label: ""
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  Icons.person,
                  color: currentIndex == 4 ? kBlackColor : kGreyColor
              ),
              label: ""
            )
          ],
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
        ),
      ),
    );
  }

  Widget cartButton(){
    return FloatingActionButton(
      backgroundColor: kPrimaryColor,
      child: Icon(
        Icons.shopping_cart_outlined,
        color: kGreyColor,
      ),
      onPressed: () {
        Navigator.pushNamed(context, CartPage.routeName);

      },
    );
  }
}
