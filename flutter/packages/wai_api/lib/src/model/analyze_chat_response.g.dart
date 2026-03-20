// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analyze_chat_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AnalyzeChatResponse extends AnalyzeChatResponse {
  @override
  final BuiltList<Insight> insights;

  factory _$AnalyzeChatResponse(
          [void Function(AnalyzeChatResponseBuilder)? updates]) =>
      (AnalyzeChatResponseBuilder()..update(updates))._build();

  _$AnalyzeChatResponse._({required this.insights}) : super._();
  @override
  AnalyzeChatResponse rebuild(
          void Function(AnalyzeChatResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AnalyzeChatResponseBuilder toBuilder() =>
      AnalyzeChatResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AnalyzeChatResponse && insights == other.insights;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, insights.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AnalyzeChatResponse')
          ..add('insights', insights))
        .toString();
  }
}

class AnalyzeChatResponseBuilder
    implements Builder<AnalyzeChatResponse, AnalyzeChatResponseBuilder> {
  _$AnalyzeChatResponse? _$v;

  ListBuilder<Insight>? _insights;
  ListBuilder<Insight> get insights =>
      _$this._insights ??= ListBuilder<Insight>();
  set insights(ListBuilder<Insight>? insights) => _$this._insights = insights;

  AnalyzeChatResponseBuilder() {
    AnalyzeChatResponse._defaults(this);
  }

  AnalyzeChatResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _insights = $v.insights.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AnalyzeChatResponse other) {
    _$v = other as _$AnalyzeChatResponse;
  }

  @override
  void update(void Function(AnalyzeChatResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AnalyzeChatResponse build() => _build();

  _$AnalyzeChatResponse _build() {
    _$AnalyzeChatResponse _$result;
    try {
      _$result = _$v ??
          _$AnalyzeChatResponse._(
            insights: insights.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'insights';
        insights.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AnalyzeChatResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
