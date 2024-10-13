import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/my_carousel_slider.dart';
import 'package:food_delivery_app/components/my_food_tile.dart';
import 'package:food_delivery_app/components/my_sliverbar.dart';
import 'package:food_delivery_app/components/my_tabbar.dart';
import 'package:food_delivery_app/models/food.dart';
import 'package:food_delivery_app/models/restaurant.dart';
import 'package:food_delivery_app/screens/food_screen.dart';
import 'package:food_delivery_app/themes/app_colors.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  var txtStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  void initState() {
    super.initState();
    _tabController =
        TabController(length: FoodCategory.values.length, vsync: this);
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

// sort out and return a list of food items based on the category
  List<Food> filterFoodByCategory(FoodCategory category, List<Food> fullMenu) {
    return fullMenu.where((food) => food.category == category).toList();
  }

// return list of food items based on the category
  List<Widget> getFoodByCategory(List<Food> fullMenu) {
    return FoodCategory.values.map((category) {
      // get category menu
      List<Food> filteredFood = filterFoodByCategory(category, fullMenu);

      return ListView.builder(
        itemCount: filteredFood.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          // get individual food item
          final food = filteredFood[index];

          // return food UI
          return MyFoodTile(
            food: food,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodScreen(food: food),
                ),
              );
            },
          );
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moodeng Bite', style: txtStyle),
        backgroundColor: AppColors.kBackground,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.kBackground,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySliverbar(
            title: MyTabbar(tabController: _tabController),
            child: const MyCarouselSlider(),
          ),
        ],
        body: Consumer<Restaurant>(
          builder: (context, restaurant, child) => TabBarView(
            controller: _tabController,
            children: getFoodByCategory(restaurant.menu),
          ),
        ),
      ),
    );
  }
}
