import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/my_carousel_slider.dart';
import 'package:food_delivery_app/components/my_drawer.dart';
import 'package:food_delivery_app/components/my_sliverbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySliverbar(
            child: Expanded(
              child: MyCarouselSlider(),
            ),
          ),
        ],
        body: Container(color: Colors.red),
      ),
    );
  }
}
