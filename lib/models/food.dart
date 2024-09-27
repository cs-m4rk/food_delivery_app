class Food {
  final String name;
  final String imagePath;
  final double price;
  final String description;
  final FoodCategory category;
  List<Addon> availableAddons;

  Food({
    required this.imagePath,
    required this.category,
    required this.name,
    required this.price,
    required this.description,
    required this.availableAddons,
  });
}

enum FoodCategory {
  burgers,
  pizza,
  desserts,
  salads,
  drinks,
}

class Addon {
  final String name;
  final double price;

  Addon({required this.name, required this.price});
}
