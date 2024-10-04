class CustomerDetails {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String region;
  final String province;
  final String city;
  final String barangay;
  final String postalCode;
  final String streetBuildingHouseNumber;

  CustomerDetails({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.region,
    required this.province,
    required this.city,
    required this.barangay,
    required this.postalCode,
    required this.streetBuildingHouseNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'region': region,
      'province': province,
      'city': city,
      'barangay': barangay,
      'postalCode': postalCode,
      'streetBuildingHouseNumber': streetBuildingHouseNumber,
    };
  }

  factory CustomerDetails.fromMap(Map<String, dynamic> map) {
    return CustomerDetails(
      id: map['id'],
      fullName: map['fullName'],
      phoneNumber: map['phoneNumber'],
      region: map['region'],
      province: map['province'],
      city: map['city'],
      barangay: map['barangay'],
      postalCode: map['postalCode'],
      streetBuildingHouseNumber: map['streetBuildingHouseNumber'],
    );
  }
}
