import 'package:flutter/material.dart';

const PrimaryColor = Color.fromARGB(255, 255, 204, 0);

const Headline5Size = 24.0;
const Headline6Size = 20.0;
const Body1Size = 16.0;
const Body2Size = 14.0;
const CaptionSize = 12.0;
const OverlineSize = 10.0;

const String FontNameDefault = 'Roboto';

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
      ),
    );

AppBarTheme appBarTheme() => AppBarTheme(
      color: Colors.transparent,
      textTheme: TextTheme(
        headline6: headline6Style(),
      ),
    );

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
      fontWeight: FontWeight.w500,
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
