// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_category.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DashboardCategory extends DashboardCategory {
  @override
  final String categoryKey;
  @override
  final String displayName;
  @override
  final BuiltList<Insight> insights;

  factory _$DashboardCategory(
          [void Function(DashboardCategoryBuilder)? updates]) =>
      (DashboardCategoryBuilder()..update(updates))._build();

  _$DashboardCategory._(
      {required this.categoryKey,
      required this.displayName,
      required this.insights})
      : super._();
  @override
  DashboardCategory rebuild(void Function(DashboardCategoryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DashboardCategoryBuilder toBuilder() =>
      DashboardCategoryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DashboardCategory &&
        categoryKey == other.categoryKey &&
        displayName == other.displayName &&
        insights == other.insights;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, categoryKey.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, insights.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DashboardCategory')
          ..add('categoryKey', categoryKey)
          ..add('displayName', displayName)
          ..add('insights', insights))
        .toString();
  }
}

class DashboardCategoryBuilder
    implements Builder<DashboardCategory, DashboardCategoryBuilder> {
  _$DashboardCategory? _$v;

  String? _categoryKey;
  String? get categoryKey => _$this._categoryKey;
  set categoryKey(String? categoryKey) => _$this._categoryKey = categoryKey;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  ListBuilder<Insight>? _insights;
  ListBuilder<Insight> get insights =>
      _$this._insights ??= ListBuilder<Insight>();
  set insights(ListBuilder<Insight>? insights) => _$this._insights = insights;

  DashboardCategoryBuilder() {
    DashboardCategory._defaults(this);
  }

  DashboardCategoryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _categoryKey = $v.categoryKey;
      _displayName = $v.displayName;
      _insights = $v.insights.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashboardCategory other) {
    _$v = other as _$DashboardCategory;
  }

  @override
  void update(void Function(DashboardCategoryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DashboardCategory build() => _build();

  _$DashboardCategory _build() {
    _$DashboardCategory _$result;
    try {
      _$result = _$v ??
          _$DashboardCategory._(
            categoryKey: BuiltValueNullFieldError.checkNotNull(
                categoryKey, r'DashboardCategory', 'categoryKey'),
            displayName: BuiltValueNullFieldError.checkNotNull(
                displayName, r'DashboardCategory', 'displayName'),
            insights: insights.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'insights';
        insights.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DashboardCategory', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
