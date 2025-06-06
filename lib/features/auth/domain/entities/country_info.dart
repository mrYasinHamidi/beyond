class CountryInfo {
  final String iso;
  final String name;
  final String dialCode;

  const CountryInfo({required this.iso, required this.name, required this.dialCode});

  factory CountryInfo.fromMap(String iso, Map<String, dynamic> map) =>
      CountryInfo(iso: iso, name: map['name'] as String, dialCode: map['dial_code'] as String);
}
