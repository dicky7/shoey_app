import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/presentation/pages/main/profile/edit_profile_page.dart';
import 'package:shoes_app/presentation/pages/main/profile/my_order_page.dart';
import 'package:shoes_app/presentation/pages/onBoarding/sign_in_page.dart';
import 'package:shoes_app/presentation/pages/onBoarding/sign_up_page.dart';
import 'package:shoes_app/presentation/providers/profile/profile_providers.dart';
import 'package:shoes_app/presentation/widget/item_profile.dart';
import 'package:shoes_app/utils/state_enum.dart';
import 'package:shoes_app/utils/style/styles.dart';

import '../../../../utils/state_enum.dart';
import '../../../../utils/state_enum.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = "profile-page";
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<ProfileProviders>(context, listen: false).getUserProfile()
    );
  }

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
    return Consumer<ProfileProviders>(
      builder: (context, value, child) {
        final state = value.stateGetUser;
        if (state == ResultState.Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if(state == ResultState.Success){
          return Container(
              decoration: BoxDecoration(
                  color: kPrimaryColor
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: value.userModel.profilePhotoUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.close),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value.userModel.name,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline5?.copyWith(color: kBlueDark),
                        ),
                        Text(
                          value.userModel.email,
                          style: Theme.of(context).textTheme.subtitle1?.copyWith(color: kGreyColor),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                    iconSize: 30,
                    icon: Icon(Icons.login, color: kRedColor),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, SignInPage.routeName);
                    },
                  )
                ],
              )
          );
        } else if(state == ResultState.Error){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }else{
          return Container();
        }
      },
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
