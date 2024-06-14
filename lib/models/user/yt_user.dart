import 'package:freezed_annotation/freezed_annotation.dart';

part 'yt_user.freezed.dart';
part 'yt_user.g.dart';

@freezed
class YTUser with _$YTUser {
  const factory YTUser({
    required String name,
    required String email,
    required String avatar,
  }) = _YTUser;

  factory YTUser.fromJson(Map<String, dynamic> json) => _$YTUserFromJson(json);
}
