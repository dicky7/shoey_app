import 'package:flutter/material.dart';
import 'package:shoes_app/presentation/widget/chat_bubble.dart';
import 'package:shoes_app/utils/style/styles.dart';

class DetailChatPage extends StatelessWidget {
  static const routeName = "detail-chat";
  const DetailChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: _buildAppBar(context),
        bottomNavigationBar: _chatInput(context),
        body: _content(context),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
        toolbarHeight: 90,
        backgroundColor: kPrimaryColor,
        elevation: 3,
        leading: BackButton(
          color: kBlackColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "assets/icon_logo.png",
                height: 50,
                width: 50,
              ),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Shoey Store",
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(color: kBlackColor),
                ),
                Text(
                  "Online",
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(color: kGreyColor),
                )
              ],
            )
          ],
        ),
      );
  }

  Widget _chatInput(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _productPreview(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  height: 45,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: kGreyColor.withOpacity(0.2)
                  ),
                  child: TextFormField(
                    showCursor: true,
                    cursorColor: kBlackColor,
                    decoration: const InputDecoration.collapsed(
                        hintText: "Type Message...",
                    ),
                  ),
                )
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {

                },
                child: Container(
                  height: 45,
                  width: 45,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kGreenColor
                  ),
                  child: Icon(Icons.send, color: kPrimaryColor),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _productPreview(BuildContext context){
    return Container(
      width: 225,
      height: 74,
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: kBlackColor, width: 1),
        borderRadius: BorderRadius.circular(10),
        color: kBlue
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
                "assets/image_shoes2.png",
              width: 70,
              height: 70,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "COURT VISIO...",
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(color: kPrimaryColor),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  "57,15",
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(color: kGreenColor),
                ),
              ],
            ),
          ),
          Image.asset(
            "assets/button_close.png",
            width: 22,
          )
        ],
      ),
    );
  }

  Widget _content(BuildContext context){
    return ListView(
      children: [
        ChatBubble(text: "Hi, This item is still available?", isSender: true, hasProduct: true),
        ChatBubble(text: "Good night, This item is only available in size 42 and 43", isSender: false),

      ],
    );
  }
}
