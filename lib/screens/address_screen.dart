import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/export_components/login_components.dart';
import 'package:food_delivery_app/components/my_container.dart';
import 'package:food_delivery_app/models/customer_details.dart';
import 'package:food_delivery_app/routes/app_routes.dart';
import 'package:food_delivery_app/services/database/database.dart';
import 'package:food_delivery_app/themes/app_colors.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final Database db = Database();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      appBar: AppBar(
        title: const Text('Address Selection'),
      ),
      body: FutureBuilder<List<CustomerDetails>>(
        future: db.getCustomerDetails(), // Fetch customer details
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
                                    Text(customerDetails[i].fullName),
                                    Text(customerDetails[i].phoneNumber),
                                    Text(customerDetails[i].region),
                                    Text(customerDetails[i].province),
                                    Text(customerDetails[i].city),
                                    Text(customerDetails[i].barangay),
                                    Text(customerDetails[i].postalCode),
                                    Text(customerDetails[i]
                                        .streetBuildingHouseNumber),
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
                const SizedBox(height: 10),
                const SizedBox(height: 20),
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
                  text: 'Add Address',
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
