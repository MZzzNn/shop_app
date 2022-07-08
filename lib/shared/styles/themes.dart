import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

ThemeData darkTheme = ThemeData(
    accentColor: kTextWhiteColor,
    //primarySwatch:  Color(0xff00ADB5),
    //   colorScheme: ColorScheme.dark(
    //     primary:  Color(0xff00ADB5),
    //
    //   ),
    cardColor: Color(0xff393E46),
    scaffoldBackgroundColor: Color(0xff222831),
    appBarTheme: AppBarTheme(
        titleSpacing: 20.0,
        titleTextStyle: TextStyle(
            color: kTextWhiteColor,
            fontSize: 24.0,
            fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: kTextWhiteColor),
        color: Color(0xff222831),
        elevation: 0.0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Color(0xff222831),
          statusBarIconBrightness: Brightness.light,
        )),
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: TextTheme(
      bodyText1: TextStyle(
          color: kTextWhiteColor, fontSize: 16, fontWeight: FontWeight.bold),
      bodyText2: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: kTextWhiteColor,
      ),
      headline5: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: kTextWhiteColor,
      ),
      subtitle2: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        color: kTextWhiteColor,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color(0xff222831),
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: kTextWhiteColor,
        selectedItemColor: Color(0xff00ADB5),
        elevation: 20.0));

ThemeData lightTheme = ThemeData(
    //   primarySwatch:defaultColor,
    //    colorScheme: ColorScheme.light(
    //        primary:  Colors.indigo
    //    ),
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white,
    appBarTheme: AppBarTheme(
        titleSpacing: 20.0,
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.black54),
        color: Colors.white,
        elevation: 0.0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        )),
    iconTheme: IconThemeData(color: Colors.grey[500]),
    textTheme: TextTheme(
      bodyText1: TextStyle(
          color: kTextBlackColor, fontSize: 16, fontWeight: FontWeight.bold),
      bodyText2: TextStyle(
          fontSize: 14.0, fontWeight: FontWeight.w400, color: kTextBlackColor),
      headline5: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: kTextBlackColor,
      ),
      subtitle2: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        color: kTextBlackColor,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.indigo,
        elevation: 20.0));
