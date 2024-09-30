import 'package:carousel_slider/carousel_slider.dart' as carousel_slider;
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:food_delivery_app/themes/app_colors.dart';
import 'package:image_stack/image_stack.dart';

class MyCarouselSlider extends StatefulWidget {
  const MyCarouselSlider({super.key});

  @override
  State<MyCarouselSlider> createState() => _MyCarouselSliderState();
}

class _MyCarouselSliderState extends State<MyCarouselSlider> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
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
                  const SizedBox(height: 20),
                  carousel_slider.CarouselSlider(
                    options: carousel_slider.CarouselOptions(
                        height: 150,
                        viewportFraction: 1,
                        autoPlay: true,
                        pauseAutoPlayOnTouch: true,
                        scrollPhysics: const BouncingScrollPhysics(),
                        enableInfiniteScroll: false,
                        autoPlayAnimationDuration: const Duration(seconds: 1)),
                    items: [1, 2, 3, 4, 5].map((i) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.kPrimary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const TaskCard(),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  const TaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Mobile App Design",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),
          const Text(
            "Mike and Anita",
            style: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w100),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ImageStack(
                imageList: const [
                  "https://plus.unsplash.com/premium_photo-1683121366070-5ceb7e007a97?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                  "https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=1780&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                ],
                imageSource: ImageSource.Network,
                totalCount: 2,
                imageRadius: 35,
                imageCount: 3,
                imageBorderWidth: 0,
              ),
              const Text("Now",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w300))
            ],
          )
        ],
      ),
    );
  }
}

class CustomAnimatedText extends StatefulWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color fontColor;
  final int seconds;
  const CustomAnimatedText(
      {super.key,
      required this.seconds,
      required this.text,
      required this.fontSize,
      required this.fontWeight,
      required this.fontColor});

  @override
  State<CustomAnimatedText> createState() => _CustomAnimatedTextState();
}

class _CustomAnimatedTextState extends State<CustomAnimatedText> {
  double opacity = 1.0;

  @override
  void initState() {
    super.initState();
    changeOpacity();
  }

  changeOpacity() {
    Future.delayed(Duration(seconds: widget.seconds), () {
      setState(() {
        opacity = opacity == 0.0 ? 1.0 : 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        opacity: opacity == 1 ? 0 : 1,
        duration: const Duration(seconds: 1),
        child: Text(
          widget.text,
          style: TextStyle(
              color: widget.fontColor,
              fontSize: widget.fontSize,
              fontWeight: widget.fontWeight),
        ));
  }
}
