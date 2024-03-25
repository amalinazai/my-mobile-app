// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars, require_trailing_commas
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination.freezed.dart';
part 'pagination.g.dart';

@freezed
class Pagination with _$Pagination {

  const factory Pagination({
    @Default(0) int total,
    @Default(0) int skip,
    @Default(0) int limit,
  }) = _Pagination;
  
  const Pagination._();

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  int get current_page => (skip/limit).floor() + 1;

  int get last_page => (total/limit).ceil();

  bool get canLoadMore => current_page < last_page;
}
