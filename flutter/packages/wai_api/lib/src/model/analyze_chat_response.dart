//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:wai_api/src/model/insight.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'analyze_chat_response.g.dart';

/// AnalyzeChatResponse
///
/// Properties:
/// * [insights] 
@BuiltValue()
abstract class AnalyzeChatResponse implements Built<AnalyzeChatResponse, AnalyzeChatResponseBuilder> {
  @BuiltValueField(wireName: r'insights')
  BuiltList<Insight> get insights;

  AnalyzeChatResponse._();

  factory AnalyzeChatResponse([void updates(AnalyzeChatResponseBuilder b)]) = _$AnalyzeChatResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AnalyzeChatResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AnalyzeChatResponse> get serializer => _$AnalyzeChatResponseSerializer();
}

class _$AnalyzeChatResponseSerializer implements PrimitiveSerializer<AnalyzeChatResponse> {
  @override
  final Iterable<Type> types = const [AnalyzeChatResponse, _$AnalyzeChatResponse];

  @override
  final String wireName = r'AnalyzeChatResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AnalyzeChatResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'insights';
    yield serializers.serialize(
      object.insights,
      specifiedType: const FullType(BuiltList, [FullType(Insight)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AnalyzeChatResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AnalyzeChatResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'insights':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Insight)]),
          ) as BuiltList<Insight>;
          result.insights.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AnalyzeChatResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AnalyzeChatResponseBuilder();
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

