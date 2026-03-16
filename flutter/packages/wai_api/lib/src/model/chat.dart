//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:wai_api/src/model/persona.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'chat.g.dart';

/// Chat
///
/// Properties:
/// * [id] 
/// * [title] 
/// * [persona] 
/// * [participants] - 参加中のプリセット先輩
/// * [lastMessage] - 最新メッセージのプレビュー
/// * [createdAt] 
/// * [updatedAt] 
@BuiltValue()
abstract class Chat implements Built<Chat, ChatBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'persona')
  Persona get persona;

  /// 参加中のプリセット先輩
  @BuiltValueField(wireName: r'participants')
  BuiltList<Persona>? get participants;

  /// 最新メッセージのプレビュー
  @BuiltValueField(wireName: r'last_message')
  String? get lastMessage;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime get updatedAt;

  Chat._();

  factory Chat([void updates(ChatBuilder b)]) = _$Chat;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChatBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Chat> get serializer => _$ChatSerializer();
}

class _$ChatSerializer implements PrimitiveSerializer<Chat> {
  @override
  final Iterable<Type> types = const [Chat, _$Chat];

  @override
  final String wireName = r'Chat';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Chat object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    yield r'persona';
    yield serializers.serialize(
      object.persona,
      specifiedType: const FullType(Persona),
    );
    if (object.participants != null) {
      yield r'participants';
      yield serializers.serialize(
        object.participants,
        specifiedType: const FullType(BuiltList, [FullType(Persona)]),
      );
    }
    if (object.lastMessage != null) {
      yield r'last_message';
      yield serializers.serialize(
        object.lastMessage,
        specifiedType: const FullType(String),
      );
    }
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'updated_at';
    yield serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Chat object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ChatBuilder result,
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
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'persona':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Persona),
          ) as Persona;
          result.persona.replace(valueDes);
          break;
        case r'participants':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Persona)]),
          ) as BuiltList<Persona>;
          result.participants.replace(valueDes);
          break;
        case r'last_message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.lastMessage = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Chat deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChatBuilder();
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

