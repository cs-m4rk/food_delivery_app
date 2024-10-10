import 'package:flutter/material.dart';
import 'package:food_delivery_app/themes/app_colors.dart';

class MySliverbar extends StatelessWidget {
  const MySliverbar({super.key, this.child, this.title});

  final Widget? child;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      foregroundColor: AppColors.kBackground,
      centerTitle: true,
      expandedHeight: 300,
      collapsedHeight: 80,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.kBackground,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: AppColors.kBackground,
          padding: const EdgeInsets.only(bottom: 50.0),
          child: child,
        ),
        title: title,
        centerTitle: true,
        expandedTitleScale: 1,
        titlePadding: const EdgeInsets.only(left: 0, bottom: 0, top: 0),
      ),
    );
  }
}
