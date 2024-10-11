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

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imagePath': imagePath,
      'price': price,
      'description': description,
      'category': category.index,
      'availableAddons': availableAddons.map((addon) => addon.toMap()).toList(),
    };
  }

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      name: map['name'],
      imagePath: map['imagePath'],
      price: map['price'],
      description: map['description'],
      category: FoodCategory.values[map['category']],
      availableAddons: List<Addon>.from(
        map['availableAddons'].map((addon) => Addon.fromMap(addon)),
      ),
    );
  }
}

enum FoodCategory {
  burgers,
  drinks,
  fries,
  chickens,
}

class Addon {
  final String name;
  final double price;

  Addon({required this.name, required this.price});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
    };
  }

  factory Addon.fromMap(Map<String, dynamic> map) {
    return Addon(
      name: map['name'],
      price: map['price'],
    );
  }
}
