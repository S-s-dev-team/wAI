//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:wai_api/src/model/create_persona_input.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_chat_request.g.dart';

/// CreateChatRequest
///
/// Properties:
/// * [title] - チャットタイトル
/// * [persona] 
@BuiltValue()
abstract class CreateChatRequest implements Built<CreateChatRequest, CreateChatRequestBuilder> {
  /// チャットタイトル
  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'persona')
  CreatePersonaInput get persona;

  CreateChatRequest._();

  factory CreateChatRequest([void updates(CreateChatRequestBuilder b)]) = _$CreateChatRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateChatRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateChatRequest> get serializer => _$CreateChatRequestSerializer();
}

class _$CreateChatRequestSerializer implements PrimitiveSerializer<CreateChatRequest> {
  @override
  final Iterable<Type> types = const [CreateChatRequest, _$CreateChatRequest];

  @override
  final String wireName = r'CreateChatRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateChatRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
      specifiedType: const FullType(CreatePersonaInput),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateChatRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateChatRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
            specifiedType: const FullType(CreatePersonaInput),
          ) as CreatePersonaInput;
          result.persona.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateChatRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateChatRequestBuilder();
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

