//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:wai_api/src/model/message.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'send_message_response.g.dart';

/// SendMessageResponse
///
/// Properties:
/// * [userMessage] 
/// * [replies] - AI先輩からの応答（複数の先輩が参加している場合は複数）
@BuiltValue()
abstract class SendMessageResponse implements Built<SendMessageResponse, SendMessageResponseBuilder> {
  @BuiltValueField(wireName: r'user_message')
  Message get userMessage;

  /// AI先輩からの応答（複数の先輩が参加している場合は複数）
  @BuiltValueField(wireName: r'replies')
  BuiltList<Message> get replies;

  SendMessageResponse._();

  factory SendMessageResponse([void updates(SendMessageResponseBuilder b)]) = _$SendMessageResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SendMessageResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SendMessageResponse> get serializer => _$SendMessageResponseSerializer();
}

class _$SendMessageResponseSerializer implements PrimitiveSerializer<SendMessageResponse> {
  @override
  final Iterable<Type> types = const [SendMessageResponse, _$SendMessageResponse];

  @override
  final String wireName = r'SendMessageResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SendMessageResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'user_message';
    yield serializers.serialize(
      object.userMessage,
      specifiedType: const FullType(Message),
    );
    yield r'replies';
    yield serializers.serialize(
      object.replies,
      specifiedType: const FullType(BuiltList, [FullType(Message)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SendMessageResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SendMessageResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'user_message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Message),
          ) as Message;
          result.userMessage.replace(valueDes);
          break;
        case r'replies':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Message)]),
          ) as BuiltList<Message>;
          result.replies.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SendMessageResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SendMessageResponseBuilder();
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

