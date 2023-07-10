import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_theme.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      centerTitle: false,
      title: Text(
        title,
        style: appPrimaryTheme().textTheme.headline2,
      ),
    );
  }
}
