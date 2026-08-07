import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'AppColors.dart';

class AppThemeManager
{
  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.white ,
    secondaryHeaderColor: AppColors.black ,
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.w700 ,
        fontFamily: "Inter" ,
        fontSize: 24 ,
        color: AppColors.black ,

      ) ,
        titleMedium: TextStyle(
          fontWeight: FontWeight.w500 ,
          fontFamily: "Inter" ,
          fontSize: 20 ,
          color: AppColors.black ,

        )
    )
  ) ;



  static ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
      scaffoldBackgroundColor: AppColors.black,
      primaryColor: AppColors.black ,
      secondaryHeaderColor: AppColors.white ,
      textTheme: TextTheme(
          titleLarge: TextStyle(
            fontWeight: FontWeight.w700 ,
            fontFamily: "Inter" ,
            fontSize: 24 ,
            color: AppColors.white ,

          ) ,
          titleMedium: TextStyle(
            fontWeight: FontWeight.w500 ,
            fontFamily: "Inter" ,
            fontSize: 20 ,
            color: AppColors.white ,

          )
      )



  ) ;





}