import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/my_cart_tile.dart';
import 'package:food_delivery_app/models/restaurant.dart';
import 'package:food_delivery_app/routes/app_routes.dart';
import 'package:food_delivery_app/services/auth/auth_service.dart';
import 'package:food_delivery_app/services/database/database.dart';
import 'package:food_delivery_app/themes/app_colors.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var txtStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  Database db = Database();
  final userId = AuthService().getCurrentUser()!.uid;

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        final userCart = restaurant.cart;

        return Scaffold(
          backgroundColor: AppColors.kBackground,
          appBar: AppBar(
            title: Text(
              'Orders',
              style: txtStyle,
            ),
            backgroundColor: AppColors.kBackground,
          ),
          body: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    userCart.isEmpty
                        ? const Expanded(
                            child: Center(child: Text("No orders yet")))
                        : Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                final cartItem = userCart[index];
                                return MyCartTile(
                                  cartItem: cartItem,
                                  showControls: false,
                                  isChecked: false,
                                );
                              },
                              itemCount: userCart.length,
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
