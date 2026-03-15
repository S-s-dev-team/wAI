//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:wai_api/src/model/persona.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'message.g.dart';

/// Message
///
/// Properties:
/// * [id] 
/// * [chatId] 
/// * [senderType] 
/// * [persona] 
/// * [content] - メッセージ本文
/// * [createdAt] 
@BuiltValue()
abstract class Message implements Built<Message, MessageBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'chat_id')
  String get chatId;

  @BuiltValueField(wireName: r'sender_type')
  MessageSenderTypeEnum get senderType;
  // enum senderTypeEnum {  user,  persona,  };

  @BuiltValueField(wireName: r'persona')
  Persona? get persona;

  /// メッセージ本文
  @BuiltValueField(wireName: r'content')
  String get content;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  Message._();

  factory Message([void updates(MessageBuilder b)]) = _$Message;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MessageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Message> get serializer => _$MessageSerializer();
}

class _$MessageSerializer implements PrimitiveSerializer<Message> {
  @override
  final Iterable<Type> types = const [Message, _$Message];

  @override
  final String wireName = r'Message';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Message object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'chat_id';
    yield serializers.serialize(
      object.chatId,
      specifiedType: const FullType(String),
    );
    yield r'sender_type';
    yield serializers.serialize(
      object.senderType,
      specifiedType: const FullType(MessageSenderTypeEnum),
    );
    if (object.persona != null) {
      yield r'persona';
      yield serializers.serialize(
        object.persona,
        specifiedType: const FullType(Persona),
      );
    }
    yield r'content';
    yield serializers.serialize(
      object.content,
      specifiedType: const FullType(String),
    );
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Message object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MessageBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'chat_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.chatId = valueDes;
          break;
        case r'sender_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MessageSenderTypeEnum),
          ) as MessageSenderTypeEnum;
          result.senderType = valueDes;
          break;
        case r'persona':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Persona),
          ) as Persona;
          result.persona.replace(valueDes);
          break;
        case r'content':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.content = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Message deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MessageBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

class MessageSenderTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'user')
  static const MessageSenderTypeEnum user = _$messageSenderTypeEnum_user;
  @BuiltValueEnumConst(wireName: r'persona')
  static const MessageSenderTypeEnum persona = _$messageSenderTypeEnum_persona;

  static Serializer<MessageSenderTypeEnum> get serializer => _$messageSenderTypeEnumSerializer;

  const MessageSenderTypeEnum._(String name): super(name);

  static BuiltSet<MessageSenderTypeEnum> get values => _$messageSenderTypeEnumValues;
  static MessageSenderTypeEnum valueOf(String name) => _$messageSenderTypeEnumValueOf(name);
}

