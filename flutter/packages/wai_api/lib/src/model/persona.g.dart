// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persona.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PersonaPersonaTypeEnum _$personaPersonaTypeEnum_custom =
    const PersonaPersonaTypeEnum._('custom');
const PersonaPersonaTypeEnum _$personaPersonaTypeEnum_preset =
    const PersonaPersonaTypeEnum._('preset');

PersonaPersonaTypeEnum _$personaPersonaTypeEnumValueOf(String name) {
  switch (name) {
    case 'custom':
      return _$personaPersonaTypeEnum_custom;
    case 'preset':
      return _$personaPersonaTypeEnum_preset;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PersonaPersonaTypeEnum> _$personaPersonaTypeEnumValues =
    BuiltSet<PersonaPersonaTypeEnum>(const <PersonaPersonaTypeEnum>[
  _$personaPersonaTypeEnum_custom,
  _$personaPersonaTypeEnum_preset,
]);

Serializer<PersonaPersonaTypeEnum> _$personaPersonaTypeEnumSerializer =
    _$PersonaPersonaTypeEnumSerializer();

class _$PersonaPersonaTypeEnumSerializer
    implements PrimitiveSerializer<PersonaPersonaTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'custom': 'custom',
    'preset': 'preset',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'custom': 'custom',
    'preset': 'preset',
  };

  @override
  final Iterable<Type> types = const <Type>[PersonaPersonaTypeEnum];
  @override
  final String wireName = 'PersonaPersonaTypeEnum';

  @override
  Object serialize(Serializers serializers, PersonaPersonaTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PersonaPersonaTypeEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PersonaPersonaTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Persona extends Persona {
  @override
  final String id;
  @override
  final PersonaPersonaTypeEnum personaType;
  @override
  final String? presetKeyId;
  @override
  final String name;
  @override
  final String? gender;
  @override
  final int? age;
  @override
  final String? occupation;
  @override
  final int? annualIncome;

  factory _$Persona([void Function(PersonaBuilder)? updates]) =>
      (PersonaBuilder()..update(updates))._build();

  _$Persona._(
      {required this.id,
      required this.personaType,
      this.presetKeyId,
      required this.name,
      this.gender,
      this.age,
      this.occupation,
      this.annualIncome})
      : super._();
  @override
  Persona rebuild(void Function(PersonaBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PersonaBuilder toBuilder() => PersonaBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Persona &&
        id == other.id &&
        personaType == other.personaType &&
        presetKeyId == other.presetKeyId &&
        name == other.name &&
        gender == other.gender &&
        age == other.age &&
        occupation == other.occupation &&
        annualIncome == other.annualIncome;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, personaType.hashCode);
    _$hash = $jc(_$hash, presetKeyId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, gender.hashCode);
    _$hash = $jc(_$hash, age.hashCode);
    _$hash = $jc(_$hash, occupation.hashCode);
    _$hash = $jc(_$hash, annualIncome.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Persona')
          ..add('id', id)
          ..add('personaType', personaType)
          ..add('presetKeyId', presetKeyId)
          ..add('name', name)
          ..add('gender', gender)
          ..add('age', age)
          ..add('occupation', occupation)
          ..add('annualIncome', annualIncome))
        .toString();
  }
}

class PersonaBuilder implements Builder<Persona, PersonaBuilder> {
  _$Persona? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  PersonaPersonaTypeEnum? _personaType;
  PersonaPersonaTypeEnum? get personaType => _$this._personaType;
  set personaType(PersonaPersonaTypeEnum? personaType) =>
      _$this._personaType = personaType;

  String? _presetKeyId;
  String? get presetKeyId => _$this._presetKeyId;
  set presetKeyId(String? presetKeyId) => _$this._presetKeyId = presetKeyId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _gender;
  String? get gender => _$this._gender;
  set gender(String? gender) => _$this._gender = gender;

  int? _age;
  int? get age => _$this._age;
  set age(int? age) => _$this._age = age;

  String? _occupation;
  String? get occupation => _$this._occupation;
  set occupation(String? occupation) => _$this._occupation = occupation;

  int? _annualIncome;
  int? get annualIncome => _$this._annualIncome;
  set annualIncome(int? annualIncome) => _$this._annualIncome = annualIncome;

  PersonaBuilder() {
    Persona._defaults(this);
  }

  PersonaBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _personaType = $v.personaType;
      _presetKeyId = $v.presetKeyId;
      _name = $v.name;
      _gender = $v.gender;
      _age = $v.age;
      _occupation = $v.occupation;
      _annualIncome = $v.annualIncome;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Persona other) {
    _$v = other as _$Persona;
  }

  @override
  void update(void Function(PersonaBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Persona build() => _build();

  _$Persona _build() {
    final _$result = _$v ??
        _$Persona._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Persona', 'id'),
          personaType: BuiltValueNullFieldError.checkNotNull(
              personaType, r'Persona', 'personaType'),
          presetKeyId: presetKeyId,
          name: BuiltValueNullFieldError.checkNotNull(name, r'Persona', 'name'),
          gender: gender,
          age: age,
          occupation: occupation,
          annualIncome: annualIncome,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
