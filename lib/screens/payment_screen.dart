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
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                // Navigate to AddressScreen and get the selected CustomerDetails
                final selectedDetails = await Navigator.pushNamed(
                  context,
                  AppRoutes.address,
                ) as CustomerDetails?;

                // Update the state only if a new address was selected
                if (selectedDetails != null) {
                  setState(() {
                    _selectedCustomerDetails =
                        selectedDetails; // Update the selected details
                  });
                }
              },
              child: MyContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Customer Details",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: [
                        if (_selectedCustomerDetails != null) ...[
                          Text(_selectedCustomerDetails!.fullName),
                          Text(_selectedCustomerDetails!.phoneNumber),
                          Text(_selectedCustomerDetails!.region),
                          Text(_selectedCustomerDetails!.province),
                          Text(_selectedCustomerDetails!.city),
                          Text(_selectedCustomerDetails!.barangay),
                          Text(_selectedCustomerDetails!.postalCode),
                          Text(_selectedCustomerDetails!
                              .streetBuildingHouseNumber),
                        ] else ...[
                          const Center(
                            child: Text('No address selected'),
                          )
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
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
            MyContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Payment Methods",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Gcash'),
                          Radio(
                            value: 1,
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
            MyContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Order Summary",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Shipping fee'),
                          Text('Merchandise Subtotal'),
                          Text('Total Payment'),
                        ],
                      ),
                      Column(
                        children: [
                          Text('₱${shippingFee.toStringAsFixed(2)}'),
                          Text('₱${subTotalPrice.toStringAsFixed(2)}'),
                          Text('₱${totalPrice.toStringAsFixed(2)}'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
              child: PrimaryButton(
                  onTap: () {
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
                  },
                  text: "Place Order"),
            ),
          ],
        ),
      ),
    );
  }
}
