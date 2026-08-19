import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/Modules/source_model.dart';
import 'package:news/core/settingProvider/settingProvider.dart';
import 'package:news/core/themes/AppColors.dart';
import 'package:provider/provider.dart';

class TabBarItem extends StatelessWidget {
  final bool isselected;

  final Source source;

  const TabBarItem({super.key, required this.source, required this.isselected});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingProvider>(context);

    return Text(
      source.name,
      style: TextStyle(
        fontSize: isselected ? 16 : 14,
        fontWeight: isselected ? FontWeight.w700 : FontWeight.w500,
        color: provider.isdark() ? AppColors.white : AppColors.black,
      ),
    );
  }
}
