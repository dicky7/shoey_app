import 'package:flutter/material.dart';
import 'package:shoes_app/data/datasource/preferences/preferences_helper.dart';
import 'package:shoes_app/data/datasource/remote/auth_remote_data_source.dart';
import 'package:shoes_app/data/models/table/cart_table.dart';
import 'package:shoes_app/data/repository/auth_repository.dart';
import 'package:shoes_app/presentation/pages/main/cart/cart_page.dart';
import 'package:shoes_app/presentation/pages/main/cart/checkout_page.dart';
import 'package:shoes_app/presentation/pages/main/cart/checkout_success_page.dart';
import 'package:shoes_app/presentation/pages/main/chat/detail_chat_page.dart';
import 'package:shoes_app/presentation/pages/main/chat/chat_page.dart';
import 'package:shoes_app/presentation/pages/main/home/detail_product_page.dart';
import 'package:shoes_app/presentation/pages/main/home/home_page.dart';
import 'package:shoes_app/presentation/pages/main/main_page.dart';
import 'package:shoes_app/presentation/pages/main/profile/edit_profile_page.dart';
import 'package:shoes_app/presentation/pages/main/profile/my_order_page.dart';
import 'package:shoes_app/presentation/pages/main/profile/profile_page.dart';
import 'package:shoes_app/presentation/pages/main/wishlist/wishlist_page.dart';
import 'package:shoes_app/presentation/pages/onBoarding/get_started_page.dart';
import 'package:shoes_app/presentation/pages/onBoarding/sign_in_page.dart';
import 'package:shoes_app/presentation/pages/onBoarding/sign_up_page.dart';
import 'package:shoes_app/presentation/pages/onBoarding/splash_page.dart';
import 'package:shoes_app/presentation/providers/auth/auth_providers.dart';
import 'package:shoes_app/presentation/providers/cart/cart_providers.dart';
import 'package:shoes_app/presentation/providers/cart/checkout_providers.dart';
import 'package:shoes_app/presentation/providers/home/detail_product_providers.dart';
import 'package:shoes_app/presentation/providers/home/home_providers.dart';
import 'package:shoes_app/presentation/providers/preferences/preferences_provider.dart';
import 'package:shoes_app/presentation/providers/profile/profile_providers.dart';
import 'package:shoes_app/presentation/providers/transaction/transaction_providers.dart';
import 'package:shoes_app/presentation/providers/wishlist/wishlist_providers.dart';
import 'package:shoes_app/utils/constant.dart';
import 'package:shoes_app/utils/helpers/dio_helper.dart';
import 'package:shoes_app/utils/style/styles.dart';
import 'package:provider/provider.dart';
import 'injection.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => di.locator<PreferencesProvider>()
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<AuthProviders>()
        ),
        ChangeNotifierProvider(
            create: (context) => di.locator<HomeProviders>()
        ),
        ChangeNotifierProvider(
            create: (context) => di.locator<DetailProductProviders>()
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<CartProviders>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<CheckoutProviders>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<WishlistProviders>(),
        ),
        ChangeNotifierProvider(
            create: (context) => di.locator<ProfileProviders>()
        ),
        ChangeNotifierProvider(
            create: (context) => di.locator<TransactionProviders>()
        ),

      ],
      child: MaterialApp(
        theme: ThemeData(
          textTheme: myTextTheme,
        ),
        debugShowCheckedModeBanner: false,
        navigatorObservers: <NavigatorObserver>[routeObserver],
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
              final id = settings.arguments as int;
              return MaterialPageRoute(builder: (_) => DetailProductPage(
                id: id,
              ));
            case ChatPage.routeName:
              return MaterialPageRoute(builder: (_) => const ChatPage());
            case DetailChatPage.routeName:
              return MaterialPageRoute(builder: (_) => const DetailChatPage());
            case CartPage.routeName:
              return MaterialPageRoute(builder: (_) => const CartPage());
            case CheckoutPage.routeName:
              final cartList = settings.arguments as List<CartTable>;
              return MaterialPageRoute(builder: (_) => CheckoutPage(
                cartList: cartList,
              ));
            case CheckoutSuccessPage.routeName:
              return MaterialPageRoute(builder: (_) => const CheckoutSuccessPage());
            case WishlistPage.routeName:
              return MaterialPageRoute(builder: (_) => const WishlistPage());
            case ProfilePage.routeName:
              return MaterialPageRoute(builder: (_) => const ProfilePage());
            case EditProfilePage.routeName:
              return MaterialPageRoute(builder: (_) => EditProfilePage());
            case MyOrderPage.routeName:
              return MaterialPageRoute(builder: (_) => const MyOrderPage());
            default:
              return MaterialPageRoute(builder: (_) => const SplashPage());
          }
        },
      ),
    );
  }
}

