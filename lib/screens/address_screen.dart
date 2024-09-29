import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/export_components/login_components.dart';
import 'package:food_delivery_app/components/my_container.dart';
import 'package:food_delivery_app/routes/app_routes.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  int _selectedAddress = 1; // State to manage selected address

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address Selection'),
      ),
      body: SingleChildScrollView(
        child: MyContainer(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Radio(
                    value: 1,
                    groupValue: _selectedAddress,
                    onChanged: (value) {
                      setState(() {
                        _selectedAddress = value!;
                      });
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mark'),
                      Text('23932423'),
                    ],
                  ),
                  PrimaryTextButton(onPressed: () {}, title: 'Edit')
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Radio(
                    value: 2,
                    groupValue: _selectedAddress,
                    onChanged: (value) {
                      setState(() {
                        _selectedAddress = value!;
                      });
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('John'),
                      Text('12345678'),
                    ],
                  ),
                  PrimaryTextButton(onPressed: () {}, title: 'Edit')
                ],
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.newAddress);
                },
                text: 'Add Address',
                icon: Icon(Icons.add, color: Colors.white),
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
