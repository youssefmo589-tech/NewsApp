import 'package:flutter/material.dart';
import 'package:news/Modules/Home/Widgets/CustomDrawer.dart';
import 'package:provider/provider.dart';

import '../../core/settingProvider/settingProvider.dart';
import '../../core/themes/AppColors.dart';

class Home extends StatefulWidget
{
  const Home({super.key});
  State<Home> createState() => _HomeState() ;
}
class _HomeState extends State<Home>
{
  Widget build(BuildContext context)
  {
    final theme = Theme.of(context).textTheme ;
    final provider = Provider.of<SettingProvider>(context) ;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent ,
        title: Text("Home" , style: theme.titleMedium,) ,
        centerTitle: true,

        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.search , color: provider.isdark() ? AppColors.white : AppColors.black, size: 24,),
          )
        ],

      ),
      drawer: Drawer(
        child: CustomeDrawer(),

      ),

    ) ;


  }
}