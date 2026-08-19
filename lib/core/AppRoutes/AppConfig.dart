import 'package:flutter/material.dart';
import 'package:news/Modules/Home/view_model/HomeViewModel.dart';
import 'package:news/Modules/SplashScreen/SplashScreen.dart';
import 'package:provider/provider.dart';

import '../../Modules/Home/Home.dart';
import 'AppRouteName.dart';

class AppConfig
{
  static Route<dynamic>? onGenerateRoute(RouteSettings settings)
  {
  switch(settings.name)
      {
    case AppRouteName.initial:
      return MaterialPageRoute(builder: (context)=>splashScreen() ) ;

    case AppRouteName.Home:
      return MaterialPageRoute(builder: (context) =>
          ChangeNotifierProvider(
              create: (context) => HomeViewModel(),
              child: Home()));



      }
  return null;

  }
}