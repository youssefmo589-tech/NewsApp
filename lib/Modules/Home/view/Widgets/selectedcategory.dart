import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/Modules/Home/view/Widgets/CardItem.dart';
import 'package:news/Modules/Home/view/Widgets/TabBarItem.dart';
import 'package:news/Modules/Home/view_model/HomeViewModel.dart';
import 'package:news/core/settingProvider/settingProvider.dart';
import 'package:news/core/themes/AppColors.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class selectedCategory extends StatefulWidget {
  const selectedCategory({super.key});

  State<selectedCategory> createState() => _selectedCategoryState();
}

class _selectedCategoryState extends State<selectedCategory> {
  void initState() {
    super.initState();
    Future.wait([
      Provider.of<HomeViewModel>(context, listen: false).getallsources(),
    ]).then((value) {
      Provider.of<HomeViewModel>(context, listen: false).getallarticle();
    });
  }

  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final vm = Provider.of<HomeViewModel>(context);
    final provider = Provider.of<SettingProvider>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          vm.sources.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Column(
                  spacing: 16,
                  children: [
                    DefaultTabController(
                      length: vm.sources.length,
                      child: TabBar(
                        isScrollable: true,
                        dividerHeight: 0,
                        indicatorColor: provider.isdark()
                            ? AppColors.white
                            : Colors.black,
                        labelPadding: EdgeInsets.symmetric(horizontal: 16),
                        tabAlignment: TabAlignment.start,
                        onTap: (value) {
                          vm.changetabindex(value);
                        },
                        tabs: vm.sources
                            .map(
                              (item) => TabBarItem(
                                source: item,
                                isselected:
                                    vm.sources.indexOf(item) ==
                                        vm.getselectedindex()
                                    ? true
                                    : false,
                              ),
                            )
                            .toList(),
                      ),
                    ),

                    ListView.separated(
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 16);
                      },
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: vm.articles.length,
                      itemBuilder: (context, index) {
                        final article = vm.articles[index];
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
                                  padding: const EdgeInsets.all(16),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: provider.isdark()
                                          ? AppColors.white
                                          : AppColors.black,
                                      borderRadius:
                                          BorderRadiusGeometry.circular(16),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        spacing: 8,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: article.urlToImage,
                                            height: 220,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => SizedBox(
                                              height: 220,
                                              width: double.infinity,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
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
                                            article.description,
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
                                              if (article.url == null ||
                                                  article.url.isEmpty) {
                                                return;
                                              }
                                              final Uri uri = Uri.parse(
                                                article.url,
                                              );
                                              if (await canLaunchUrl(uri)) {
                                                await launchUrl(
                                                  uri,
                                                  mode: LaunchMode
                                                      .externalApplication,
                                                );
                                              }
                                            },
                                            child: Container(
                                              height: 56,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: provider.isdark()
                                                    ? AppColors.black
                                                    : AppColors.white,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "View Full Articel",
                                                  style: theme.titleLarge
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w700,
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

                          child: CardItem(article: article),
                        );
                      },
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
