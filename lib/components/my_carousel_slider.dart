import 'package:carousel_slider/carousel_slider.dart' as carousel_slider;
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class MyCarouselSlider extends StatefulWidget {
  const MyCarouselSlider({super.key});

  @override
  State<MyCarouselSlider> createState() => _MyCarouselSliderState();
}

class _MyCarouselSliderState extends State<MyCarouselSlider> {
  int selectedIndex = 0;

  final List<String> imagePaths = [
    'assets/foods/special/special1.jpg',
    'assets/foods/special/special4.jpg',
    'assets/foods/special/special3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20), // Remove or reduce top padding
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: AnimationLimiter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: MediaQuery.of(context).size.width / 2,
                child: FadeInAnimation(child: widget),
              ),
              children: [
                carousel_slider.CarouselSlider(
                  options: carousel_slider.CarouselOptions(
                    height: 160,
                    viewportFraction: 1,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    pauseAutoPlayOnTouch: true,
                    scrollPhysics: const BouncingScrollPhysics(),
                    enableInfiniteScroll: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                  items: imagePaths.map((imagePath) {
                    return TaskCard(imagePath: imagePath);
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String imagePath;

  const TaskCard({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0), // Remove padding to avoid overflow
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8), // Optional: add rounded corners
        child: SizedBox(
          height: 160, // Set the height of the carousel here
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover, // This ensures the image covers the whole area
          ),
        ),
      ),
    );
  }
}
