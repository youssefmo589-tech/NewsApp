import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingProvider extends ChangeNotifier
{
   ThemeMode currenttheme = ThemeMode.light ;

   void changeTheme(ThemeMode newTheme)
  {
    currenttheme = newTheme ;
    notifyListeners() ;
  }

  bool isdark() => currenttheme == ThemeMode.dark ;

}