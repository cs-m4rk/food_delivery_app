import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/export_components/login_components.dart';
import 'package:food_delivery_app/models/food.dart';
import 'package:food_delivery_app/models/restaurant.dart';
import 'package:food_delivery_app/routes/app_routes.dart';
import 'package:food_delivery_app/services/database/database.dart';
import 'package:food_delivery_app/themes/app_colors.dart';
import 'package:provider/provider.dart';

class FoodScreen extends StatefulWidget {
  FoodScreen({super.key, required this.food}) {
    // initialize selected addons
    for (Addon addon in food.availableAddons) {
      selectedAddons[addon] = false;
    }
  }

  final Food food;
  final Map<Addon, bool> selectedAddons = {};

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  // method to add to cart
  void addToCart(Food food, Map<Addon, bool> selectedAddons) {
    // close the current food page to go back to menu
    Navigator.pushNamed(context, AppRoutes.cart);

// format the selected addons
    List<Addon> currentlySelectedAddons = [];
    for (Addon addon in widget.food.availableAddons) {
      if (widget.selectedAddons[addon] == true) {
        currentlySelectedAddons.add(addon);
      }
    }

// add to cart

    context.read<Restaurant>().addToCart(food, currentlySelectedAddons);
  }

  final Database _database = Database();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 450,
                  child: Image.asset(
                    widget.food.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.food.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "₱${widget.food.price}",
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.food.description,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Add-ons',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.food.availableAddons.length,
                          itemBuilder: (context, index) {
                            // get individual addon
                            Addon addon = widget.food.availableAddons[index];

                            // return check box UI
                            return CheckboxListTile(
                              title: Text(addon.name),
                              value: widget.selectedAddons[addon],
                              subtitle: Text("₱${addon.price}"),
                              onChanged: (bool? value) {
                                setState(() {
                                  widget.selectedAddons[addon] = value!;
                                });
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),

                      // add to cart button
                      PrimaryButton(
                        onTap: () async {
                          addToCart(widget.food, widget.selectedAddons);
                        },
                        title: "Add to cart",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // back button
        SafeArea(
          child: Opacity(
            opacity: 0.7,
            child: SizedBox(
              width: 60,
              height: 60,
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.kWhiteColor,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
