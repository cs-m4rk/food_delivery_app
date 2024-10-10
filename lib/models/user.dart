class User {
  final String fullName;
  final String email;
  final String? phoneNumber;
  final String? imageUrl;

  User({
    required this.fullName,
    required this.email,
    this.phoneNumber,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      fullName: map['fullName'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      imageUrl: map['imageUrl'],
    );
  }
}
