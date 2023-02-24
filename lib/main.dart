import 'package:flutter/material.dart';
import 'package:shoes_app/presentation/pages/main/cart/cart_page.dart';
import 'package:shoes_app/presentation/pages/main/chat/detail_chat_page.dart';
import 'package:shoes_app/presentation/pages/main/chat/chat_page.dart';
import 'package:shoes_app/presentation/pages/main/favorite/favorite_page.dart';
import 'package:shoes_app/presentation/pages/main/home/detail_product_page.dart';
import 'package:shoes_app/presentation/pages/main/home/home_page.dart';
import 'package:shoes_app/presentation/pages/main/main_page.dart';
import 'package:shoes_app/presentation/pages/main/profile/edit_profile_page.dart';
import 'package:shoes_app/presentation/pages/main/profile/profile_page.dart';
import 'package:shoes_app/presentation/pages/onBoarding/get_started_page.dart';
import 'package:shoes_app/presentation/pages/onBoarding/sign_in_page.dart';
import 'package:shoes_app/presentation/pages/onBoarding/sign_up_page.dart';
import 'package:shoes_app/presentation/pages/onBoarding/splash_page.dart';
import 'package:shoes_app/utils/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: myTextTheme,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        switch(settings.name){
          case SplashPage.routeName:
            return MaterialPageRoute(builder: (_) => const SplashPage());
          case GetStartedPage.routeName:
            return MaterialPageRoute(builder: (_) => const GetStartedPage());
          case SignInPage.routeName:
            return MaterialPageRoute(builder: (_) => SignInPage());
          case SignUpPage.routeName:
            return MaterialPageRoute(builder: (_) => SignUpPage());
          case MainPage.routeName:
            return MaterialPageRoute(builder: (_) => const MainPage());
          case HomePage.routeName:
            return MaterialPageRoute(builder: (_) => const HomePage());
          case DetailProductPage.routeName:
            return MaterialPageRoute(builder: (_) => const DetailProductPage());
          case ChatPage.routeName:
            return MaterialPageRoute(builder: (_) => const ChatPage());
          case DetailChatPage.routeName:
            return MaterialPageRoute(builder: (_) => const DetailChatPage());
          case CartPage.routeName:
            return MaterialPageRoute(builder: (_) => const CartPage());
          case FavoritePage.routeName:
            return MaterialPageRoute(builder: (_) => const FavoritePage());
          case ProfilePage.routeName:
            return MaterialPageRoute(builder: (_) => const ProfilePage());
          case EditProfilePage.routeName:
            return MaterialPageRoute(builder: (_) => EditProfilePage());
          default:
            return MaterialPageRoute(builder: (_) => const SplashPage());
        }
      },
    );
  }
}

