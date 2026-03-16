//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'persona.g.dart';

/// Persona
///
/// Properties:
/// * [id] 
/// * [personaType] 
/// * [presetKeyId] - プリセットキー（preset の場合のみ）
/// * [name] 
/// * [gender] 
/// * [age] 
/// * [occupation] 
/// * [annualIncome] - 年収（万円）
@BuiltValue()
abstract class Persona implements Built<Persona, PersonaBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'persona_type')
  PersonaPersonaTypeEnum get personaType;
  // enum personaTypeEnum {  custom,  preset,  };

  /// プリセットキー（preset の場合のみ）
  @BuiltValueField(wireName: r'preset_key_id')
  String? get presetKeyId;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'gender')
  String? get gender;

  @BuiltValueField(wireName: r'age')
  int? get age;

  @BuiltValueField(wireName: r'occupation')
  String? get occupation;

  /// 年収（万円）
  @BuiltValueField(wireName: r'annual_income')
  int? get annualIncome;

  Persona._();

  factory Persona([void updates(PersonaBuilder b)]) = _$Persona;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PersonaBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Persona> get serializer => _$PersonaSerializer();
}

class _$PersonaSerializer implements PrimitiveSerializer<Persona> {
  @override
  final Iterable<Type> types = const [Persona, _$Persona];

  @override
  final String wireName = r'Persona';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Persona object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'persona_type';
    yield serializers.serialize(
      object.personaType,
      specifiedType: const FullType(PersonaPersonaTypeEnum),
    );
    if (object.presetKeyId != null) {
      yield r'preset_key_id';
      yield serializers.serialize(
        object.presetKeyId,
        specifiedType: const FullType(String),
      );
    }
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    if (object.gender != null) {
      yield r'gender';
      yield serializers.serialize(
        object.gender,
        specifiedType: const FullType(String),
      );
    }
    if (object.age != null) {
      yield r'age';
      yield serializers.serialize(
        object.age,
        specifiedType: const FullType(int),
      );
    }
    if (object.occupation != null) {
      yield r'occupation';
      yield serializers.serialize(
        object.occupation,
        specifiedType: const FullType(String),
      );
    }
    if (object.annualIncome != null) {
      yield r'annual_income';
      yield serializers.serialize(
        object.annualIncome,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Persona object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PersonaBuilder result,
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
        case r'persona_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PersonaPersonaTypeEnum),
          ) as PersonaPersonaTypeEnum;
          result.personaType = valueDes;
          break;
        case r'preset_key_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.presetKeyId = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'gender':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.gender = valueDes;
          break;
        case r'age':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.age = valueDes;
          break;
        case r'occupation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.occupation = valueDes;
          break;
        case r'annual_income':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.annualIncome = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Persona deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PersonaBuilder();
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

class PersonaPersonaTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'custom')
  static const PersonaPersonaTypeEnum custom = _$personaPersonaTypeEnum_custom;
  @BuiltValueEnumConst(wireName: r'preset')
  static const PersonaPersonaTypeEnum preset = _$personaPersonaTypeEnum_preset;

  static Serializer<PersonaPersonaTypeEnum> get serializer => _$personaPersonaTypeEnumSerializer;

  const PersonaPersonaTypeEnum._(String name): super(name);

  static BuiltSet<PersonaPersonaTypeEnum> get values => _$personaPersonaTypeEnumValues;
  static PersonaPersonaTypeEnum valueOf(String name) => _$personaPersonaTypeEnumValueOf(name);
}

