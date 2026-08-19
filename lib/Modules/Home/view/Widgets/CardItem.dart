import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/Modules/Articleclass.dart';
import 'package:news/core/settingProvider/settingProvider.dart';
import 'package:news/core/themes/AppColors.dart';
import 'package:provider/provider.dart';

class CardItem extends StatelessWidget {
  final Article article;

  const CardItem({super.key, required this.article});

  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final provider = Provider.of<SettingProvider>(context);

    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: provider.isdark() ? AppColors.white : AppColors.black,
        ),
      ),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: article.urlToImage,
            height: 220,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (context, url) => SizedBox(
              height: 220,
              width: double.infinity,
              child: Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (context, url, error) => SizedBox(
              height: 220,
              width: double.infinity,
              child: Center(child: Icon(Icons.error, size: 50)),
            ),
          ),

          Text(
            article.title,
            style: theme.titleLarge?.copyWith(
              fontSize: 16,
              color: provider.isdark() ? AppColors.white : AppColors.black,
              height: 1.2,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My ${article.author}",
                style: theme.titleSmall?.copyWith(color: AppColors.grey),
              ),

              // Text("My ${article.publishedAt}" , style: theme.titleSmall?.copyWith(color: AppColors.grey),)
            ],
          ),
        ],
      ),
    );
  }
}
