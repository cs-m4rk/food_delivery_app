import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:food_delivery_app/components/export_components/login_components.dart';
import 'package:food_delivery_app/components/primary_textformfield.dart';
import 'package:food_delivery_app/models/address.dart';

class NewAddressScreen extends StatefulWidget {
  const NewAddressScreen({super.key});

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

  @override
  void initState() {
    super.initState();
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
              DropdownButton<String>(
                hint: const Text('Select Region'),
                value: selectedRegion,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedRegion = newValue;
                    // Optionally reset other selections
                    selectedProvince = null;
                    selectedCity = null;
                    selectedBarangay = null;
                  });
                },
                items: regions.map((region) {
                  return DropdownMenuItem<String>(
                    value: region.regionCode,
                    child: Text(region.name),
                  );
                }).toList(),
              ),

              const SizedBox(height: 10),

              // Show Provinces Dropdown if a Region is selected
              if (selectedRegion != null)
                Column(
                  children: [
                    DropdownButton<String>(
                      hint: const Text('Select Province'),
                      value: selectedProvince,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedProvince = newValue;
                          // Optionally reset other selections
                          selectedCity = null;
                          selectedBarangay = null;
                        });
                      },
                      items: provinces
                          .where((province) =>
                              province.regionCode == selectedRegion)
                          .map((province) {
                        return DropdownMenuItem<String>(
                          value: province.provCode,
                          child: Text(province.name),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 10),

                    // Show Cities Dropdown if a Province is selected
                    if (selectedProvince != null)
                      Column(
                        children: [
                          DropdownButton<String>(
                            hint: const Text('Select City'),
                            value: selectedCity,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCity = newValue;
                                // Optionally reset barangay selection
                                selectedBarangay = null;
                              });
                            },
                            items: cities
                                .where((city) =>
                                    city.provinceCode == selectedProvince)
                                .map((city) {
                              return DropdownMenuItem<String>(
                                value: city.cityCode,
                                child: Text(city.name),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 10),

                          // Show Barangays Dropdown if a City is selected
                          if (selectedCity != null)
                            DropdownButton<String>(
                              hint: const Text('Select Barangay'),
                              value: selectedBarangay,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedBarangay = newValue;
                                });
                              },
                              items: barangays
                                  .where((barangay) =>
                                      barangay.cityCode == selectedCity)
                                  .map((barangay) {
                                return DropdownMenuItem<String>(
                                  value: barangay.cityCode,
                                  child: Text(barangay.name),
                                );
                              }).toList(),
                            ),
                        ],
                      ),
                  ],
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
              PrimaryButton(onTap: () {}, text: 'Submit'),
            ],
          ),
        ),
      ),
    );
  }
}
