import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/Modules/Articleclass.dart';
import 'package:news/Modules/Home/CategoryModel.dart';
import 'package:news/Modules/Home/view/Widgets/CardItem.dart';
import 'package:news/Modules/Home/view/Widgets/CategoryCardItem.dart';
import 'package:news/Modules/Home/view/Widgets/CustomDrawer.dart';
import 'package:news/Modules/Home/view/Widgets/selectedcategory.dart';
import 'package:news/Modules/Home/view_model/HomeViewModel.dart';
import 'package:news/core/l10n/app_localizations.dart';
import 'package:news/core/network/http_requests.dart';
import 'package:provider/provider.dart';

import '../../core/settingProvider/settingProvider.dart';
import '../../core/themes/AppColors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Article>searchcarticlesresult = [];

  CategoryModel ? category;


  Future<void> onsearch(String value) async
  {
    if (category != null) {
      final data = await HttpRequestService.searchArticles(value, category!.id);
      setState(() {
        searchcarticlesresult = data;
      });
    }
  }

  bool _issearch = false;
  Widget build(BuildContext context)
  {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context).textTheme ;
    final provider = Provider.of<SettingProvider>(context) ;
    final vm = Provider.of<HomeViewModel>(context);
    return Scaffold(
      appBar: _issearch ?
      AppBar(
        title: SizedBox(
          width: double.infinity,
          child: TextField(
            onChanged: (value) {
              onsearch(value);
            },
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 8, vertical: 8),
                hintText: local!.search,
                hintStyle: theme.titleMedium?.copyWith(
                    color: provider.isdark() ? AppColors.white : AppColors.grey,
                    fontSize: 20),
                prefixIcon: Icon(Icons.search,
                  color: provider.isdark() ? AppColors.white : AppColors.black,
                  size: 24,),
                suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _issearch = !_issearch;
                      });
                    },
                    child: Icon(Icons.close,
                      color: provider.isdark() ? AppColors.white : AppColors
                          .black, size: 24,)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                        color: provider.isdark() ? AppColors.white : AppColors
                            .black)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                        color: provider.isdark() ? AppColors.white : AppColors
                            .black)
                )
            ),
          ),
        ),
      )


          : AppBar(
        iconTheme: IconThemeData(
            color: provider.isdark() ? AppColors.white : AppColors.black
        ),
        backgroundColor: Colors.transparent ,
        title: Text(
          vm.selectedcategory() == null ? local!.home : vm.selectedcategory()!
              .name,
          style: theme.titleMedium,),
        centerTitle: true,

        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    _issearch = !_issearch;
                  });
                },
                child: Icon(Icons.search,
                  color: provider.isdark() ? AppColors.white : AppColors.black,
                  size: 24,)),
          )
        ],

      ),


      drawer: _issearch == false ? Drawer(
        child: CustomeDrawer(onhometab: () {
          vm.changeselectedcategory(null);
          Navigator.pop(context);
        },),

      ) : null,

      body: vm.selectedcategory() == null ? Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${local!.goodMorning}\n${local.hereisSomeNewsForYou}",
                style: theme.titleMedium?.copyWith(fontSize: 24, height: 1.4),),
              ListView.separated(
                  padding: EdgeInsets.only(bottom: 16),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          vm.changeselectedcategory(vm.getcategories()[index]);
                          setState(() {
                            category = vm.getcategories()[index];
                          });

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
      ) : _issearch ?
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      context: context,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: EdgeInsets.only(right: 16,
                              left: 16,
                              top: 16,
                              bottom: MediaQuery
                                  .of(context)
                                  .viewInsets
                                  .bottom + 16),
                          child: Container(
                            decoration: BoxDecoration(
                              color: provider.isdark()
                                  ? AppColors.white
                                  : AppColors.black,
                              borderRadius: BorderRadiusGeometry.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                spacing: 8,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: searchcarticlesresult[index]
                                        .urlToImage,
                                    height: 220,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        SizedBox(
                                          height: 220,
                                          width: double.infinity,
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                    errorWidget: (context, url, error) =>
                                        SizedBox(
                                          height: 220,
                                          width: double.infinity,
                                          child: Center(
                                            child: Icon(
                                              Icons.error,
                                              size: 50,
                                            ),
                                          ),
                                        ),
                                  ),
                                  Text(
                                    searchcarticlesresult[index].description,
                                    style: theme.titleMedium?.copyWith(
                                      fontSize: 14,
                                      height: 1.2,
                                      fontWeight: FontWeight.w500,
                                      color: provider.isdark()
                                          ? AppColors.black
                                          : AppColors.white,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      vm.openurl(searchcarticlesresult[index]);
                                    },
                                    child: Container(
                                      height: 56,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: provider.isdark()
                                            ? AppColors.black
                                            : AppColors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Center(
                                        child: Text(
                                          local!.viewFullArticle,
                                          style: theme.titleLarge?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            color: provider.isdark()
                                                ? AppColors.white
                                                : AppColors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: CardItem(article: searchcarticlesresult[index]));
            },

            separatorBuilder: (context, index) {
              return SizedBox(height: 16,);
            },

            itemCount: searchcarticlesresult.length
        ),
      )
          : selectedCategory(),

    ) ;


  }
}