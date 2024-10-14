import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/export_components/login_components.dart';
import 'package:food_delivery_app/components/quantity_selector.dart';
import 'package:food_delivery_app/models/cart_item.dart';
import 'package:food_delivery_app/models/restaurant.dart';
import 'package:food_delivery_app/themes/app_colors.dart';
import 'package:provider/provider.dart';

class MyCartTile extends StatefulWidget {
  const MyCartTile({
    super.key,
    required this.cartItem,
    this.onTap,
    this.isChecked,
    this.onChanged,
    this.showControls = true,
    this.showRemoveButton = true,
  });

  final CartItem cartItem;
  final bool? isChecked;
  final ValueChanged<bool?>? onChanged;
  final bool showControls;
  final bool showRemoveButton; // New parameter
  final InkWell? onTap;

  @override
  State<MyCartTile> createState() => _MyCartTileState();
}

class _MyCartTileState extends State<MyCartTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) => Container(
        decoration: BoxDecoration(
          color: AppColors.kWhiteColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Conditionally display the checkbox
                  if (widget.showControls)
                    Padding(
                      padding: const EdgeInsets.only(top: 16, right: 5),
                      child: Checkbox(
                        value: widget.isChecked ?? false,
                        onChanged: widget.onChanged ?? (value) {},
                      ),
                    ),

                  // Conditionally display the remove button
                  if (widget.showRemoveButton)
                    Padding(
                      padding: const EdgeInsets.only(top: 16, right: 5),
                      child: IconButton(
                        onPressed: () {
                          restaurant.clearCart();
                        },
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: Colors.red,
                          semanticLabel: 'Cancel',
                        ),
                      ),
                    ),

                  // Food image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.asset(
                        widget.cartItem.food.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.cartItem.food.name,
                          softWrap: true,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text("₱${widget.cartItem.food.price.toString()}"),
                        const SizedBox(
                          height: 3,
                        ),
                        // Increment or decrement quantity
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: widget.showControls
                                  ? QuantitySelector(
                                      quantity: widget.cartItem.quantity,
                                      food: widget.cartItem.food,
                                      onIncrement: () {
                                        restaurant.addToCart(
                                          widget.cartItem.food,
                                          widget.cartItem.selectedAddons,
                                        );
                                      },
                                      onDecrement: () {
                                        restaurant
                                            .removeFromCart(widget.cartItem);
                                      },
                                    )
                                  : Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child:
                                            Text('${widget.cartItem.quantity}x',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                      ),
                                    ),
                            ),
                            const Spacer(),
                            Text(
                              "₱${widget.cartItem.totalPrice.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Addons
            SizedBox(
              height: widget.cartItem.selectedAddons.isEmpty ? 0 : 60,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: widget.cartItem.selectedAddons
                      .map(
                        (addon) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Row(
                              children: [
                                Text(addon.name),
                                Text(' (₱${addon.price}) '),
                              ],
                            ),
                            shape: const StadiumBorder(),
                            onSelected: (value) {},
                            backgroundColor: Colors.grey.shade100,
                            labelStyle: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
