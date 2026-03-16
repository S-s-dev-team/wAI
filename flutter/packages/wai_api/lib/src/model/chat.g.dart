// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Chat extends Chat {
  @override
  final String id;
  @override
  final String? title;
  @override
  final Persona persona;
  @override
  final BuiltList<Persona>? participants;
  @override
  final String? lastMessage;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  factory _$Chat([void Function(ChatBuilder)? updates]) =>
      (ChatBuilder()..update(updates))._build();

  _$Chat._(
      {required this.id,
      this.title,
      required this.persona,
      this.participants,
      this.lastMessage,
      required this.createdAt,
      required this.updatedAt})
      : super._();
  @override
  Chat rebuild(void Function(ChatBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChatBuilder toBuilder() => ChatBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Chat &&
        id == other.id &&
        title == other.title &&
        persona == other.persona &&
        participants == other.participants &&
        lastMessage == other.lastMessage &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, persona.hashCode);
    _$hash = $jc(_$hash, participants.hashCode);
    _$hash = $jc(_$hash, lastMessage.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Chat')
          ..add('id', id)
          ..add('title', title)
          ..add('persona', persona)
          ..add('participants', participants)
          ..add('lastMessage', lastMessage)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class ChatBuilder implements Builder<Chat, ChatBuilder> {
  _$Chat? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  PersonaBuilder? _persona;
  PersonaBuilder get persona => _$this._persona ??= PersonaBuilder();
  set persona(PersonaBuilder? persona) => _$this._persona = persona;

  ListBuilder<Persona>? _participants;
  ListBuilder<Persona> get participants =>
      _$this._participants ??= ListBuilder<Persona>();
  set participants(ListBuilder<Persona>? participants) =>
      _$this._participants = participants;

  String? _lastMessage;
  String? get lastMessage => _$this._lastMessage;
  set lastMessage(String? lastMessage) => _$this._lastMessage = lastMessage;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  ChatBuilder() {
    Chat._defaults(this);
  }

  ChatBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _persona = $v.persona.toBuilder();
      _participants = $v.participants?.toBuilder();
      _lastMessage = $v.lastMessage;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Chat other) {
    _$v = other as _$Chat;
  }

  @override
  void update(void Function(ChatBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Chat build() => _build();

  _$Chat _build() {
    _$Chat _$result;
    try {
      _$result = _$v ??
          _$Chat._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Chat', 'id'),
            title: title,
            persona: persona.build(),
            participants: _participants?.build(),
            lastMessage: lastMessage,
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'Chat', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, r'Chat', 'updatedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'persona';
        persona.build();
        _$failedField = 'participants';
        _participants?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(r'Chat', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
