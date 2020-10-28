import 'package:flutter/material.dart';

const PrimaryColor = Color.fromRGBO(255, 204, 0, 1);

const Headline5Size = 24.0;
const Headline6Size = 20.0;
const Body1Size = 16.0;
const Body2Size = 14.0;
const CaptionSize = 12.0;
const OverlineSize = 10.0;

const String FontNameDefault = 'Roboto';

const _borderInput = OutlineInputBorder(
    borderRadius: BorderRadius.zero,
    borderSide: BorderSide(
        color: Color.fromRGBO(1, 244, 244, 244),
        width: 1,
        style: BorderStyle.solid));

ThemeData appTheme() => ThemeData(
      brightness: Brightness.light,
      primaryColor: PrimaryColor,
      accentColor: Colors.yellowAccent[400],
      hintColor: PrimaryColor,
      dividerColor: Colors.black.withOpacity(0.54),
      buttonColor: PrimaryColor,
      appBarTheme: appBarTheme(),
      textTheme: TextTheme(
          headline6: headline6Style(),
          subtitle1: headline6Style(),
          bodyText1: body1Style(),
          button: primaryButtonTextStyle(),
          caption: captionStyle(),
          overline: overlineStyle(),
          // sebas xd
          subtitle2: loginNormalStyle(),
          bodyText2: loginSecondaryStyle(),
          headline3: frontText(),
          headline5: productText(),
          headline4: productPrice()),
      inputDecorationTheme: InputDecorationTheme(
          border: _borderInput,
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(
            fontFamily: FontNameDefault,
            fontWeight: FontWeight.normal,
            fontSize: 14.0,
            color: Color.fromRGBO(0, 0, 0, 5.4),
            letterSpacing: 0.4,
          )),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          backgroundColor: MaterialStateProperty.all<Color>(PrimaryColor),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(vertical: 8)),
          textStyle: MaterialStateProperty.all<TextStyle>(
            TextStyle(
              fontFamily: FontNameDefault,
              fontWeight: FontWeight.normal,
              fontSize: 14,
              letterSpacing: 0.4,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );

AppBarTheme appBarTheme() => AppBarTheme(
    color: Colors.white,
    elevation: 0,
    textTheme: TextTheme(
      headline6: headline6Style(),
    ),
    iconTheme: IconThemeData(color: Color.fromRGBO(0, 0, 0, 0.54)));

TextStyle headline6Style() => TextStyle(
      fontFamily: FontNameDefault,
      fontWeight: FontWeight.w500,
      fontSize: Headline6Size,
      color: Colors.black,
      letterSpacing: 0.15,
    );

TextStyle body1Style() => TextStyle(
      fontFamily: FontNameDefault,
      fontWeight: FontWeight.normal,
      fontSize: Body1Size,
      color: Colors.black,
      letterSpacing: 0.5,
    );

TextStyle primaryButtonTextStyle() => TextStyle(
      fontFamily: FontNameDefault,
      fontWeight: FontWeight.normal,
      fontSize: Body1Size,
      color: Colors.black,
      letterSpacing: 1.25,
    );

TextStyle captionStyle() => TextStyle(
      fontFamily: FontNameDefault,
      fontWeight: FontWeight.normal,
      fontSize: CaptionSize,
      color: Colors.grey[600],
      letterSpacing: 0.4,
    );

TextStyle overlineStyle() => TextStyle(
      fontFamily: FontNameDefault,
      fontWeight: FontWeight.normal,
      fontSize: OverlineSize,
      color: Colors.black,
      letterSpacing: 1.5,
    );

// sebas xd

TextStyle loginNormalStyle() => TextStyle(
      fontFamily: FontNameDefault,
      fontWeight: FontWeight.w500,
      fontSize: Body2Size,
      color: Colors.white,
      letterSpacing: 0.15,
    );

TextStyle loginSecondaryStyle() => TextStyle(
      fontFamily: FontNameDefault,
      fontWeight: FontWeight.w500,
      fontSize: Body2Size,
      color: PrimaryColor,
      letterSpacing: 0.15,
    );

TextStyle frontText() => TextStyle(
    fontFamily: FontNameDefault,
    fontWeight: FontWeight.w400,
    fontSize: Headline6Size,
    color: Colors.white,
    letterSpacing: 0.15);

TextStyle productText() => TextStyle(
  fontFamily: FontNameDefault,
  fontWeight: FontWeight.w400,
  fontSize: CaptionSize,
  color: Colors.black,
  letterSpacing: 0.4
);

TextStyle productPrice() => TextStyle(
  fontFamily: FontNameDefault,
  fontWeight: FontWeight.w700,
  fontSize: Body2Size,
  color: Colors.black,
  letterSpacing: 0.15
);