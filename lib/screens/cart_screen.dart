import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/restaurant.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        // cart
        final userCart = restaurant.cart;

        return Scaffold(
          appBar: AppBar(
            title: Text('Cart'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    title: Text(userCart[index].food.name),
                  ),
                  itemCount: userCart.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}