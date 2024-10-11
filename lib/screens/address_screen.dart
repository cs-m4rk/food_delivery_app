import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/export_components/login_components.dart';
import 'package:food_delivery_app/components/my_container.dart';
import 'package:food_delivery_app/models/customer_details.dart';
import 'package:food_delivery_app/routes/app_routes.dart';
import 'package:food_delivery_app/services/auth/auth_service.dart';
import 'package:food_delivery_app/services/database/database.dart';
import 'package:food_delivery_app/themes/app_colors.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final Database db = Database();
  final userId = AuthService().getCurrentUser()!.uid;

  String capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }

  var textStyle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      appBar: AppBar(
        title: const Text('Address Selection'),
      ),
      body: FutureBuilder<List<CustomerDetails>>(
        future: db.getCustomerDetails(userId), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No addresses found.'));
          }

          final customerDetails = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                for (int i = 0; i < customerDetails.length; i++) ...[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context, customerDetails[i]);
                    },
                    child: MyContainer(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Wrap(
                                  spacing: 8.0,
                                  runSpacing: 4.0,
                                  children: [
                                    Text(
                                      customerDetails[i].fullName,
                                      style: textStyle,
                                    ),
                                    Text(
                                      customerDetails[i].phoneNumber,
                                      style: textStyle,
                                    ),
                                    Text(capitalize(customerDetails[i].region)),
                                    Text(capitalize(
                                        customerDetails[i].province)),
                                    Text(capitalize(customerDetails[i].city)),
                                    Text(capitalize(
                                        customerDetails[i].barangay)),
                                    Text(customerDetails[i].postalCode),
                                    Text(capitalize(customerDetails[i]
                                        .streetBuildingHouseNumber)),
                                  ],
                                ),
                              ),
                              PrimaryTextButton(
                                  onPressed: () {
                                    // Pass the selected customer details as arguments
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.editAddress,
                                      arguments: customerDetails[i],
                                    );
                                  },
                                  title: 'Edit')
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                PrimaryButton(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.newAddress)
                        .then((value) {
                      if (value != null && value is CustomerDetails) {
                        setState(() {
                          customerDetails.add(value);
                        });
                      }
                    });
                  },
                  title: 'Add Address',
                  spacer: const SizedBox(width: 5),
                  icon: const Icon(Icons.add_circle, color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
