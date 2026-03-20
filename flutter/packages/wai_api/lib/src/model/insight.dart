//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'insight.g.dart';

/// Insight
///
/// Properties:
/// * [id] 
/// * [categoryKey] 
/// * [categoryDisplayName] 
/// * [content] 
/// * [chatId] 
/// * [createdAt] 
@BuiltValue()
abstract class Insight implements Built<Insight, InsightBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'category_key')
  String get categoryKey;

  @BuiltValueField(wireName: r'category_display_name')
  String get categoryDisplayName;

  @BuiltValueField(wireName: r'content')
  String get content;

  @BuiltValueField(wireName: r'chat_id')
  String? get chatId;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  Insight._();

  factory Insight([void updates(InsightBuilder b)]) = _$Insight;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InsightBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Insight> get serializer => _$InsightSerializer();
}

class _$InsightSerializer implements PrimitiveSerializer<Insight> {
  @override
  final Iterable<Type> types = const [Insight, _$Insight];

  @override
  final String wireName = r'Insight';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Insight object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'category_key';
    yield serializers.serialize(
      object.categoryKey,
      specifiedType: const FullType(String),
    );
    yield r'category_display_name';
    yield serializers.serialize(
      object.categoryDisplayName,
      specifiedType: const FullType(String),
    );
    yield r'content';
    yield serializers.serialize(
      object.content,
      specifiedType: const FullType(String),
    );
    if (object.chatId != null) {
      yield r'chat_id';
      yield serializers.serialize(
        object.chatId,
        specifiedType: const FullType(String),
      );
    }
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Insight object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required InsightBuilder result,
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
        case r'category_key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.categoryKey = valueDes;
          break;
        case r'category_display_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.categoryDisplayName = valueDes;
          break;
        case r'content':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.content = valueDes;
          break;
        case r'chat_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.chatId = valueDes;
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
  Insight deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InsightBuilder();
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

