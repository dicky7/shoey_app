import 'package:flutter/material.dart';
import 'package:shoes_app/presentation/pages/onBoarding/sign_in_page.dart';
import 'package:shoes_app/utils/style/styles.dart';

import '../../widget/custom_button.dart';

class GetStartedPage extends StatelessWidget {
  static const routeName = "get-started";
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/image_started.png",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Shoey",
                  style: Theme.of(context).textTheme.headline5!.copyWith(color: kPrimaryColor, fontSize: 42),
                ),
                const SizedBox(height: 10),
                Text(
                  "The best sneakers & shoes e-commerce app of the century for your fashion needs!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption!.copyWith(color: kPrimaryColor, fontSize: 16),
                ),
                CustomButton(
                  title: "Get Started",
                  width: 280,
                  margin: const EdgeInsets.only(top: 50, bottom: 80),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, SignInPage.routeName);
                  },
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}
