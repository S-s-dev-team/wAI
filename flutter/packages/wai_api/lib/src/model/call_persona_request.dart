//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'call_persona_request.g.dart';

/// CallPersonaRequest
///
/// Properties:
/// * [presetKey] - プリセット先輩のキー
@BuiltValue()
abstract class CallPersonaRequest implements Built<CallPersonaRequest, CallPersonaRequestBuilder> {
  /// プリセット先輩のキー
  @BuiltValueField(wireName: r'preset_key')
  CallPersonaRequestPresetKeyEnum get presetKey;
  // enum presetKeyEnum {  yarigai,  nenshu,  };

  CallPersonaRequest._();

  factory CallPersonaRequest([void updates(CallPersonaRequestBuilder b)]) = _$CallPersonaRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CallPersonaRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CallPersonaRequest> get serializer => _$CallPersonaRequestSerializer();
}

class _$CallPersonaRequestSerializer implements PrimitiveSerializer<CallPersonaRequest> {
  @override
  final Iterable<Type> types = const [CallPersonaRequest, _$CallPersonaRequest];

  @override
  final String wireName = r'CallPersonaRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CallPersonaRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'preset_key';
    yield serializers.serialize(
      object.presetKey,
      specifiedType: const FullType(CallPersonaRequestPresetKeyEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CallPersonaRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CallPersonaRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'preset_key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CallPersonaRequestPresetKeyEnum),
          ) as CallPersonaRequestPresetKeyEnum;
          result.presetKey = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CallPersonaRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CallPersonaRequestBuilder();
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

class CallPersonaRequestPresetKeyEnum extends EnumClass {

  /// プリセット先輩のキー
  @BuiltValueEnumConst(wireName: r'yarigai')
  static const CallPersonaRequestPresetKeyEnum yarigai = _$callPersonaRequestPresetKeyEnum_yarigai;
  /// プリセット先輩のキー
  @BuiltValueEnumConst(wireName: r'nenshu')
  static const CallPersonaRequestPresetKeyEnum nenshu = _$callPersonaRequestPresetKeyEnum_nenshu;

  static Serializer<CallPersonaRequestPresetKeyEnum> get serializer => _$callPersonaRequestPresetKeyEnumSerializer;

  const CallPersonaRequestPresetKeyEnum._(String name): super(name);

  static BuiltSet<CallPersonaRequestPresetKeyEnum> get values => _$callPersonaRequestPresetKeyEnumValues;
  static CallPersonaRequestPresetKeyEnum valueOf(String name) => _$callPersonaRequestPresetKeyEnumValueOf(name);
}

