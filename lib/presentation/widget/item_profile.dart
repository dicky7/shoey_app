import 'package:flutter/material.dart';
import 'package:shoes_app/utils/style/styles.dart';

class ItemProfile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function()? onTap;

  const ItemProfile(
      {Key? key,
        required this.icon,
        required this.text,
        this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: ListTile(
          leading: Icon(
            icon,
            color: kBlackColor,
            size: 30,
          ),
          title: Text(
            text,
            style: Theme.of(context).textTheme.headline6?.copyWith(color: kBlackColor, fontSize: 16),
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: kBlackColor),
        ),
      ),
    );
  }
}
