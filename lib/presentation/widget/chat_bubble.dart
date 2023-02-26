import 'package:flutter/material.dart';
import 'package:shoes_app/utils/style/styles.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSender;
  final bool hasProduct;
  const ChatBubble({Key? key, required this.text, required this.isSender, this.hasProduct = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 25),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          hasProduct ? _productPreview(context) : const SizedBox(),
          _buildChat(context),
        ],
      ),
    );
  }

  Widget _buildChat(BuildContext context) {
    return Row(
      mainAxisAlignment: isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.6      //using constraints for show the content maximum 60 from the screen phone
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isSender ? 12 : 0),
                    topRight: Radius.circular(isSender ? 0 : 12),
                    bottomLeft: const Radius.circular(12),
                    bottomRight: const Radius.circular(12)
                ),
                color: isSender ? kBlueLight : kBlueDark
            ),
            child: Text(
              text,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(color: kPrimaryColor),
            ),
          ),
        )
      ],
    );
  }

  Widget _productPreview(BuildContext context){
    return Container(
      width: 230,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: kBlue
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
                      "COURT VISIO ssss ssss",
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(color: kPrimaryColor),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "57,15",
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(color: kGreenColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: BorderSide(color: kGreyColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                child: Text(
                  "Add to Cart",
                  style: Theme.of(context).textTheme.button?.copyWith(color: kPrimaryColor),
                ),
                onPressed: () {

                },
              ),
              const SizedBox(width: 8),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: kGreenColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                child: Text(
                  "Buy Now",
                  style: Theme.of(context).textTheme.button?.copyWith(color: kPrimaryColor),
                ),
                onPressed: () {

                },
              )

            ],
          )
        ],
      ),
    );
  }
}
