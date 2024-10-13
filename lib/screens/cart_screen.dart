import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/export_components/login_components.dart';
import 'package:food_delivery_app/components/my_cart_tile.dart';
import 'package:food_delivery_app/models/restaurant.dart';
import 'package:food_delivery_app/screens/payment_screen.dart';
import 'package:food_delivery_app/themes/app_colors.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<bool> _checkedItems = [];

  var txtStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        final userCart = restaurant.cart;

        // Initialize _checkedItems list
        if (_checkedItems.length != userCart.length) {
          _checkedItems = List<bool>.filled(userCart.length, false);
        }

        return Scaffold(
          backgroundColor: AppColors.kBackground,
          appBar: AppBar(
            title: Text(
              'Cart',
              style: txtStyle,
            ),
            backgroundColor: AppColors.kBackground,
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                        'Are you sure you want to clear the cart?',
                        style: TextStyle(fontSize: 16),
                      ),
                      actions: [
                        PrimaryTextButton(
                          onPressed: () => Navigator.pop(context),
                          title: 'Cancel',
                        ),
                        PrimaryTextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            restaurant.clearCart();
                            setState(() {
                              _checkedItems.clear();
                            });
                          },
                          title: 'Yes',
                        )
                      ],
                    ),
                  );
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    userCart.isEmpty
                        ? const Expanded(
                            child: Center(child: Text("Cart is empty")))
                        : Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                final cartItem = userCart[index];
                                return MyCartTile(
                                  cartItem: cartItem,
                                  isChecked: _checkedItems[index],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _checkedItems[index] = value ?? false;
                                    });
                                  },
                                );
                              },
                              itemCount: userCart.length,
                            ),
                          ),
                  ],
                ),
              ),
              userCart.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 25),
                      child: PrimaryButton(
                        onTap: () {
                          final selectedItems = userCart
                              .asMap()
                              .entries
                              .where((entry) => _checkedItems[entry.key])
                              .map((entry) => entry.value)
                              .toList();
                          if (selectedItems.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentScreen(
                                  selectedItems: selectedItems,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Please select items to checkout'),
                              ),
                            );
                          }
                        },
                        title: 'Checkout',
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
