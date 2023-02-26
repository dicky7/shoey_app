import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color kPrimaryColor = const Color(0xFFFFFFFF);
Color kBlackColor = const Color(0xff2C2929);
Color secondaryColorLight = const Color(0xffdcdcdc);
Color kGreyColor = const Color(0xff9698A9);
Color kGreenColor = const Color(0xff0EC3AE);
Color kRedColor = const Color(0xffCC021E);
Color kBackgroundColor = const Color(0xffF7F7F7);
Color kBackgroundColor2 = Color(0xffECEDEF);
Color kBlue = const Color(0xff291F71);
Color kBlueLight = const Color(0xff5E5A7C);
Color kBlueDark = const Color(0xff413A76);

Color kInactiveColor = const Color(0xffDBD7EC);
Color kTransparentColor = Colors.transparent;

Color kOrangeColor = const Color(0xffFFC60C);



final TextTheme myTextTheme = TextTheme(
  headline4: GoogleFonts.urbanist(fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.urbanist(fontSize: 24, fontWeight: FontWeight.w500),
  headline6: GoogleFonts.urbanist(fontSize: 19, fontWeight: FontWeight.w600, letterSpacing: 0.15),
  subtitle1: GoogleFonts.urbanist(fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.urbanist(fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.urbanist(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.urbanist(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.urbanist(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
);