import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/food.dart';
import 'package:food_delivery_app/themes/app_colors.dart';

class MyTabbar extends StatelessWidget {
  const MyTabbar({super.key, required this.tabController});

  final TabController tabController;

  List<Tab> _buildCategoryTabs() {
    return FoodCategory.values.map((category) {
      return Tab(
        text: category.toString().split('.').last,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: TabBar(
          controller: tabController,
          tabs: _buildCategoryTabs(),
        ),
      ),
    );
  }
}
