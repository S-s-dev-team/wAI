//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'health_response.g.dart';

/// HealthResponse
///
/// Properties:
/// * [status] - ヘルスステータス
/// * [timestamp] - レスポンスの時刻
/// * [version] - API バージョン
@BuiltValue()
abstract class HealthResponse implements Built<HealthResponse, HealthResponseBuilder> {
  /// ヘルスステータス
  @BuiltValueField(wireName: r'status')
  HealthResponseStatusEnum get status;
  // enum statusEnum {  healthy,  unhealthy,  };

  /// レスポンスの時刻
  @BuiltValueField(wireName: r'timestamp')
  DateTime get timestamp;

  /// API バージョン
  @BuiltValueField(wireName: r'version')
  String get version;

  HealthResponse._();

  factory HealthResponse([void updates(HealthResponseBuilder b)]) = _$HealthResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HealthResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HealthResponse> get serializer => _$HealthResponseSerializer();
}

class _$HealthResponseSerializer implements PrimitiveSerializer<HealthResponse> {
  @override
  final Iterable<Type> types = const [HealthResponse, _$HealthResponse];

  @override
  final String wireName = r'HealthResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HealthResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(HealthResponseStatusEnum),
    );
    yield r'timestamp';
    yield serializers.serialize(
      object.timestamp,
      specifiedType: const FullType(DateTime),
    );
    yield r'version';
    yield serializers.serialize(
      object.version,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HealthResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HealthResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HealthResponseStatusEnum),
          ) as HealthResponseStatusEnum;
          result.status = valueDes;
          break;
        case r'timestamp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.timestamp = valueDes;
          break;
        case r'version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.version = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HealthResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HealthResponseBuilder();
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

class HealthResponseStatusEnum extends EnumClass {

  /// ヘルスステータス
  @BuiltValueEnumConst(wireName: r'healthy')
  static const HealthResponseStatusEnum healthy = _$healthResponseStatusEnum_healthy;
  /// ヘルスステータス
  @BuiltValueEnumConst(wireName: r'unhealthy')
  static const HealthResponseStatusEnum unhealthy = _$healthResponseStatusEnum_unhealthy;

  static Serializer<HealthResponseStatusEnum> get serializer => _$healthResponseStatusEnumSerializer;

  const HealthResponseStatusEnum._(String name): super(name);

  static BuiltSet<HealthResponseStatusEnum> get values => _$healthResponseStatusEnumValues;
  static HealthResponseStatusEnum valueOf(String name) => _$healthResponseStatusEnumValueOf(name);
}

