// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_persona_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CallPersonaRequestPresetKeyEnum
    _$callPersonaRequestPresetKeyEnum_yarigai =
    const CallPersonaRequestPresetKeyEnum._('yarigai');
const CallPersonaRequestPresetKeyEnum _$callPersonaRequestPresetKeyEnum_nenshu =
    const CallPersonaRequestPresetKeyEnum._('nenshu');

CallPersonaRequestPresetKeyEnum _$callPersonaRequestPresetKeyEnumValueOf(
    String name) {
  switch (name) {
    case 'yarigai':
      return _$callPersonaRequestPresetKeyEnum_yarigai;
    case 'nenshu':
      return _$callPersonaRequestPresetKeyEnum_nenshu;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CallPersonaRequestPresetKeyEnum>
    _$callPersonaRequestPresetKeyEnumValues = BuiltSet<
        CallPersonaRequestPresetKeyEnum>(const <CallPersonaRequestPresetKeyEnum>[
  _$callPersonaRequestPresetKeyEnum_yarigai,
  _$callPersonaRequestPresetKeyEnum_nenshu,
]);

Serializer<CallPersonaRequestPresetKeyEnum>
    _$callPersonaRequestPresetKeyEnumSerializer =
    _$CallPersonaRequestPresetKeyEnumSerializer();

class _$CallPersonaRequestPresetKeyEnumSerializer
    implements PrimitiveSerializer<CallPersonaRequestPresetKeyEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'yarigai': 'yarigai',
    'nenshu': 'nenshu',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'yarigai': 'yarigai',
    'nenshu': 'nenshu',
  };

  @override
  final Iterable<Type> types = const <Type>[CallPersonaRequestPresetKeyEnum];
  @override
  final String wireName = 'CallPersonaRequestPresetKeyEnum';

  @override
  Object serialize(
          Serializers serializers, CallPersonaRequestPresetKeyEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CallPersonaRequestPresetKeyEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CallPersonaRequestPresetKeyEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CallPersonaRequest extends CallPersonaRequest {
  @override
  final CallPersonaRequestPresetKeyEnum presetKey;

  factory _$CallPersonaRequest(
          [void Function(CallPersonaRequestBuilder)? updates]) =>
      (CallPersonaRequestBuilder()..update(updates))._build();

  _$CallPersonaRequest._({required this.presetKey}) : super._();
  @override
  CallPersonaRequest rebuild(
          void Function(CallPersonaRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CallPersonaRequestBuilder toBuilder() =>
      CallPersonaRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CallPersonaRequest && presetKey == other.presetKey;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, presetKey.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CallPersonaRequest')
          ..add('presetKey', presetKey))
        .toString();
  }
}

class CallPersonaRequestBuilder
    implements Builder<CallPersonaRequest, CallPersonaRequestBuilder> {
  _$CallPersonaRequest? _$v;

  CallPersonaRequestPresetKeyEnum? _presetKey;
  CallPersonaRequestPresetKeyEnum? get presetKey => _$this._presetKey;
  set presetKey(CallPersonaRequestPresetKeyEnum? presetKey) =>
      _$this._presetKey = presetKey;

  CallPersonaRequestBuilder() {
    CallPersonaRequest._defaults(this);
  }

  CallPersonaRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _presetKey = $v.presetKey;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CallPersonaRequest other) {
    _$v = other as _$CallPersonaRequest;
  }

  @override
  void update(void Function(CallPersonaRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CallPersonaRequest build() => _build();

  _$CallPersonaRequest _build() {
    final _$result = _$v ??
        _$CallPersonaRequest._(
          presetKey: BuiltValueNullFieldError.checkNotNull(
              presetKey, r'CallPersonaRequest', 'presetKey'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
