import 'package:food_delivery_app/models/food.dart';

class CartItem {
  Food food;
  List<Addon> selectedAddons;
  int quantity;

  CartItem({
    required this.food,
    required this.selectedAddons,
    this.quantity = 1,
  });

  // Convert CartItem to a Map for saving to Firebase
  Map<String, dynamic> toMap() {
    return {
      'food': food.toMap(),
      'selectedAddons': selectedAddons.map((addon) => addon.toMap()).toList(),
      'quantity': quantity,
      'totalPrice':
          totalPrice, // This will calculate the total price dynamically
    };
  }

  // Create a CartItem from Firebase data (Map)
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      food: Food.fromMap(map['food']),
      selectedAddons: List<Addon>.from(
        map['selectedAddons'].map((addon) => Addon.fromMap(addon)),
      ),
      quantity: map['quantity'],
    );
  }

  // Calculate the total price based on selected addons and food quantity
  double get totalPrice {
    double addonsPrice =
        selectedAddons.fold(0, (sum, addon) => sum + addon.price);
    return (food.price + addonsPrice) * quantity;
  }
}
