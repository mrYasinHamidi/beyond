// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
  name: json['name'] as String,
  code: json['code'] as String,
  flag: json['flag'] as String,
  dialCode: json['dialCode'] as String,
  phoneNumberSpaceIndex: (json['phoneNumberSpaceIndex'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  length: (json['length'] as num).toInt(),
);

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
  'name': instance.name,
  'code': instance.code,
  'flag': instance.flag,
  'dialCode': instance.dialCode,
  'phoneNumberSpaceIndex': instance.phoneNumberSpaceIndex,
  'length': instance.length,
};
