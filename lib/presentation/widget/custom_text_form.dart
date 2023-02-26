import 'package:flutter/material.dart';

import '../../utils/style/styles.dart';

class CustomTextForm extends StatelessWidget {
  final String title;
  final String hintText;
  final bool obscureText;
  final String errorText;
  final Icon? prefixIcons;
  final TextEditingController textEditingController;

  const CustomTextForm(
      {Key? key,
      required this.hintText,
      this.obscureText = false,
      required this.errorText,
      required this.textEditingController, this.prefixIcons, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme
              .of(context)
              .textTheme
              .bodyText2,
        ),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: obscureText,
          controller: textEditingController,
          showCursor: true,
          cursorColor: kBlackColor,
          decoration: InputDecoration(
            hintText: hintText,
            isCollapsed: true,
            fillColor: kGreyColor.withOpacity(0.2),
            filled: true,
            focusColor: kBlackColor,
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(16)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: kBlackColor
                ),
                borderRadius: BorderRadius.circular(16)
            ),
            prefixIcon: prefixIcons
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return errorText;
            }
            return null;
          },
        ),
      ],
    );
  }


}
