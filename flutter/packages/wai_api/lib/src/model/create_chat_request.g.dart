// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_chat_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateChatRequest extends CreateChatRequest {
  @override
  final String? title;
  @override
  final CreatePersonaInput persona;

  factory _$CreateChatRequest(
          [void Function(CreateChatRequestBuilder)? updates]) =>
      (CreateChatRequestBuilder()..update(updates))._build();

  _$CreateChatRequest._({this.title, required this.persona}) : super._();
  @override
  CreateChatRequest rebuild(void Function(CreateChatRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateChatRequestBuilder toBuilder() =>
      CreateChatRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateChatRequest &&
        title == other.title &&
        persona == other.persona;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, persona.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateChatRequest')
          ..add('title', title)
          ..add('persona', persona))
        .toString();
  }
}

class CreateChatRequestBuilder
    implements Builder<CreateChatRequest, CreateChatRequestBuilder> {
  _$CreateChatRequest? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  CreatePersonaInputBuilder? _persona;
  CreatePersonaInputBuilder get persona =>
      _$this._persona ??= CreatePersonaInputBuilder();
  set persona(CreatePersonaInputBuilder? persona) => _$this._persona = persona;

  CreateChatRequestBuilder() {
    CreateChatRequest._defaults(this);
  }

  CreateChatRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _persona = $v.persona.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateChatRequest other) {
    _$v = other as _$CreateChatRequest;
  }

  @override
  void update(void Function(CreateChatRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateChatRequest build() => _build();

  _$CreateChatRequest _build() {
    _$CreateChatRequest _$result;
    try {
      _$result = _$v ??
          _$CreateChatRequest._(
            title: title,
            persona: persona.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'persona';
        persona.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CreateChatRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
