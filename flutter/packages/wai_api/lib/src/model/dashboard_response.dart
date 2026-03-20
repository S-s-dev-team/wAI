//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:wai_api/src/model/insight.dart';
import 'package:built_collection/built_collection.dart';
import 'package:wai_api/src/model/dashboard_category.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dashboard_response.g.dart';

/// DashboardResponse
///
/// Properties:
/// * [categories] 
/// * [recentInsights] 
/// * [totalCount] 
@BuiltValue()
abstract class DashboardResponse implements Built<DashboardResponse, DashboardResponseBuilder> {
  @BuiltValueField(wireName: r'categories')
  BuiltList<DashboardCategory> get categories;

  @BuiltValueField(wireName: r'recent_insights')
  BuiltList<Insight> get recentInsights;

  @BuiltValueField(wireName: r'total_count')
  int get totalCount;

  DashboardResponse._();

  factory DashboardResponse([void updates(DashboardResponseBuilder b)]) = _$DashboardResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DashboardResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DashboardResponse> get serializer => _$DashboardResponseSerializer();
}

class _$DashboardResponseSerializer implements PrimitiveSerializer<DashboardResponse> {
  @override
  final Iterable<Type> types = const [DashboardResponse, _$DashboardResponse];

  @override
  final String wireName = r'DashboardResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DashboardResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'categories';
    yield serializers.serialize(
      object.categories,
      specifiedType: const FullType(BuiltList, [FullType(DashboardCategory)]),
    );
    yield r'recent_insights';
    yield serializers.serialize(
      object.recentInsights,
      specifiedType: const FullType(BuiltList, [FullType(Insight)]),
    );
    yield r'total_count';
    yield serializers.serialize(
      object.totalCount,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DashboardResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DashboardResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'categories':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(DashboardCategory)]),
          ) as BuiltList<DashboardCategory>;
          result.categories.replace(valueDes);
          break;
        case r'recent_insights':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Insight)]),
          ) as BuiltList<Insight>;
          result.recentInsights.replace(valueDes);
          break;
        case r'total_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DashboardResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DashboardResponseBuilder();
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

