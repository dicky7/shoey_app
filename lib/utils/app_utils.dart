import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoes_app/utils/style/styles.dart';

void showErrorSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: kRedColor,
    duration: const Duration(seconds: 2),
    content: Text(
      message,
      textAlign: TextAlign.center,
    ),
  ));
}

void showSuccessSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: kGreenColor,
    duration: const Duration(seconds: 2),
    content: Text(
      message,
      textAlign: TextAlign.center,
    ),
  ));
}

/*
using Future<void> because showDialog return future too
 */
Future<void> showCustomDialog(
    {required BuildContext context,
    required IconData icons,
    required String title,
    required String content,
    required String buttonTitle,
    required Function() onPressed})async{
  return showDialog(
    context: context,
    builder: (context) {
      return Container(
        width: double.infinity,    // width will take phone with but giving litle space with (2 * 30)
        child: AlertDialog(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icons,
                color: kBlackColor,
                size: 100,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.headline6?.copyWith(color: kBlackColor),
              ),
              const SizedBox(height: 12),
              Text(
                content,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(color: kGreyColor),
              ),
              const SizedBox(height: 20),
              Container(
                width: 155,
                height: 45,
                decoration: BoxDecoration(
                    color: kBlackColor,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextButton(
                  onPressed: onPressed,
                  child: Text(
                    buttonTitle,
                    style: Theme.of(context).textTheme.button?.copyWith(color: kPrimaryColor),
                  )
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

Future<void> showCustomDialogError({
  required BuildContext context,
  required IconData icons,
  required String title,
  required String content})async{
  return showDialog(
    context: context,
    builder: (context) {
      return SizedBox(
        width: double.infinity,    // width will take phone with but giving litle space with (2 * 30)
        child: AlertDialog(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icons,
                color: kBlackColor,
                size: 100,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.headline6?.copyWith(color: kBlackColor),
              ),
              const SizedBox(height: 12),
              Text(
                content,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(color: kGreyColor),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    },
  );
}