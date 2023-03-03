import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/presentation/pages/onBoarding/get_started_page.dart';
import 'package:shoes_app/utils/style/styles.dart';

import '../../providers/preferences/preferences_provider.dart';
import '../main/main_page.dart';

class SplashPage extends StatefulWidget {
  static const routeName = "/splash";
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3),() {
      var accessToken = Provider.of<PreferencesProvider>(context, listen: false).isAccessToken;
      print("Access"+accessToken);
      if (accessToken.isNotEmpty) {
        Navigator.pushNamedAndRemoveUntil(context, MainPage.routeName, (route) => false);

      }else{
        Navigator.pushReplacementNamed(context, GetStartedPage.routeName);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icon_logo.png",
              height: 50,
              width: 50,
            ),
            const SizedBox(width: 10),
            Text(
              "Shoey",
              style: Theme.of(context).textTheme.headline5?.copyWith(color: kBlackColor),
            )
          ],
        ),
      ),
    );
  }
}
