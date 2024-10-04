import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/cart_item.dart';
import 'package:food_delivery_app/models/food.dart';
import 'package:food_delivery_app/services/database/database.dart';
import 'package:uuid/uuid.dart';

class Restaurant extends ChangeNotifier {
  final List<Food> _menu = [
    //burgers
    Food(
      imagePath: 'assets/foods/burgers/burger1.jpg',
      category: FoodCategory.burgers,
      name: 'Classic Burger',
      price: 90.0,
      description: 'Lami syang bayhana',
      availableAddons: [
        Addon(name: 'Extra Cheese', price: 10.0),
        Addon(name: 'Extra Patty', price: 20.0),
      ],
    ),
    Food(
      imagePath: 'assets/foods/burgers/burger2.jpg',
      category: FoodCategory.burgers,
      name: 'Classic Burger',
      price: 190.0,
      description: 'Lami syang bayhana',
      availableAddons: [
        Addon(name: 'Extra Cheese', price: 10.0),
        Addon(name: 'Extra Patty', price: 20.0),
      ],
    ),
    Food(
      imagePath: 'assets/foods/burgers/burger3.jpg',
      category: FoodCategory.burgers,
      name: 'Classic Burger',
      price: 200.0,
      description: 'Lami syang bayhana',
      availableAddons: [
        Addon(name: 'Extra Cheese', price: 10.0),
        Addon(name: 'Extra Patty', price: 20.0),
      ],
    ),
    Food(
      imagePath: 'assets/foods/burgers/burger4.jpg',
      category: FoodCategory.burgers,
      name: 'Classic Burger',
      price: 100.0,
      description: 'Lami syang bayhana',
      availableAddons: [
        Addon(name: 'Extra Cheese', price: 10.0),
        Addon(name: 'Extra Patty', price: 20.0),
      ],
    ),

    //pizzas
    Food(
      imagePath: 'assets/foods/pizzas/pizza1.jpg',
      category: FoodCategory.pizza,
      name: 'Classic pizza',
      price: 450.0,
      description: 'way lami syang bayhana',
      availableAddons: [
        Addon(name: 'Extra fuck', price: 10.0),
        Addon(name: 'Extra bitch', price: 20.0),
      ],
    ),
    Food(
      imagePath: 'assets/foods/pizzas/pizza2.jpg',
      category: FoodCategory.pizza,
      name: 'wtf pizza',
      price: 501.0,
      description: 'yati',
      availableAddons: [
        Addon(name: 'Extra Cheese', price: 10.0),
        Addon(name: 'Extra meat', price: 20.0),
      ],
    ),
    Food(
      imagePath: 'assets/foods/pizzas/pizza3.jpg',
      category: FoodCategory.pizza,
      name: 'wtf pizza',
      price: 501.0,
      description: 'yati',
      availableAddons: [
        Addon(name: 'Extra Cheese', price: 10.0),
        Addon(name: 'Extra meat', price: 20.0),
      ],
    ),
    Food(
      imagePath: 'assets/foods/pizzas/pizza4.jpg',
      category: FoodCategory.pizza,
      name: 'wtf pizza',
      price: 501.0,
      description: 'yati',
      availableAddons: [
        Addon(name: 'Extra Cheese', price: 10.0),
        Addon(name: 'Extra meat', price: 20.0),
      ],
    ),

    // fries
    /* Food(
      imagePath: 'assets/foods/fries/fries1.jpg',
      category: FoodCategory.fries,
      name: 'wtf fries',
      price: 501.0,
      description: 'yati',
      availableAddons: [
        Addon(name: 'Extra Cheese', price: 10.0),
        Addon(name: 'Extra meat', price: 20.0),
      ],
    ),
    Food(
      imagePath: 'assets/foods/fries/fries2.jpg',
      category: FoodCategory.fries,
      name: 'wtf fries',
      price: 501.0,
      description: 'yati',
      availableAddons: [
        Addon(name: 'Extra Cheese', price: 10.0),
        Addon(name: 'Extra meat', price: 20.0),
      ],
    ),
    Food(
      imagePath: 'assets/foods/fries/fries3.jpg',
      category: FoodCategory.fries,
      name: 'wtf fries',
      price: 501.0,
      description: 'yati',
      availableAddons: [
        Addon(name: 'Extra Cheese', price: 10.0),
        Addon(name: 'Extra meat', price: 20.0),
      ],
    ),
    Food(
      imagePath: 'assets/foods/fries/fries4.jpg',
      category: FoodCategory.fries,
      name: 'wtf fries',
      price: 501.0,
      description: 'yati',
      availableAddons: [
        Addon(name: 'Extra Cheese', price: 10.0),
        Addon(name: 'Extra meat', price: 20.0),
      ],
    ),
    Food(
      imagePath: 'assets/foods/fries/fries5.jpg',
      category: FoodCategory.fries,
      name: 'wtf fries',
      price: 501.0,
      description: 'yati',
      availableAddons: [
        Addon(name: 'Extra Cheese', price: 10.0),
        Addon(name: 'Extra meat', price: 20.0),
      ],
    ),
 
  // drinks
   Food(
      imagePath: 'assets/foods/drinks/fanta.jpg',
      category: FoodCategory.drinks,
      name: 'wtf drinks',
      price: 501.0,
      description: 'yati',
      availableAddons: [
        Addon(name: 'Extra Cheese', price: 10.0),
        Addon(name: 'Extra meat', price: 20.0),
      ],
    ),
     Food(
      imagePath: 'assets/foods/drinks/cocacola.jpeg',
      category: FoodCategory.drinks,
      name: 'wtf drinks',
      price: 501.0,
      description: 'yati',
      availableAddons: [
        Addon(name: 'Extra Cheese', price: 10.0),
        Addon(name: 'Extra meat', price: 20.0),
      ],
    ),
     Food(
      imagePath: 'assets/foods/drinks/sprite.jpg',
      category: FoodCategory.drinks,
      name: 'wtf drinks',
      price: 501.0,
      description: 'yati',
      availableAddons: [
        Addon(name: 'Extra Cheese', price: 10.0),
        Addon(name: 'Extra meat', price: 20.0),
      ],
    ),
     Food(
      imagePath: 'assets/foods/drinks/pepsi.jpg',
      category: FoodCategory.drinks,
      name: 'wtf drinks',
      price: 501.0,
      description: 'yati',
      availableAddons: [
        Addon(name: 'Extra Cheese', price: 10.0),
        Addon(name: 'Extra meat', price: 20.0),
      ],
    ),
 

  // desserts
    Food(
      imagePath: 'assets/foods/desserts/dessert1.jpg',
      category: FoodCategory.desserts,
      name: 'wtf desserts',
      price: 501.0,
      description: 'yati',
      availableAddons: [
        Addon(name: 'Extra Cheese', price: 10.0),
        Addon(name: 'Extra meat', price: 20.0),
      ],
    ),
    Food(
      imagePath: 'assets/foods/desserts/dessert2.jpg',
      category: FoodCategory.desserts,
      name: 'wtf desserts',
      price: 501.0,
      description: 'yati',
      availableAddons: [
        Addon(name: 'Extra Cheese', price: 10.0),
        Addon(name: 'Extra meat', price: 20.0),
      ],
    ),
    Food(
      imagePath: 'assets/foods/desserts/dessert3.jpg',
      category: FoodCategory.desserts,
      name: 'wtf desserts',
      price: 501.0,
      description: 'yati',
      availableAddons: [
        Addon(name: 'Extra Cheese', price: 10.0),
        Addon(name: 'Extra meat', price: 20.0),
      ],
    ),

    */
  ];

