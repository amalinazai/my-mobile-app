// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'country_model.freezed.dart';
part 'country_model.g.dart';

@freezed
class Country with _$Country {
  factory Country({
    int? id,
    String? name,
    String? code,
    String? image_url,
  }) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

  const Country._();
}

@freezed
class CountryList with _$CountryList {
  const factory CountryList(List<Country> items) = _CountryList;

  factory CountryList.fromJson(Map<String, dynamic> json) => _$CountryListFromJson(json);
}
