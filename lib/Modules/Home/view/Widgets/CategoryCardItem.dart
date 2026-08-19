import 'package:flutter/material.dart';
import 'package:news/Modules/Home/CategoryModel.dart';
import 'package:news/core/settingProvider/settingProvider.dart';
import 'package:news/core/themes/AppColors.dart';
import 'package:provider/provider.dart';

class CategoryCardItem extends StatefulWidget {
  final CategoryModel category;

  final int index;

  const CategoryCardItem({
    super.key,
    required this.category,
    required this.index,
  });

  State<CategoryCardItem> createState() => _CategoryCardItemState();
}

class _CategoryCardItemState extends State<CategoryCardItem> {
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingProvider>(context);
    final theme = Theme.of(context).textTheme;
    return Container(
      height: 195,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: provider.isdark() ? AppColors.white : AppColors.black,
        image: DecorationImage(
          image: AssetImage(widget.category.imagepath),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Directionality(
          textDirection: widget.index % 2 == 0
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                widget.category.name,
                style: theme.titleMedium?.copyWith(
                  fontSize: 24,
                  color: provider.isdark() ? AppColors.black : AppColors.white,
                ),
              ),
              Container(
                width: 167,
                height: 54,
                decoration: BoxDecoration(
                  color: provider.isdark()
                      ? AppColors.black.withValues(alpha: 0.6)
                      : AppColors.white.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(84),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 27,
                      backgroundColor: provider.isdark()
                          ? AppColors.black
                          : AppColors.white,
                      child: Icon(
                        Icons.arrow_back_ios_outlined,
                        color: provider.isdark()
                            ? AppColors.white
                            : AppColors.black,
                        size: 30,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "View All",
                        style: theme.titleMedium?.copyWith(
                          fontSize: 24,
                          color: provider.isdark()
                              ? AppColors.white
                              : AppColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