  /**
   * G E T T E R S
   */

  List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;

  /**
   * O P E R A T I O N S
   * 
   */
  // user cart
  final List<CartItem> _cart = [];
  final Database _database = Database();
  final Uuid _uuid = Uuid();

  // Add to cart
  void addToCart(Food food, List<Addon> selectedAddons) {
    // see if there is a cart item already with the same food and selected addons
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      // check if the food items are the same
      bool isSameFood = item.food == food;

      // check if the list of selected addons are the same
      bool isSameAddons =
          ListEquality().equals(item.selectedAddons, selectedAddons);

      return isSameAddons && isSameFood;
    });

    // if item already exist, increase it's quantity
    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      // if item does not exist, add it to the new cart
      _cart.add(
        CartItem(food: food, selectedAddons: selectedAddons),
      );
    }
    notifyListeners();
  }

  // remove from cart
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }
    notifyListeners();
  }

  // get total price
  double getTotalPrice() {
    double total = 0.0;

    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;

      for (Addon addon in cartItem.selectedAddons) {
        itemTotal += addon.price;
      }

      total += itemTotal * cartItem.quantity;
    }
    return total;
  }

  // get total number of items in cart
  int getTotalItems() {
    int totalItemCount = 0;

    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }

    return totalItemCount;
  }

  // clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  // place order
  Future<void> placeOrder(String userId) async {
    String orderId = _uuid.v4();
    double totalPrice = getTotalPrice();
    await _database.saveOrderDetails(userId, orderId, _cart, totalPrice);
  }

  //
}
