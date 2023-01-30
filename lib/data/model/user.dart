import 'package:freezed_annotation/freezed_annotation.dart';

part '../../domain/model/user/user.freezed.dart';

part '../../domain/model/user/user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String userName,
    required String email,
    //required String password,
    String? refreshToken
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
