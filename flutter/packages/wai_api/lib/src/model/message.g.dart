// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MessageSenderTypeEnum _$messageSenderTypeEnum_user =
    const MessageSenderTypeEnum._('user');
const MessageSenderTypeEnum _$messageSenderTypeEnum_persona =
    const MessageSenderTypeEnum._('persona');

MessageSenderTypeEnum _$messageSenderTypeEnumValueOf(String name) {
  switch (name) {
    case 'user':
      return _$messageSenderTypeEnum_user;
    case 'persona':
      return _$messageSenderTypeEnum_persona;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<MessageSenderTypeEnum> _$messageSenderTypeEnumValues =
    BuiltSet<MessageSenderTypeEnum>(const <MessageSenderTypeEnum>[
  _$messageSenderTypeEnum_user,
  _$messageSenderTypeEnum_persona,
]);

Serializer<MessageSenderTypeEnum> _$messageSenderTypeEnumSerializer =
    _$MessageSenderTypeEnumSerializer();

class _$MessageSenderTypeEnumSerializer
    implements PrimitiveSerializer<MessageSenderTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'user': 'user',
    'persona': 'persona',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'user': 'user',
    'persona': 'persona',
  };

  @override
  final Iterable<Type> types = const <Type>[MessageSenderTypeEnum];
  @override
  final String wireName = 'MessageSenderTypeEnum';

  @override
  Object serialize(Serializers serializers, MessageSenderTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MessageSenderTypeEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MessageSenderTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Message extends Message {
  @override
  final String id;
  @override
  final String chatId;
  @override
  final MessageSenderTypeEnum senderType;
  @override
  final Persona? persona;
  @override
  final String content;
  @override
  final DateTime createdAt;

  factory _$Message([void Function(MessageBuilder)? updates]) =>
      (MessageBuilder()..update(updates))._build();

  _$Message._(
      {required this.id,
      required this.chatId,
      required this.senderType,
      this.persona,
      required this.content,
      required this.createdAt})
      : super._();
  @override
  Message rebuild(void Function(MessageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MessageBuilder toBuilder() => MessageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Message &&
        id == other.id &&
        chatId == other.chatId &&
        senderType == other.senderType &&
        persona == other.persona &&
        content == other.content &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, chatId.hashCode);
    _$hash = $jc(_$hash, senderType.hashCode);
    _$hash = $jc(_$hash, persona.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Message')
          ..add('id', id)
          ..add('chatId', chatId)
          ..add('senderType', senderType)
          ..add('persona', persona)
          ..add('content', content)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class MessageBuilder implements Builder<Message, MessageBuilder> {
  _$Message? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _chatId;
  String? get chatId => _$this._chatId;
  set chatId(String? chatId) => _$this._chatId = chatId;

  MessageSenderTypeEnum? _senderType;
  MessageSenderTypeEnum? get senderType => _$this._senderType;
  set senderType(MessageSenderTypeEnum? senderType) =>
      _$this._senderType = senderType;

  PersonaBuilder? _persona;
  PersonaBuilder get persona => _$this._persona ??= PersonaBuilder();
  set persona(PersonaBuilder? persona) => _$this._persona = persona;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  MessageBuilder() {
    Message._defaults(this);
  }

  MessageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _chatId = $v.chatId;
      _senderType = $v.senderType;
      _persona = $v.persona?.toBuilder();
      _content = $v.content;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Message other) {
    _$v = other as _$Message;
  }

  @override
  void update(void Function(MessageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Message build() => _build();

  _$Message _build() {
    _$Message _$result;
    try {
      _$result = _$v ??
          _$Message._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Message', 'id'),
            chatId: BuiltValueNullFieldError.checkNotNull(
                chatId, r'Message', 'chatId'),
            senderType: BuiltValueNullFieldError.checkNotNull(
                senderType, r'Message', 'senderType'),
            persona: _persona?.build(),
            content: BuiltValueNullFieldError.checkNotNull(
                content, r'Message', 'content'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'Message', 'createdAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'persona';
        _persona?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Message', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
