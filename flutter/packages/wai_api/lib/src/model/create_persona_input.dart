//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_persona_input.g.dart';

/// CreatePersonaInput
///
/// Properties:
/// * [name] - 先輩の名前
/// * [gender] - 性別
/// * [age] - 年齢
/// * [occupation] - 職業
/// * [annualIncome] - 年収（万円）
/// * [systemPrompt] - システムプロンプト
@BuiltValue()
abstract class CreatePersonaInput implements Built<CreatePersonaInput, CreatePersonaInputBuilder> {
  /// 先輩の名前
  @BuiltValueField(wireName: r'name')
  String get name;

  /// 性別
  @BuiltValueField(wireName: r'gender')
  String get gender;

  /// 年齢
  @BuiltValueField(wireName: r'age')
  int get age;

  /// 職業
  @BuiltValueField(wireName: r'occupation')
  String get occupation;

  /// 年収（万円）
  @BuiltValueField(wireName: r'annual_income')
  int get annualIncome;

  /// システムプロンプト
  @BuiltValueField(wireName: r'system_prompt')
  String? get systemPrompt;

  CreatePersonaInput._();

  factory CreatePersonaInput([void updates(CreatePersonaInputBuilder b)]) = _$CreatePersonaInput;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreatePersonaInputBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreatePersonaInput> get serializer => _$CreatePersonaInputSerializer();
}

class _$CreatePersonaInputSerializer implements PrimitiveSerializer<CreatePersonaInput> {
  @override
  final Iterable<Type> types = const [CreatePersonaInput, _$CreatePersonaInput];

  @override
  final String wireName = r'CreatePersonaInput';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreatePersonaInput object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'gender';
    yield serializers.serialize(
      object.gender,
      specifiedType: const FullType(String),
    );
    yield r'age';
    yield serializers.serialize(
      object.age,
      specifiedType: const FullType(int),
    );
    yield r'occupation';
    yield serializers.serialize(
      object.occupation,
      specifiedType: const FullType(String),
    );
    yield r'annual_income';
    yield serializers.serialize(
      object.annualIncome,
      specifiedType: const FullType(int),
    );
    if (object.systemPrompt != null) {
      yield r'system_prompt';
      yield serializers.serialize(
        object.systemPrompt,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreatePersonaInput object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreatePersonaInputBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
        case r'system_prompt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.systemPrompt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreatePersonaInput deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreatePersonaInputBuilder();
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

