class Region {
  final String name;
  final String regionCode;

  Region({required this.name, required this.regionCode});

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      name: json['name'] ?? '',
      regionCode: json['reg_code'] ?? '',
    );
  }
}

class Province {
  final String regionCode;
  final String name;
  final String provCode;

  Province({
    required this.name,
    required this.regionCode,
    required this.provCode,

  });

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      name: json['name'] ?? '',
      regionCode: json['reg_code'] ?? '',
      provCode: json['prov_code'] ?? '',
    );
  }
}

class City {
  final String name;
  final String provinceCode;
  final String cityCode;

  City({required this.name, required this.provinceCode, required this.cityCode});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'] ?? '',
      provinceCode: json['prov_code'] ?? '',
      cityCode: json['mun_code'] ?? '',
    );
  }
}

class Barangay {
  final String name;
  final String cityCode;

  Barangay({required this.name, required this.cityCode});

  factory Barangay.fromJson(Map<String, dynamic> json) {
    return Barangay(
      name: json['name'] ?? '',
      cityCode: json['mun_code'] ?? '',
    );
  }
}

