// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LoginResponse extends LoginResponse {
  @override
  final String id;
  @override
  final String firebaseUid;
  @override
  final String? email;
  @override
  final String? displayName;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  factory _$LoginResponse([void Function(LoginResponseBuilder)? updates]) =>
      (LoginResponseBuilder()..update(updates))._build();

  _$LoginResponse._(
      {required this.id,
      required this.firebaseUid,
      this.email,
      this.displayName,
      required this.createdAt,
      required this.updatedAt})
      : super._();
  @override
  LoginResponse rebuild(void Function(LoginResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginResponseBuilder toBuilder() => LoginResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginResponse &&
        id == other.id &&
        firebaseUid == other.firebaseUid &&
        email == other.email &&
        displayName == other.displayName &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, firebaseUid.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LoginResponse')
          ..add('id', id)
          ..add('firebaseUid', firebaseUid)
          ..add('email', email)
          ..add('displayName', displayName)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class LoginResponseBuilder
    implements Builder<LoginResponse, LoginResponseBuilder> {
  _$LoginResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _firebaseUid;
  String? get firebaseUid => _$this._firebaseUid;
  set firebaseUid(String? firebaseUid) => _$this._firebaseUid = firebaseUid;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  LoginResponseBuilder() {
    LoginResponse._defaults(this);
  }

  LoginResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _firebaseUid = $v.firebaseUid;
      _email = $v.email;
      _displayName = $v.displayName;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginResponse other) {
    _$v = other as _$LoginResponse;
  }

  @override
  void update(void Function(LoginResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LoginResponse build() => _build();

  _$LoginResponse _build() {
    final _$result = _$v ??
        _$LoginResponse._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'LoginResponse', 'id'),
          firebaseUid: BuiltValueNullFieldError.checkNotNull(
              firebaseUid, r'LoginResponse', 'firebaseUid'),
          email: email,
          displayName: displayName,
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'LoginResponse', 'createdAt'),
          updatedAt: BuiltValueNullFieldError.checkNotNull(
              updatedAt, r'LoginResponse', 'updatedAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
