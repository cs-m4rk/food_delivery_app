import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/export_components/login_components.dart';
import 'package:food_delivery_app/components/my_cart_tile.dart';
import 'package:food_delivery_app/components/my_container.dart';
import 'package:food_delivery_app/models/cart_item.dart';
import 'package:food_delivery_app/models/customer_details.dart';
import 'package:food_delivery_app/models/order_details.dart';
import 'package:food_delivery_app/models/restaurant.dart';
import 'package:food_delivery_app/routes/app_routes.dart';
import 'package:food_delivery_app/screens/orders_screen.dart';
import 'package:food_delivery_app/services/auth/auth_service.dart';
import 'package:food_delivery_app/services/database/database.dart';
import 'package:food_delivery_app/themes/app_colors.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  final List<CartItem> selectedItems;

  const PaymentScreen({super.key, required this.selectedItems});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedPaymentMethod = 0;
  CustomerDetails? _selectedCustomerDetails;
  final Database _database = Database();

  String capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }

  var textStyle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  @override
  @override
  Widget build(BuildContext context) {
    final restaurant = Provider.of<Restaurant>(context);
    final subTotalPrice = restaurant.getTotalPrice();
    final shippingFee = 10.00;
    final totalPrice = subTotalPrice + shippingFee;

    return Scaffold(
      backgroundColor: AppColors.kBackground,
      appBar: AppBar(
        backgroundColor: AppColors.kBackground,
        title: const Text("Checkout"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Customer details
                      InkWell(
                        onTap: () async {
                          final selectedDetails = await Navigator.pushNamed(
                            context,
                            AppRoutes.address,
                          ) as CustomerDetails?;

                          if (selectedDetails != null) {
                            setState(() {
                              _selectedCustomerDetails = selectedDetails;
                            });
                          }
                        },
                        child: MyContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Customer Details",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              if (_selectedCustomerDetails != null) ...[
                                Wrap(
                                  spacing: 10,
                                  children: [
                                    Text(
                                      _selectedCustomerDetails!.fullName,
                                      style: textStyle,
                                    ),
                                    Text(
                                      _selectedCustomerDetails!.phoneNumber,
                                      style: textStyle,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                    ),
                                    Text(_selectedCustomerDetails!.region),
                                    Text(_selectedCustomerDetails!.province),
                                    Text(_selectedCustomerDetails!.city),
                                    Text(_selectedCustomerDetails!.barangay),
                                    Text(_selectedCustomerDetails!.postalCode),
                                    Text(_selectedCustomerDetails!
                                        .streetBuildingHouseNumber),
                                  ],
                                )
                              ] else ...[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.location_on,
                                      color: AppColors.kSecondary,
                                    ),
                                    SizedBox(width: 5),
                                    Text('Add Address'),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Cart items
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

                      // Payment method
                      MyContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Payment Methods",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Cash on Delivery'),
                                    Radio(
                                      value: 0,
                                      groupValue: _selectedPaymentMethod,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedPaymentMethod = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Order summary
                      MyContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Order Summary",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Delivery fee'),
                                    Text('Merchandise Subtotal'),
                                    Text('Total Payment'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('₱${shippingFee.toStringAsFixed(2)}'),
                                    Text(
                                        '₱${subTotalPrice.toStringAsFixed(2)}'),
                                    Text('₱${totalPrice.toStringAsFixed(2)}'),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Button placed at the bottom
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: PrimaryButton(
                  onTap: () {
                    if (_selectedCustomerDetails == null) {
                      Get.snackbar(
                        'Message',
                        'Please add your address',
                      );
                    } else {
                      final userId = AuthService().getCurrentUser()!.uid;
                      final orderDetails = OrderDetails(
                          userId: userId,
                          cartItems: widget.selectedItems,
                          customerDetails: _selectedCustomerDetails!,
                          paymentMethod: _selectedPaymentMethod == 0
                              ? 'Cash on Delivery'
                              : 'Gcash',
                          totalPrice: totalPrice,
                          shippingFee: shippingFee,
                          subTotalPrice: subTotalPrice,
                          createdAt: DateTime.now());

                      _database.saveOrderDetails(orderDetails);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrdersScreen(
                            selectedItems: widget.selectedItems,
                          ),
                        ),
                      );
                    }
                  },
                  title: "Place Order",
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
