//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:wai_api/src/model/message.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'message_list.g.dart';

/// MessageList
///
/// Properties:
/// * [messages] 
/// * [hasMore] - さらに古いメッセージが存在するか
@BuiltValue()
abstract class MessageList implements Built<MessageList, MessageListBuilder> {
  @BuiltValueField(wireName: r'messages')
  BuiltList<Message> get messages;

  /// さらに古いメッセージが存在するか
  @BuiltValueField(wireName: r'has_more')
  bool get hasMore;

  MessageList._();

  factory MessageList([void updates(MessageListBuilder b)]) = _$MessageList;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MessageListBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MessageList> get serializer => _$MessageListSerializer();
}

class _$MessageListSerializer implements PrimitiveSerializer<MessageList> {
  @override
  final Iterable<Type> types = const [MessageList, _$MessageList];

  @override
  final String wireName = r'MessageList';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MessageList object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'messages';
    yield serializers.serialize(
      object.messages,
      specifiedType: const FullType(BuiltList, [FullType(Message)]),
    );
    yield r'has_more';
    yield serializers.serialize(
      object.hasMore,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MessageList object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MessageListBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'messages':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Message)]),
          ) as BuiltList<Message>;
          result.messages.replace(valueDes);
          break;
        case r'has_more':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasMore = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MessageList deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MessageListBuilder();
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

