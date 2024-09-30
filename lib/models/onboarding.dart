import 'package:food_delivery_app/app_image_path.dart';

class Onboarding {
  String title;
  String description;
  String image;
  Onboarding({
    required this.title,
    required this.description,
    required this.image,
  });
}

List<Onboarding> onboardingList = [
  Onboarding(
      title: ' Diverse and fresh food',
      description:
          'With an extensive menu prepared by talented chefs, fresh quality food.',
      image: AppImagePath.kOnboardingFirst),
  Onboarding(
      title: 'Easy to change dish ingredients',
      description:
          'You are a foodie, you can add or subtract ingredients in the dish.',
      image: AppImagePath.kOnboardingSecond),
  Onboarding(
      title: 'Delivery Is given on time',
      description:
          'With an extensive menu prepared by talented chefs, fresh quality food.',
      image: AppImagePath.kOnboardingThird)
];
