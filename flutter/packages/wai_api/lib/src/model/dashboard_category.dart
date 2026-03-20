//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:wai_api/src/model/insight.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dashboard_category.g.dart';

/// DashboardCategory
///
/// Properties:
/// * [categoryKey] 
/// * [displayName] 
/// * [insights] 
@BuiltValue()
abstract class DashboardCategory implements Built<DashboardCategory, DashboardCategoryBuilder> {
  @BuiltValueField(wireName: r'category_key')
  String get categoryKey;

  @BuiltValueField(wireName: r'display_name')
  String get displayName;

  @BuiltValueField(wireName: r'insights')
  BuiltList<Insight> get insights;

  DashboardCategory._();

  factory DashboardCategory([void updates(DashboardCategoryBuilder b)]) = _$DashboardCategory;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DashboardCategoryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DashboardCategory> get serializer => _$DashboardCategorySerializer();
}

class _$DashboardCategorySerializer implements PrimitiveSerializer<DashboardCategory> {
  @override
  final Iterable<Type> types = const [DashboardCategory, _$DashboardCategory];

  @override
  final String wireName = r'DashboardCategory';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DashboardCategory object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'category_key';
    yield serializers.serialize(
      object.categoryKey,
      specifiedType: const FullType(String),
    );
    yield r'display_name';
    yield serializers.serialize(
      object.displayName,
      specifiedType: const FullType(String),
    );
    yield r'insights';
    yield serializers.serialize(
      object.insights,
      specifiedType: const FullType(BuiltList, [FullType(Insight)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DashboardCategory object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DashboardCategoryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'category_key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.categoryKey = valueDes;
          break;
        case r'display_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.displayName = valueDes;
          break;
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
  DashboardCategory deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DashboardCategoryBuilder();
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

