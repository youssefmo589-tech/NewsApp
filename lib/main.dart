import 'package:flutter/material.dart';
import 'package:news/core/AppRoutes/AppConfig.dart';
import 'package:news/core/l10n/app_localizations.dart';
import 'package:news/core/themes/AppThemeManager.dart';
import 'package:provider/provider.dart';

import 'core/AppRoutes/AppRouteName.dart';
import 'core/settingProvider/settingProvider.dart';

void main()
{
  runApp(ChangeNotifierProvider(
      create:(context)=>SettingProvider() ,
     child: MyApp()

  )

  ) ;

}
class MyApp extends StatelessWidget
{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context)
  {
    final provider = Provider.of<SettingProvider>(context) ;
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: provider.locale,
      debugShowCheckedModeBanner: false,
      initialRoute:AppRouteName.initial ,
      onGenerateRoute: AppConfig.onGenerateRoute,
      themeMode:provider.currenttheme ,
      theme: AppThemeManager.lightTheme,
      darkTheme: AppThemeManager.darkTheme ,




    );
  }

}