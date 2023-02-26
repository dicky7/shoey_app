import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/style/styles.dart';


class CustomButton extends StatelessWidget {
  final String title;
  final double width;
  final EdgeInsets margin;
  final Color? color;
  final Function() onPressed;

  const CustomButton({
    Key? key,
    required this.title,
    this.width = double.infinity,
    this.margin = EdgeInsets.zero,
    required this.onPressed, this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: 45,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color ?? kBlackColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: Theme.of(context).textTheme.button?.copyWith(color: kPrimaryColor),
        ),
      ),
    );
  }
}
