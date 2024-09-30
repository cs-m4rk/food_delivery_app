import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/food.dart';
import 'package:food_delivery_app/themes/app_colors.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final Food food;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantitySelector(
      {super.key,
      required this.quantity,
      required this.food,
      required this.onIncrement,
      required this.onDecrement});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: Colors.grey.shade200),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // decrease quantity
          GestureDetector(
            onTap: onDecrement,
            child: Icon(
              Icons.remove,
              size: 20,
            ),
          ),

          // quantity count
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              width: 20,
              child: Center(
                child: Text(
                  quantity.toString(),
                ),
              ),
            ),
          ),

          // increase quantity
          GestureDetector(
            onTap: onIncrement,
            child: Icon(
              Icons.add,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
