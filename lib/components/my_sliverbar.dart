  import 'package:flutter/material.dart';
  import 'package:food_delivery_app/components/my_carousel_slider.dart';
  import 'package:food_delivery_app/themes/app_colors.dart';

  class MySliverbar extends StatelessWidget {
    const MySliverbar({super.key, this.child, this.title});

    final Widget? child;
    final Widget? title;

    @override
    Widget build(BuildContext context) {
      return SliverAppBar(
        centerTitle: true,
        expandedHeight: 340,
        collapsedHeight: 120,
        floating: false,
        pinned: true,
        backgroundColor: AppColors.kWhiteColor,
        flexibleSpace: FlexibleSpaceBar(
          background: Padding(
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
