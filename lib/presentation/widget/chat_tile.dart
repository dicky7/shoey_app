import 'package:flutter/material.dart';
import 'package:shoes_app/presentation/pages/main/chat/detail_chat_page.dart';
import 'package:shoes_app/utils/style/styles.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailChatPage.routeName);
      },
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset("assets/icon_logo.png"),
            ),
            title: Text(
                "Shoe Store",
                style: Theme.of(context).textTheme.subtitle1?.copyWith(color: kBlackColor)),
            subtitle: Text(
              "Good night, This item is on...",
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle2?.copyWith(color: kGreyColor),
            ),
            trailing: Text(
              "Now",
              style: Theme.of(context).textTheme.caption?.copyWith(color: kGreyColor),
            ),
          )),
    );
  }
}
