import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/core/AppRoutes/AppRouteName.dart';
import 'package:provider/provider.dart';

import '../../core/gen/assets.gen.dart';
import '../../core/settingProvider/settingProvider.dart';
import '../../core/themes/AppColors.dart';

class splashScreen extends StatefulWidget
{
  const splashScreen({super.key});
  State<splashScreen> createState() => _splashScreenState() ;


}
class _splashScreenState extends State<splashScreen>
{

  void initState()
  {
    super.initState() ;
    Future.delayed(Duration(seconds: 6) , (){
      Navigator.pushNamedAndRemoveUntil(context, AppRouteName.Home, (route)=> false) ;
    }) ;
  }

  Widget build(BuildContext context)
  {
    final provider = Provider.of<SettingProvider>(context) ;
    return Scaffold(
      body:Center(child:provider.isdark() ? Assets.images.newsLogowhite.image() :  Assets.images.newsLogo1.image())  ,

    ) ;
  }

}