// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_list.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MessageList extends MessageList {
  @override
  final BuiltList<Message> messages;
  @override
  final bool hasMore;

  factory _$MessageList([void Function(MessageListBuilder)? updates]) =>
      (MessageListBuilder()..update(updates))._build();

  _$MessageList._({required this.messages, required this.hasMore}) : super._();
  @override
  MessageList rebuild(void Function(MessageListBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MessageListBuilder toBuilder() => MessageListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MessageList &&
        messages == other.messages &&
        hasMore == other.hasMore;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, messages.hashCode);
    _$hash = $jc(_$hash, hasMore.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MessageList')
          ..add('messages', messages)
          ..add('hasMore', hasMore))
        .toString();
  }
}

class MessageListBuilder implements Builder<MessageList, MessageListBuilder> {
  _$MessageList? _$v;

  ListBuilder<Message>? _messages;
  ListBuilder<Message> get messages =>
      _$this._messages ??= ListBuilder<Message>();
  set messages(ListBuilder<Message>? messages) => _$this._messages = messages;

  bool? _hasMore;
  bool? get hasMore => _$this._hasMore;
  set hasMore(bool? hasMore) => _$this._hasMore = hasMore;

  MessageListBuilder() {
    MessageList._defaults(this);
  }

  MessageListBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _messages = $v.messages.toBuilder();
      _hasMore = $v.hasMore;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MessageList other) {
    _$v = other as _$MessageList;
  }

  @override
  void update(void Function(MessageListBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MessageList build() => _build();

  _$MessageList _build() {
    _$MessageList _$result;
    try {
      _$result = _$v ??
          _$MessageList._(
            messages: messages.build(),
            hasMore: BuiltValueNullFieldError.checkNotNull(
                hasMore, r'MessageList', 'hasMore'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'messages';
        messages.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MessageList', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
