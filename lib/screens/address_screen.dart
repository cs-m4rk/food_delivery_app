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
  List<CustomerDetails> _customerDetails = [];

  Future<void> _getCustomerDetails() async {
    // Get customer details from the database
    Database db = Database();
    List<CustomerDetails> customerDetails = await db.getCustomerDetails();
    setState(() {
      _customerDetails = customerDetails;
    });
  }

  @override
  void initState() {
    _getCustomerDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      appBar: AppBar(
        title: const Text('Address Selection'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            if (_customerDetails.isNotEmpty) ...[
              for (int i = 0; i < _customerDetails.length; i++) ...[
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, _customerDetails[i]);
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
                                  Text(_customerDetails[i].fullName),
                                  Text(_customerDetails[i].phoneNumber),
                                  Text(_customerDetails[i].region),
                                  Text(_customerDetails[i].province),
                                  Text(_customerDetails[i].city),
                                  Text(_customerDetails[i].barangay),
                                  Text(_customerDetails[i].postalCode),
                                  Text(_customerDetails[i]
                                      .streetBuildingHouseNumber),
                                ],
                              ),
                            ),
                            PrimaryTextButton(onPressed: () {}, title: 'Edit')
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 10),
            ] else ...[
             Container()
            ],
            const SizedBox(height: 20),
            PrimaryButton(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.newAddress)
                    .then((value) {
                  if (value != null && value is CustomerDetails) {
                    setState(() {
                      _customerDetails.add(value);
                    });
                  }
                });
              },
              text: 'Add Address',
              spacer: const SizedBox(
                width: 5,
              ),
              icon: const Icon(Icons.add_circle, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
