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

  Locale locale = Locale("en");

  void changeLanguage(Locale newlocale) {
    locale = newlocale;
    notifyListeners();
  }
}