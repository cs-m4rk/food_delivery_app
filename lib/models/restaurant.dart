import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/cart_item.dart';
import 'package:food_delivery_app/models/food.dart';
import 'package:food_delivery_app/services/auth/auth_service.dart';
import 'package:food_delivery_app/services/database/database.dart';

class Restaurant extends ChangeNotifier {
  final List<Food> _menu = [
    //burgers
    Food(
      imagePath: 'assets/foods/burgers/burger1.webp',
      category: FoodCategory.burgers,
      name: 'Triple Smoky BBQ Bacon Buford',
      price: 300,
      description:
          'New Smoky BBQ Bacon Buford features three 100% beef hand-seasoned'
          'patties topped with Swiss cheese, two slices of smoked bacon, lettuce,'
          'tomato, pickles, onions, sweet & smoky BBQ sauce, mayo and even more bits'
          'of real chopped up bacon. It’s the bigger, bolder and better way to do burgers.',
      availableAddons: [
        Addon(name: 'Extra Swiss Cheese', price: 20),
        Addon(name: 'Extra Bacon', price: 55),
      ],
    ),
    Food(
      imagePath: 'assets/foods/burgers/burger2.webp',
      category: FoodCategory.burgers,
      name: 'All American Cheeseburger',
      price: 120.0,
      description:
          'A  burger the way it\'s meant to be. Grab our juicy, seasoned patty, topped with'
          'cheese, pickles, ketchup and mustard, all on a sesame seed bun.',
      availableAddons: [
        Addon(name: 'Extra Cheese', price: 10.0),
        Addon(name: 'Extra Patty', price: 60.0),
      ],
    ),
    Food(
      imagePath: 'assets/foods/burgers/burger3.webp',
      category: FoodCategory.burgers,
      name: 'Baconzilla',
      price: 200,
      description:
          'Take on these two large hand-seasoned, 100% beef hamburger patties piled high'
          'with four slices of crispy bacon, two slices of American cheese, melted cheddar'
          'cheese, ketchup and mayonnaise all served on a toasted bakery-style bun.',
      availableAddons: [
        Addon(name: 'Extra American Cheese', price: 25.0),
        Addon(name: 'Extra Crispy Bacon', price: 55.0),
      ],
    ),

    Food(
      imagePath: 'assets/foods/burgers/burger5.webp',
      category: FoodCategory.burgers,
      name: 'Triple Big Buford',
      price: 450.0,
      description:
          'The boss of all burgers is made for The Fast Foodie with three large hand-seasoned,'
          '100% beef hamburger patties, topped with three slices of melted American cheese, iceberg lettuce,'
          'tomato, red onion, dill pickles, ketchup, mustard, and mayonnaise all on a toasted bakery-style bun. Ask for extra napkins.',
      availableAddons: [
        Addon(name: 'Extra Beef Patties', price: 100.0),
        Addon(name: 'Extra American Cheese', price: 25.0),
      ],
    ),

    Food(
      imagePath: 'assets/foods/burgers/burger6.webp',
      category: FoodCategory.burgers,
      name: 'Bacon BBQ Mother Cruncher',
      price: 450.0,
      description:
          'Sweet layers of BBQ flavor! Checkers’ & Rally’s Bacon BBQ Mother Cruncher Chicken Sandwich'
          'features is made with our all white-meat crispy Mother Cruncher chicken filet that’s coated'
          'in super crunchy breading that’s topped with Sweet & Smoky BBQ sauce, two strips of freshly'
          'cooked bacon, dill pickles, mayo, crisp iceberg lettuce and crispy onion tanglers all served'
          'on a toasted, bakery-style bun.',
      availableAddons: [
        Addon(name: 'Extra Crispy Chicken', price: 50.0),
        Addon(name: 'Extra BBQ sauce', price: 20.0),
      ],
    ),

    // drinks
    Food(
      imagePath: 'assets/foods/drinks/drink1.webp',
      category: FoodCategory.drinks,
      name: 'Coca cola',
      price: 100,
      description: 'Regular',
      availableAddons: [
        Addon(name: 'Small', price: 70),
        Addon(name: 'Large', price: 120),
      ],
    ),

    Food(
      imagePath: 'assets/foods/drinks/drink2.webp',
      category: FoodCategory.drinks,
      name: 'Coke Zero Sugar',
      price: 120,
      description: 'Regular',
      availableAddons: [
        Addon(name: 'Small', price: 90),
        Addon(name: 'Large', price: 140),
      ],
    ),

    Food(
      imagePath: 'assets/foods/drinks/drink3.webp',
      category: FoodCategory.drinks,
      name: 'Diet Coke',
      price: 120.0,
      description: 'Regular',
      availableAddons: [
        Addon(name: 'Small', price: 90.0),
        Addon(name: 'Large', price: 140.0),
      ],
    ),

    Food(
      imagePath: 'assets/foods/drinks/drink4.webp',
      category: FoodCategory.drinks,
      name: 'Fanta',
      price: 90,
      description: 'Regular',
      availableAddons: [
        Addon(name: 'Small', price: 60),
        Addon(name: 'Extra meat', price: 120),
      ],
    ),

    Food(
      imagePath: 'assets/foods/drinks/drink5.webp',
      category: FoodCategory.drinks,
      name: 'Lemonade',
      price: 130,
      description: 'Regular',
      availableAddons: [
        Addon(name: 'Small', price: 100),
        Addon(name: 'Extra meat', price: 150),
      ],
    ),

    Food(
      imagePath: 'assets/foods/drinks/drink6.webp',
      category: FoodCategory.drinks,
      name: 'Sprite',
      price: 100,
      description: 'Regular',
      availableAddons: [
        Addon(name: 'Small', price: 80),
        Addon(name: 'Large', price: 120),
      ],
    ),

    // fries
    Food(
      imagePath: 'assets/foods/fries/fries1.webp',
      category: FoodCategory.fries,
      name: 'Famous Seasoned Fries',
      price: 120,
      description: 'Secretly seasoned. Famously good. And made just for.'
          '\n\nRegular',
      availableAddons: [
        Addon(name: 'Fry Lover\'s XL', price: 10.0),
        Addon(name: 'Large', price: 20.0),
        Addon(name: 'Medium', price: 20.0),
        Addon(name: 'Small', price: 20.0),
      ],
    ),
    Food(
      imagePath: 'assets/foods/fries/fries2.webp',
      category: FoodCategory.fries,
      name: 'Fry-Seasoned Monsterella Stix',
      price: 80,
      description:
          'These hunger-crushing, cheese-loaded mozzarella sticks are tossed with our'
          'Famous Seasoned Fries seasoning and served with a side of marinara sauce.',
      availableAddons: [
        Addon(name: '6 pc', price: 9),
        Addon(name: '10 pc', price: 12),
      ],
    ),
    Food(
      imagePath: 'assets/foods/fries/fries3.webp',
      category: FoodCategory.fries,
      name: 'Garlic Parmesan Loaded Fries',
      price: 501.0,
      description:
          'Enjoy our Famous Seasoned Fries topped with garlic parmesan sauce'
          'and smoky bacon crumbles, then smothered in melted cheddar cheese. Enjoy the'
          'finger-licking fragrant snacking!',
      availableAddons: [
        Addon(name: 'Garlic Parmesan Loaded Fries', price: 20.0),
        Addon(name: 'Large Garlic Parmesan Loaded Fries', price: 30.0),
      ],
    ),

    Food(
      imagePath: 'assets/foods/fries/fries5.jpg',
      category: FoodCategory.fries,
      name: 'Sweet Potato Fries with BBQ Sauce',
      price: 120,
      description:
          'This dish features crispy sweet potato fries, garnished with fresh cilantro.'
          'The fries are served on a rustic paper lining, paired with a side of rich, tangy BBQ sauce'
          'for dipping. The vibrant orange hue of the fries contrasts beautifully with the dark sauce,'
          'giving it an inviting presentation.',
      availableAddons: [
        Addon(name: 'Chipotle mayo for an extra kick', price: 25),
        Addon(name: 'Bacon bits for a savory crunch', price: 25),
      ],
    ),

    Food(
      imagePath: 'assets/foods/fries/fries6.jpg',
      category: FoodCategory.fries,
      name: 'Classic Fries with Salad and Dipping Sauce',
      price: 130,
      description:
          'Golden, lightly seasoned French fries take center stage on this plate, served alongside'
          'a small side salad of lettuce, tomatoes, and purple cabbage. A creamy dipping sauce, likely'
          'a blend of mayo and ketchup (or perhaps thousand island dressing), accompanies the fries'
          'offering a tangy complement to the crisp texture.',
      availableAddons: [
        Addon(name: 'Melted cheddar or parmesan cheese', price: 30),
        Addon(name: 'Gravy to create a poutine-like dish', price: 40),
      ],
    ),

    // chickens
    Food(
      imagePath: 'assets/foods/chickens/chicken1.webp',
      category: FoodCategory.chickens,
      name: '5 Piece Classic Wings',
      price: 170,
      description:
          'Indulge in a serving of 5 perfectly fried, tender wings, ready to be customized with'
          'your favorite flavors. Choose from a variety of mouth-watering sauces and dips to enhance your experience.'
          'Whether you prefer a spicy kick, a savory twist, or a creamy finish, we\'ve got you covered.',
      availableAddons: [
        Addon(name: 'Medium Buffalo', price: 30),
        Addon(name: 'Sweet & Smoky BBQ', price: 35),
        Addon(name: 'Garlic Parmesan', price: 20),
        Addon(name: 'Ranch Dipping Sauce', price: 25),
      ],
    ),
    Food(
      imagePath: 'assets/foods/chickens/chicken2.webp',
      category: FoodCategory.chickens,
      name: '10 Piece Classic Wings',
      price: 200,
      description:
          'Indulge in a serving of 10 perfectly fried, tender wings, ready to be customized with'
          'your favorite flavors. Choose from a variety of mouth-watering sauces and dips to enhance your experience.'
          'Whether you prefer a spicy kick, a savory twist, or a creamy finish, we\'ve got you covered.',
      availableAddons: [
        Addon(name: 'Medium Buffalo', price: 30),
        Addon(name: 'Sweet & Smoky BBQ', price: 35),
        Addon(name: 'Garlic Parmesan', price: 20),
        Addon(name: 'Ranch Dipping Sauce', price: 25),
      ],
    ),
    Food(
      imagePath: 'assets/foods/chickens/chicken3.webp',
      category: FoodCategory.chickens,
      name: 'Fry-Seasoned Chicken',
      price: 90,
      description:
          'Portable and loaded with flavor, Fry Seasoned Chicken Tenders. All white meat crispy'
          'chicken tenders coated in Checkers & Rally’s Famous Seasoned Fry batter for a signature'
          'zesty taste.',
      availableAddons: [
        Addon(name: '3PC Fry-Seasoned Tenders', price: 16.0),
        Addon(name: '5PC Fry-Seasoned Tenders', price: 26.0),
        Addon(name: '8PC Fry-Seasoned Tenders', price: 34.0),
      ],
    ),
    Food(
      imagePath: 'assets/foods/chickens/chicken4.webp',
      category: FoodCategory.chickens,
      name: 'Buffalo Fry-Seasoned Tenders',
      price: 501.0,
      description:
          'Introducing a kickin’ new way to enjoy Checkers’ & Rally’s Fry-Seasoned Chicken'
          'Tenders. The Buffalo version is all-white meat crispy chicken tenders coated in Checkers'
          '& Rally’s Famous Seasoned Fry batter and then tossed and sauced in our Medium Buffalo sauce',
      availableAddons: [
        Addon(name: '3PC Buffalo Fry-Seasoned Tenders', price: 16.0),
        Addon(name: '5PC Buffalo Fry-Seasoned Tenders', price: 26.0),
        Addon(name: '8PC Buffalo Fry-Seasoned Tenders', price: 34.0),
      ],
    ),
    Food(
      imagePath: 'assets/foods/chickens/chicken5.webp',
      category: FoodCategory.chickens,
      name: '20 Piece Classic Wings',
      price: 390,
      description:
          'Indulge in a serving of 20 perfectly fried, tender wings, ready to be customized with'
          'your favorite flavors. Choose from a variety of mouth-watering sauces and dips to enhance your experience.'
          'Whether you prefer a spicy kick, a savory twist, or a creamy finish, we\'ve got you covered.',
      availableAddons: [
        Addon(name: 'Medium Buffalo', price: 30),
        Addon(name: 'Sweet & Smoky BBQ', price: 35),
        Addon(name: 'Garlic Parmesan', price: 20),
        Addon(name: 'Ranch Dipping Sauce', price: 25),
      ],
    ),
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

  // Add to cart
  void addToCart(Food food, List<Addon> selectedAddons) async {
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

    final user = AuthService().getCurrentUser();

    try {
      await _database.saveCartDetails(user!.uid, _cart);
    } catch (e) {
      throw Exception('Failed to save cart details');
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
        final user = AuthService().getCurrentUser();
        _database.removeCartDetails(user!.uid, cartIndex);
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
    final user = AuthService().getCurrentUser();
    _database.removeAllCartDetails(user!.uid);
    _cart.clear();
    notifyListeners();
  }

  // place order

  //
}
