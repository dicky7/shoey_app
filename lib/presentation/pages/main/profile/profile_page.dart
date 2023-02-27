import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/presentation/pages/main/profile/edit_profile_page.dart';
import 'package:shoes_app/presentation/pages/main/profile/my_order_page.dart';
import 'package:shoes_app/presentation/pages/onBoarding/sign_in_page.dart';
import 'package:shoes_app/presentation/pages/onBoarding/sign_up_page.dart';
import 'package:shoes_app/presentation/providers/auth_providers.dart';
import 'package:shoes_app/presentation/providers/preferences_provider.dart';
import 'package:shoes_app/presentation/widget/item_profile.dart';
import 'package:shoes_app/utils/style/styles.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = "profile-page";
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAppBar(context),
            Divider(color: kGreyColor, thickness: 0.8),
            buildProfileItem(context)

          ],
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: kPrimaryColor
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "assets/image_profile.png",
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dicky WIdya Angga Kusuma",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline6?.copyWith(color: kBlueDark),
                  ),
                  Text(
                    "@Dicky WIdya",
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(color: kGreyColor),
                  )
                ],
              ),
            ),
            IconButton(
              iconSize: 30,
              icon: Icon(Icons.login, color: kRedColor),
              onPressed: () {
                Provider.of<PreferencesProvider>(context, listen: false).removeAccessToken();
                var accessToken = Provider.of<PreferencesProvider>(context, listen: false).isAccessToken;
                print("remove Access"+accessToken);
                Navigator.pushNamedAndRemoveUntil(context, SignInPage.routeName, (route) => false);
              },
            )
          ],
        )
    );
  }

  Widget buildProfileItem(BuildContext context){
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children:  [
        const SizedBox(height: 10),
        ItemProfile(
          icon: Icons.person_outlined,
          text: "Edit Profile",
          onTap: () {
            print("object");
            Navigator.pushNamed(context, EditProfilePage.routeName);
          },
        ),
        ItemProfile(
            icon: Icons.shopping_cart,
            text: "My Order",
            onTap: () {
              Navigator.pushNamed(context, MyOrderPage.routeName);
            },
        ),
        ItemProfile(icon: Icons.notifications, text: "Notifications"),
        ItemProfile(icon: Icons.security, text: "Security"),
        ItemProfile(icon: Icons.privacy_tip, text: "Privacy"),
        ItemProfile(icon: Icons.help_center_sharp, text: "Help Center"),
      ],
    );
  }

}
