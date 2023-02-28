import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoes_app/data/datasource/preferences/preferences_helper.dart';
import 'package:shoes_app/data/datasource/remote/auth_remote_data_source.dart';
import 'package:shoes_app/data/datasource/remote/product_remote_data_source.dart';
import 'package:shoes_app/data/datasource/remote/user_remote_data_source.dart';
import 'package:shoes_app/data/repository/auth_repository.dart';
import 'package:shoes_app/data/repository/product_repository.dart';
import 'package:shoes_app/data/repository/user_repository.dart';
import 'package:shoes_app/presentation/cubits/auth/auth_cubit.dart';
import 'package:shoes_app/presentation/cubits/home/home_cubit.dart';
import 'package:shoes_app/presentation/cubits/user/user_cubit.dart';
import 'package:shoes_app/presentation/pages/main/cart/cart_page.dart';
import 'package:shoes_app/presentation/pages/main/cart/checkout_page.dart';
import 'package:shoes_app/presentation/pages/main/cart/checkout_success_page.dart';
import 'package:shoes_app/presentation/pages/main/chat/chat_page.dart';
import 'package:shoes_app/presentation/pages/main/chat/detail_chat_page.dart';
import 'package:shoes_app/presentation/pages/main/favorite/favorite_page.dart';
import 'package:shoes_app/presentation/pages/main/home/detail_product_page.dart';
import 'package:shoes_app/presentation/pages/main/home/home_page.dart';
import 'package:shoes_app/presentation/pages/main/main_page.dart';
import 'package:shoes_app/presentation/pages/main/profile/edit_profile_page.dart';
import 'package:shoes_app/presentation/pages/main/profile/my_order_page.dart';
import 'package:shoes_app/presentation/pages/main/profile/profile_page.dart';
import 'package:shoes_app/presentation/pages/onBoarding/get_started_page.dart';
import 'package:shoes_app/presentation/pages/onBoarding/sign_in_page.dart';
import 'package:shoes_app/presentation/pages/onBoarding/sign_up_page.dart';
import 'package:shoes_app/presentation/pages/onBoarding/splash_page.dart';
import 'package:shoes_app/presentation/providers/preferences_provider.dart';
import 'package:shoes_app/utils/helpers/dio_helper.dart';
import 'package:shoes_app/utils/style/styles.dart';
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
    return MultiBlocProvider(
      providers: [
        ChangeNotifierProvider(
          //The lazy parameter of the BlocProvider constructor is a boolean value that indicates
          // whether the provider should create and initialize the Bloc instance lazily or eagerly.
        lazy: false,
          create: (context) => di.locator<PreferencesProvider>()
        ),
        BlocProvider(
          create: (context) => di.locator<AuthCubit>(),
        ),
        BlocProvider(
          create: (context) => di.locator<HomeCubit>()
        ),
        BlocProvider(
          create: (context) => di.locator<UserCubit>()
        ),
      ],


      child: MaterialApp(
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
            case CheckoutPage.routeName:
              return MaterialPageRoute(builder: (_) => const CheckoutPage());
            case CheckoutSuccessPage.routeName:
              return MaterialPageRoute(builder: (_) => const CheckoutSuccessPage());
            case FavoritePage.routeName:
              return MaterialPageRoute(builder: (_) => const FavoritePage());
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

