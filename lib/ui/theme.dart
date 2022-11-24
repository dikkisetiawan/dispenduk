import 'package:flutter/material.dart';

//main Color
Color kPrimaryColor = const Color(0xFF2CBE53); //0xff56DCC5
Color kSecondaryColor = const Color(0xFFFEBE04); //0xFF171A1F
Color kRedColor = const Color(0xffB8363E);
Color kBlueColor = const Color(0xff566CDC);
Color kGreenColor = const Color(0xff8BD97B);
Color kPinkColor = const Color(0xffEB819C);

//Secondary Color
Color kDangerColor = const Color(0xffF27D81);
Color kWarningColor = kRedColor;
Color kSuccessColor = const Color(0xffC3ED6E);
Color kInfoColor = const Color(0xff60B2F0);

//Gray Color Set
Color kBackgroundColor = kGreyColor; //0xFF000000
Color kGreyColor = const Color(0xFFf4f4f4);
Color kDarkGreyColor = const Color(0xFF9599a4);
Color kWhiteColor = const Color(0xFFFFFFFF);
Color kBlackColor = const Color(0xFF333333);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semibold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;

TextStyle greenTextStyle =
    TextStyle(color: kPrimaryColor, fontSize: 18, fontWeight: bold);

TextStyle whiteTextStyle =
    TextStyle(color: kWhiteColor, fontSize: 14, fontWeight: bold);

TextStyle greyTextStyle =
    TextStyle(color: kDarkGreyColor, fontSize: 18, fontWeight: regular);

TextStyle buttonTextStyle =
    TextStyle(color: kPrimaryColor, fontSize: 14, fontWeight: bold);

TextStyle blackTextStyle = TextStyle(
    color: kBlackColor, fontSize: 18, fontWeight: bold, letterSpacing: 3);

//Circular Value
const defaultCircular = 20.0;
const defaultTopLeftCircular = 100.0;
const defaultMargin = 25.0;

//shadow Value
BoxShadow kShadow = BoxShadow(
    blurRadius: 20.0,
    color: Colors.black.withOpacity(0.2),
    spreadRadius: 2.0,
    offset: Offset(5, 10));

BorderRadius kBorderRadius = BorderRadius.circular(defaultCircular);
