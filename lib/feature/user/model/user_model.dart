import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
@Collection(ignore: {'copyWith'})
class User with _$User {
  factory User({
    required int id,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? gender,
    String? image,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  const User._();

  Id get isarId => id;
}
