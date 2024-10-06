class CustomerDetails {
  String? documentId; // Add this field
  String userId;
  String fullName;
  String phoneNumber;
  String region;
  String province;
  String city;
  String barangay;
  String postalCode;
  String streetBuildingHouseNumber;

  CustomerDetails({
    this.documentId,
    required this.userId,
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
      'documentId': documentId, // Include documentId if needed
      'userId': userId,
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
      documentId: map['documentId'], // Capture documentId from map if needed
      userId: map['userId'],
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
