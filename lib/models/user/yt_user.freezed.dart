// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'yt_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

YTUser _$YTUserFromJson(Map<String, dynamic> json) {
  return _YTUser.fromJson(json);
}

/// @nodoc
mixin _$YTUser {
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get avatar => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $YTUserCopyWith<YTUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YTUserCopyWith<$Res> {
  factory $YTUserCopyWith(YTUser value, $Res Function(YTUser) then) =
      _$YTUserCopyWithImpl<$Res, YTUser>;
  @useResult
  $Res call({String name, String email, String avatar});
}

/// @nodoc
class _$YTUserCopyWithImpl<$Res, $Val extends YTUser>
    implements $YTUserCopyWith<$Res> {
  _$YTUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? avatar = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$YTUserImplCopyWith<$Res> implements $YTUserCopyWith<$Res> {
  factory _$$YTUserImplCopyWith(
          _$YTUserImpl value, $Res Function(_$YTUserImpl) then) =
      __$$YTUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String email, String avatar});
}

/// @nodoc
class __$$YTUserImplCopyWithImpl<$Res>
    extends _$YTUserCopyWithImpl<$Res, _$YTUserImpl>
    implements _$$YTUserImplCopyWith<$Res> {
  __$$YTUserImplCopyWithImpl(
      _$YTUserImpl _value, $Res Function(_$YTUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? avatar = null,
  }) {
    return _then(_$YTUserImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$YTUserImpl implements _YTUser {
  const _$YTUserImpl(
      {required this.name, required this.email, required this.avatar});

  factory _$YTUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$YTUserImplFromJson(json);

  @override
  final String name;
  @override
  final String email;
  @override
  final String avatar;

  @override
  String toString() {
    return 'YTUser(name: $name, email: $email, avatar: $avatar)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YTUserImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.avatar, avatar) || other.avatar == avatar));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, email, avatar);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$YTUserImplCopyWith<_$YTUserImpl> get copyWith =>
      __$$YTUserImplCopyWithImpl<_$YTUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$YTUserImplToJson(
      this,
    );
  }
}

abstract class _YTUser implements YTUser {
  const factory _YTUser(
      {required final String name,
      required final String email,
      required final String avatar}) = _$YTUserImpl;

  factory _YTUser.fromJson(Map<String, dynamic> json) = _$YTUserImpl.fromJson;

  @override
  String get name;
  @override
  String get email;
  @override
  String get avatar;
  @override
  @JsonKey(ignore: true)
  _$$YTUserImplCopyWith<_$YTUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
