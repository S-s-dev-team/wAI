// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_persona_input.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreatePersonaInput extends CreatePersonaInput {
  @override
  final String name;
  @override
  final String gender;
  @override
  final int age;
  @override
  final String occupation;
  @override
  final int annualIncome;
  @override
  final String? systemPrompt;

  factory _$CreatePersonaInput(
          [void Function(CreatePersonaInputBuilder)? updates]) =>
      (CreatePersonaInputBuilder()..update(updates))._build();

  _$CreatePersonaInput._(
      {required this.name,
      required this.gender,
      required this.age,
      required this.occupation,
      required this.annualIncome,
      this.systemPrompt})
      : super._();
  @override
  CreatePersonaInput rebuild(
          void Function(CreatePersonaInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreatePersonaInputBuilder toBuilder() =>
      CreatePersonaInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreatePersonaInput &&
        name == other.name &&
        gender == other.gender &&
        age == other.age &&
        occupation == other.occupation &&
        annualIncome == other.annualIncome &&
        systemPrompt == other.systemPrompt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, gender.hashCode);
    _$hash = $jc(_$hash, age.hashCode);
    _$hash = $jc(_$hash, occupation.hashCode);
    _$hash = $jc(_$hash, annualIncome.hashCode);
    _$hash = $jc(_$hash, systemPrompt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreatePersonaInput')
          ..add('name', name)
          ..add('gender', gender)
          ..add('age', age)
          ..add('occupation', occupation)
          ..add('annualIncome', annualIncome)
          ..add('systemPrompt', systemPrompt))
        .toString();
  }
}

class CreatePersonaInputBuilder
    implements Builder<CreatePersonaInput, CreatePersonaInputBuilder> {
  _$CreatePersonaInput? _$v;

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

  String? _systemPrompt;
  String? get systemPrompt => _$this._systemPrompt;
  set systemPrompt(String? systemPrompt) => _$this._systemPrompt = systemPrompt;

  CreatePersonaInputBuilder() {
    CreatePersonaInput._defaults(this);
  }

  CreatePersonaInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _gender = $v.gender;
      _age = $v.age;
      _occupation = $v.occupation;
      _annualIncome = $v.annualIncome;
      _systemPrompt = $v.systemPrompt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreatePersonaInput other) {
    _$v = other as _$CreatePersonaInput;
  }

  @override
  void update(void Function(CreatePersonaInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreatePersonaInput build() => _build();

  _$CreatePersonaInput _build() {
    final _$result = _$v ??
        _$CreatePersonaInput._(
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'CreatePersonaInput', 'name'),
          gender: BuiltValueNullFieldError.checkNotNull(
              gender, r'CreatePersonaInput', 'gender'),
          age: BuiltValueNullFieldError.checkNotNull(
              age, r'CreatePersonaInput', 'age'),
          occupation: BuiltValueNullFieldError.checkNotNull(
              occupation, r'CreatePersonaInput', 'occupation'),
          annualIncome: BuiltValueNullFieldError.checkNotNull(
              annualIncome, r'CreatePersonaInput', 'annualIncome'),
          systemPrompt: systemPrompt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
