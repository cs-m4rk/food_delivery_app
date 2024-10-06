import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/my_cart_tile.dart';
import 'package:food_delivery_app/models/cart_item.dart';

class OrdersScreen extends StatefulWidget {
  final List<CartItem> selectedItems;
  const OrdersScreen({super.key, required this.selectedItems});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late List<CartItem> selectedItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: SingleChildScrollView(
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
      ),
    );
  }
}
