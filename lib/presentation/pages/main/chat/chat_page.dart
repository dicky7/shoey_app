import 'package:flutter/material.dart';
import 'package:shoes_app/presentation/widget/chat_tile.dart';

import '../../../../utils/style/styles.dart';

class ChatPage extends StatelessWidget {
  static const routeName = "chat-page";
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: buildAppBar(context),
        body: _buildListChat()
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: kPrimaryColor,
        toolbarHeight: 87,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 3,
        title:  Text(
          "Shoey Support",
          style: Theme.of(context).textTheme.headline6?.copyWith(color: kGreyColor),
        ),

    );
  }

  Widget _buildListChat(){
    return ListView(
      children: [
        ChatTile(),
        ChatTile()
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context){
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.headset_mic_outlined,
            size: 80,
            color: kBlackColor,
          ),
          const SizedBox(height: 20),
          Text(
            "Opss no message yet?",
            style: Theme.of(context).textTheme.subtitle1?.copyWith(color: kBlackColor),
          ),
          const SizedBox(height: 12),
          Text(
            "You have never done a transaction",
            style: Theme.of(context).textTheme.subtitle2?.copyWith(color: kGreyColor),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 115, vertical: 20),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: kBlueDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
              child: Text(
                  "Explore Store",
                style: Theme.of(context).textTheme.subtitle1?.copyWith(color: kPrimaryColor),
              ),
              onPressed: () {
                
              }
            ),
          )
        ],
      ),
    );
  }
}
