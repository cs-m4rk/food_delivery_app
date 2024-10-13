import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/my_cart_tile.dart';
import 'package:food_delivery_app/models/cart_item.dart';
import 'package:food_delivery_app/models/order_details.dart';
import 'package:food_delivery_app/services/auth/auth_service.dart';
import 'package:food_delivery_app/services/database/database.dart';

class OrdersScreen extends StatefulWidget {
  final List<CartItem> selectedItems;
  const OrdersScreen({super.key, required this.selectedItems});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late List<CartItem> selectedItems;
  Database db = Database();
  final userId = AuthService().getCurrentUser()!.uid;

  var txtStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Orders',
          style: txtStyle,
        ),
      ),
      body: FutureBuilder<OrderDetails?>(
        future: db.getOrderDetails(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No user data found.'));
          }

          final orderDetails = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.selectedItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = widget.selectedItems[index];
                    return MyCartTile(
                      cartItem: cartItem,
                      isChecked: false,
                      onChanged: (value) {},
                      showControls: false,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
