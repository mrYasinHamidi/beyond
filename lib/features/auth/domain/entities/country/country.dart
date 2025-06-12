import 'dart:io';

import 'package:beyond/main.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable()
class Country extends Equatable {
  final String name;
  final String code;
  final String flag;
  final String dialCode;
  final List<int> phoneNumberSpaceIndex;
  final int length;

  const Country({
    required this.name,
    required this.code,
    required this.flag,
    required this.dialCode,
    required this.phoneNumberSpaceIndex,
    required this.length,
  });

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);

  @override
  List<Object?> get props => [code];
}

extension CountryListX on List<Country> {
  Future<String?> findUserCountryCode() async {
    try {
      final simIso = await FlutterSimCountryCode.simCountryCode;
      if (simIso != null && simIso.isNotEmpty) return simIso.toUpperCase();
    } catch (_) {}

    try {
      final locale = Platform.localeName;
      final parts = locale.split('_');
      if (parts.length == 2) return parts[1].toUpperCase();
    } catch (_) {}

    return null;
  }

  Future<Country?> findUserCountry() async {
    final countryCode = await findUserCountryCode();
    if (countryCode == null) return null;

    final userCountry = firstWhereOrNull((country) => country.code.startsWith(countryCode));
    return userCountry;
  }
}
