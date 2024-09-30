import 'package:food_delivery_app/app_image_path.dart';

class Onboarding {
  String title1;
  String title2;
  String description;
  String image;
  Onboarding({
    required this.title1,
    required this.title2,
    required this.description,
    required this.image,
  });
}

List<Onboarding> onboardingList = [
  Onboarding(
      title1: 'Diverse ',
      title2: 'and fresh food',
      description:
          'With an extensive menu prepared by talented chefs, fresh quality food.',
      image: AppImagePath.kOnboardingFirst),
  Onboarding(
      title1: 'Easy to ',
      title2: 'change dish ingredients',
      description:
          'You are a foodie, you can add or subtract ingredients in the dish.',
      image: AppImagePath.kOnboardingSecond),
  Onboarding(
      title1: 'Delivery ',
      title2: 'Is given on time',
      description:
          'With an extensive menu prepared by talented chefs, fresh quality food.',
      image: AppImagePath.kOnboardingThird)
];
