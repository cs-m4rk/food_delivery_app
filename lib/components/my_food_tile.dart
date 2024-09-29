import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/food.dart';

class MyFoodTile extends StatelessWidget {
  const MyFoodTile({super.key, required this.food, this.onTap});

  final Food food;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  // food details
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "₱${food.price}",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(food.description),
                    ],
                  ),
                ),

                const SizedBox(width: 15),

                // food image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      food.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: Colors.grey.shade100,
          thickness: 0.8,
        ),
      ],
    );
  }
}
