import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:news/core/gen/assets.gen.dart';
import 'package:news/core/l10n/app_localizations.dart';
import 'package:news/core/settingProvider/settingProvider.dart';
import 'package:news/core/themes/AppColors.dart';
import 'package:provider/provider.dart';

class CustomeDrawer extends StatefulWidget {
  void Function()? onhometab;

  CustomeDrawer({super.key, required this.onhometab});

  State<CustomeDrawer> createState() => _CustomeDrawerState();
}

class _CustomeDrawerState extends State<CustomeDrawer> {
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context).textTheme;
    final provider = Provider.of<SettingProvider>(context);
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(color: AppColors.white),
              child: Center(
                  child: Text(local!.newsApp, style: theme.titleLarge)),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(color: AppColors.black),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        widget.onhometab?.call();
                      },
                      child: Row(
                        spacing: 8,
                        children: [
                          Assets.icons.home1.svg(),
                          Text(
                            local.goToHome,
                            style: theme.titleLarge?.copyWith(
                              fontSize: 20,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Divider(color: AppColors.white, thickness: 1),
                    SizedBox(height: 24),
                    Row(
                      spacing: 8,
                      children: [
                        Assets.icons.rollerPaintBrush.svg(),
                        Text(
                          local.theme,
                          style: theme.titleLarge?.copyWith(
                            fontSize: 20,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8),
                    CustomDropdown<String>(
                      decoration: CustomDropdownDecoration(
                        closedFillColor: Colors.transparent,
                        closedBorder: Border.all(color: AppColors.white),
                        closedBorderRadius: BorderRadius.circular(16),
                        closedSuffixIcon: Icon(
                          Icons.arrow_drop_down_outlined,
                          size: 24,
                          color: AppColors.white,
                        ),
                        headerStyle: theme.titleMedium?.copyWith(
                          color: AppColors.white,
                        ),
                      ),

                      hintText: 'Select job role',
                      items: ["Light", "Dark"],
                      animation: const CustomDropdownAnimation(
                        type: DropdownAnimationType.scaleFade,
                        duration: Duration(milliseconds: 350),
                        curve: Curves.easeOutCubic,
                        staggerItems: true,
                      ),
                      onChanged: (value) {
                        if (value == "Light") {
                          provider.changeTheme(ThemeMode.light);
                        } else if (value == "Dark") {
                          provider.changeTheme(ThemeMode.dark);
                        }
                      },
                    ),
                    SizedBox(height: 24),
                    Divider(color: AppColors.white, thickness: 1),
                    SizedBox(height: 24),

                    Row(
                      spacing: 8,
                      children: [
                        Assets.icons.globeAlt.svg(),
                        Text(
                          local.language,
                          style: theme.titleLarge?.copyWith(
                            fontSize: 20,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8),
                    CustomDropdown<String>(
                      decoration: CustomDropdownDecoration(
                        closedFillColor: Colors.transparent,
                        closedBorder: Border.all(color: AppColors.white),
                        closedBorderRadius: BorderRadius.circular(16),
                        closedSuffixIcon: Icon(
                          Icons.arrow_drop_down_outlined,
                          size: 24,
                          color: AppColors.white,
                        ),
                        headerStyle: theme.titleMedium?.copyWith(
                          color: AppColors.white,
                        ),
                      ),

                      hintText: 'Select job role',
                      items: ["Arabic", "English"],
                      animation: const CustomDropdownAnimation(
                        type: DropdownAnimationType.scaleFade,
                        duration: Duration(milliseconds: 350),
                        curve: Curves.easeOutCubic,
                        staggerItems: true,
                      ),
                      onChanged: (value) {
                        if (value == "Arabic") {
                          provider.changeLanguage(Locale("ar"));
                        }
                        else {
                          provider.changeLanguage(Locale("en"));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
