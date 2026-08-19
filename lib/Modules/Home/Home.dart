import 'package:flutter/material.dart';
import 'package:news/Modules/Home/view/Widgets/CategoryCardItem.dart';
import 'package:news/Modules/Home/view/Widgets/CustomDrawer.dart';
import 'package:news/Modules/Home/view/Widgets/selectedcategory.dart';
import 'package:news/Modules/Home/view_model/HomeViewModel.dart';
import 'package:provider/provider.dart';

import '../../core/settingProvider/settingProvider.dart';
import '../../core/themes/AppColors.dart';

class Home extends StatelessWidget
{
  const Home({super.key});
  Widget build(BuildContext context)
  {
    final theme = Theme.of(context).textTheme ;
    final provider = Provider.of<SettingProvider>(context) ;
    final vm = Provider.of<HomeViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: provider.isdark() ? AppColors.white : AppColors.black
        ),
        backgroundColor: Colors.transparent ,
        title: Text(
          vm.selectedcategory() == null ? "Home" : vm.selectedcategory()!.name,
          style: theme.titleMedium,),
        centerTitle: true,

        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.search , color: provider.isdark() ? AppColors.white : AppColors.black, size: 24,),
          )
        ],

      ),
      drawer: Drawer(
        child: CustomeDrawer(onhometab: () {
          vm.changeselectedcategory(null);
          Navigator.pop(context);
        },),

      ),

      body: vm.selectedcategory() == null ? Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Good Morning\nHere is Some News For You",
                style: theme.titleMedium?.copyWith(fontSize: 24, height: 1.4),),
              ListView.separated(
                  padding: EdgeInsets.only(bottom: 16),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          vm.changeselectedcategory(vm.getcategories()[index]);
                        },
                        child: CategoryCardItem(
                            category: vm.getcategories()[index], index: index));
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 16,);
                  },
                  itemCount: vm
                      .getcategories()
                      .length)
            ],
          ),
        ),
      ) : selectedCategory(),

    ) ;


  }
}