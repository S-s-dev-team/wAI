// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insight.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Insight extends Insight {
  @override
  final String id;
  @override
  final String categoryKey;
  @override
  final String categoryDisplayName;
  @override
  final String content;
  @override
  final String? chatId;
  @override
  final DateTime createdAt;

  factory _$Insight([void Function(InsightBuilder)? updates]) =>
      (InsightBuilder()..update(updates))._build();

  _$Insight._(
      {required this.id,
      required this.categoryKey,
      required this.categoryDisplayName,
      required this.content,
      this.chatId,
      required this.createdAt})
      : super._();
  @override
  Insight rebuild(void Function(InsightBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InsightBuilder toBuilder() => InsightBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Insight &&
        id == other.id &&
        categoryKey == other.categoryKey &&
        categoryDisplayName == other.categoryDisplayName &&
        content == other.content &&
        chatId == other.chatId &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, categoryKey.hashCode);
    _$hash = $jc(_$hash, categoryDisplayName.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, chatId.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Insight')
          ..add('id', id)
          ..add('categoryKey', categoryKey)
          ..add('categoryDisplayName', categoryDisplayName)
          ..add('content', content)
          ..add('chatId', chatId)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class InsightBuilder implements Builder<Insight, InsightBuilder> {
  _$Insight? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _categoryKey;
  String? get categoryKey => _$this._categoryKey;
  set categoryKey(String? categoryKey) => _$this._categoryKey = categoryKey;

  String? _categoryDisplayName;
  String? get categoryDisplayName => _$this._categoryDisplayName;
  set categoryDisplayName(String? categoryDisplayName) =>
      _$this._categoryDisplayName = categoryDisplayName;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _chatId;
  String? get chatId => _$this._chatId;
  set chatId(String? chatId) => _$this._chatId = chatId;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  InsightBuilder() {
    Insight._defaults(this);
  }

  InsightBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _categoryKey = $v.categoryKey;
      _categoryDisplayName = $v.categoryDisplayName;
      _content = $v.content;
      _chatId = $v.chatId;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Insight other) {
    _$v = other as _$Insight;
  }

  @override
  void update(void Function(InsightBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Insight build() => _build();

  _$Insight _build() {
    final _$result = _$v ??
        _$Insight._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Insight', 'id'),
          categoryKey: BuiltValueNullFieldError.checkNotNull(
              categoryKey, r'Insight', 'categoryKey'),
          categoryDisplayName: BuiltValueNullFieldError.checkNotNull(
              categoryDisplayName, r'Insight', 'categoryDisplayName'),
          content: BuiltValueNullFieldError.checkNotNull(
              content, r'Insight', 'content'),
          chatId: chatId,
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'Insight', 'createdAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
