// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DashboardResponse extends DashboardResponse {
  @override
  final BuiltList<DashboardCategory> categories;
  @override
  final BuiltList<Insight> recentInsights;
  @override
  final int totalCount;

  factory _$DashboardResponse(
          [void Function(DashboardResponseBuilder)? updates]) =>
      (DashboardResponseBuilder()..update(updates))._build();

  _$DashboardResponse._(
      {required this.categories,
      required this.recentInsights,
      required this.totalCount})
      : super._();
  @override
  DashboardResponse rebuild(void Function(DashboardResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DashboardResponseBuilder toBuilder() =>
      DashboardResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DashboardResponse &&
        categories == other.categories &&
        recentInsights == other.recentInsights &&
        totalCount == other.totalCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, categories.hashCode);
    _$hash = $jc(_$hash, recentInsights.hashCode);
    _$hash = $jc(_$hash, totalCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DashboardResponse')
          ..add('categories', categories)
          ..add('recentInsights', recentInsights)
          ..add('totalCount', totalCount))
        .toString();
  }
}

class DashboardResponseBuilder
    implements Builder<DashboardResponse, DashboardResponseBuilder> {
  _$DashboardResponse? _$v;

  ListBuilder<DashboardCategory>? _categories;
  ListBuilder<DashboardCategory> get categories =>
      _$this._categories ??= ListBuilder<DashboardCategory>();
  set categories(ListBuilder<DashboardCategory>? categories) =>
      _$this._categories = categories;

  ListBuilder<Insight>? _recentInsights;
  ListBuilder<Insight> get recentInsights =>
      _$this._recentInsights ??= ListBuilder<Insight>();
  set recentInsights(ListBuilder<Insight>? recentInsights) =>
      _$this._recentInsights = recentInsights;

  int? _totalCount;
  int? get totalCount => _$this._totalCount;
  set totalCount(int? totalCount) => _$this._totalCount = totalCount;

  DashboardResponseBuilder() {
    DashboardResponse._defaults(this);
  }

  DashboardResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _categories = $v.categories.toBuilder();
      _recentInsights = $v.recentInsights.toBuilder();
      _totalCount = $v.totalCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashboardResponse other) {
    _$v = other as _$DashboardResponse;
  }

  @override
  void update(void Function(DashboardResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DashboardResponse build() => _build();

  _$DashboardResponse _build() {
    _$DashboardResponse _$result;
    try {
      _$result = _$v ??
          _$DashboardResponse._(
            categories: categories.build(),
            recentInsights: recentInsights.build(),
            totalCount: BuiltValueNullFieldError.checkNotNull(
                totalCount, r'DashboardResponse', 'totalCount'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'categories';
        categories.build();
        _$failedField = 'recentInsights';
        recentInsights.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DashboardResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
