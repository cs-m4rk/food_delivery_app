import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:food_delivery_app/components/export_components/login_components.dart';
import 'package:food_delivery_app/components/my_dropdown.dart';
import 'package:food_delivery_app/components/primary_textformfield.dart';
import 'package:food_delivery_app/models/address.dart';
import 'package:food_delivery_app/models/customer_details.dart';
import 'package:food_delivery_app/services/auth/auth_service.dart';
import 'package:food_delivery_app/services/database/database.dart';
import 'package:get/get.dart';

class NewAddressScreen extends StatefulWidget {
  final CustomerDetails? customerDetails;
  const NewAddressScreen({super.key, this.customerDetails});

  @override
  State<NewAddressScreen> createState() => _NewAddressScreenState();
}

class _NewAddressScreenState extends State<NewAddressScreen> {
  TextEditingController fullName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController postalCode = TextEditingController();
  TextEditingController strtBldgHno = TextEditingController();

  String? selectedRegion;
  String? selectedProvince;
  String? selectedCity;
  String? selectedBarangay;

  List<Region> regions = [];
  List<Province> provinces = [];
  List<City> cities = [];
  List<Barangay> barangays = [];

  Future<void> saveCustomerDetails() async {
    final Database database = Database();
    final userId = AuthService().getCurrentUser()!.uid;

    try {
      final CustomerDetails newAddress = CustomerDetails(
        fullName: fullName.text,
        phoneNumber: phoneNumber.text,
        postalCode: postalCode.text,
        streetBuildingHouseNumber: strtBldgHno.text,
        region: selectedRegion!,
        province: selectedProvince!,
        city: selectedCity!,
        barangay: selectedBarangay!,
        userId: userId,
      );

      await database.saveCustomerDetails(userId, newAddress);

      Get.snackbar('', "Successfully saved");
      Navigator.pop(context);
    } catch (e) {
      Get.snackbar('', "Failed to save");
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.customerDetails != null) {
      // Populate fields with the passed customer details for editing
      fullName.text = widget.customerDetails!.fullName;
      phoneNumber.text = widget.customerDetails!.phoneNumber;
      postalCode.text = widget.customerDetails!.postalCode;
      strtBldgHno.text = widget.customerDetails!.streetBuildingHouseNumber;
      selectedRegion = widget.customerDetails!.region;
      selectedProvince = widget.customerDetails!.province;
      selectedCity = widget.customerDetails!.city;
      selectedBarangay = widget.customerDetails!.barangay;
    }
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    final String regionsResponse =
        await rootBundle.loadString('assets/philippines_address/regions.json');
    final String provincesResponse = await rootBundle
        .loadString('assets/philippines_address/provinces.json');
    final String citiesResponse =
        await rootBundle.loadString('assets/philippines_address/city-mun.json');
    final String barangaysResponse = await rootBundle
        .loadString('assets/philippines_address/barangays.json');

    final List<dynamic> regionsData = json.decode(regionsResponse);
    final List<dynamic> provincesData = json.decode(provincesResponse);
    final List<dynamic> citiesData = json.decode(citiesResponse);
    final List<dynamic> barangaysData = json.decode(barangaysResponse);

    setState(() {
      regions = regionsData.map((json) => Region.fromJson(json)).toList();
      provinces = provincesData.map((json) => Province.fromJson(json)).toList();
      cities = citiesData.map((json) => City.fromJson(json)).toList();
      barangays = barangaysData.map((json) => Barangay.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final CustomerDetails? customerDetails =
        ModalRoute.of(context)?.settings.arguments as CustomerDetails?;

    if (customerDetails != null) {
      // Populate fields with the passed customer details for editing
      fullName.text = customerDetails.fullName;
      phoneNumber.text = customerDetails.phoneNumber;
      postalCode.text = customerDetails.postalCode;
      strtBldgHno.text = customerDetails.streetBuildingHouseNumber;
      selectedRegion = customerDetails.region;
      selectedProvince = customerDetails.province;
      selectedCity = customerDetails.city;
      selectedBarangay = customerDetails.barangay;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Address'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Contact'),
              const SizedBox(height: 10),
              PrimaryTextformfield(
                controller: fullName,
                labelText: 'Full Name',
              ),
              const SizedBox(height: 10),
              PrimaryTextformfield(
                controller: phoneNumber,
                labelText: 'Phone Number',
              ),
              const SizedBox(height: 20),
              const Text('Address'),
              const SizedBox(height: 10),

              // Dropdown for Regions

              MyDropdown(
                name: 'Region',
                address: regions,
                selectedValue: selectedRegion,
                getLabel: (region) => region.name,
                getValue: (region) => region.name,
                isEnable: true,
                filterAddress: null, // No filter for regions
                onChanged: (String? newValue) {
                  setState(() {
                    selectedRegion = newValue;
                    selectedProvince = null;
                    selectedCity = null;
                    selectedBarangay = null;
                  });
                },
              ),
              const SizedBox(height: 10),

              // Dropdown for Provinces
              if (selectedRegion != null)
                MyDropdown(
                  name: 'Province',
                  address: provinces,
                  selectedValue: selectedProvince,
                  getLabel: (province) => province.name,
                  getValue: (province) => province.name,
                  isEnable: true,
                  filterAddress: (province) =>
                      province.regionCode ==
                      regions
                          .firstWhereOrNull(
                              (region) => region.name == selectedRegion)
                          ?.regionCode,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedProvince = newValue;
                      selectedCity = null;
                      selectedBarangay = null;
                    });
                  },
                ),
              const SizedBox(height: 10),

              // city dropdown
              if (selectedProvince != null)
                MyDropdown(
                  name: 'City/Municipality',
                  address: cities,
                  selectedValue: selectedCity,
                  getLabel: (city) => city.name,
                  getValue: (city) => city.name,
                  isEnable: true,
                  filterAddress: (city) =>
                      city.provCode ==
                      provinces
                          .firstWhereOrNull(
                              (province) => province.name == selectedProvince)
                          ?.provCode,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCity = newValue;
                      selectedBarangay = null;
                    });
                  },
                ),

              const SizedBox(height: 10),

              if (selectedCity != null)
                MyDropdown(
                  name: 'Barangay',
                  address: barangays,
                  selectedValue: selectedBarangay,
                  getLabel: (barangay) => barangay.name,
                  getValue: (barangay) => barangay.name,
                  isEnable: true,
                  filterAddress: (barangay) =>
                      barangay.cityCode ==
                      cities
                          .firstWhereOrNull((city) => city.name == selectedCity)
                          ?.cityCode,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedBarangay = newValue;
                    });
                  },
                ),

              const SizedBox(height: 10),

              PrimaryTextformfield(
                controller: postalCode,
                labelText: 'Postal Code',
              ),
              const SizedBox(height: 10),
              PrimaryTextformfield(
                controller: strtBldgHno,
                labelText: 'Street, Building, House Number',
              ),

              const SizedBox(height: 30),
              // GoogleMap(

              // ),
              PrimaryButton(
                  onTap: () => saveCustomerDetails(), title: 'Submit'),
            ],
          ),
        ),
      ),
    );
  }
}
