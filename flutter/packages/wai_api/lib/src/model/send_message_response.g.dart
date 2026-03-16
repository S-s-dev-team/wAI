// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_message_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SendMessageResponse extends SendMessageResponse {
  @override
  final Message userMessage;
  @override
  final BuiltList<Message> replies;

  factory _$SendMessageResponse(
          [void Function(SendMessageResponseBuilder)? updates]) =>
      (SendMessageResponseBuilder()..update(updates))._build();

  _$SendMessageResponse._({required this.userMessage, required this.replies})
      : super._();
  @override
  SendMessageResponse rebuild(
          void Function(SendMessageResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SendMessageResponseBuilder toBuilder() =>
      SendMessageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SendMessageResponse &&
        userMessage == other.userMessage &&
        replies == other.replies;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userMessage.hashCode);
    _$hash = $jc(_$hash, replies.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SendMessageResponse')
          ..add('userMessage', userMessage)
          ..add('replies', replies))
        .toString();
  }
}

class SendMessageResponseBuilder
    implements Builder<SendMessageResponse, SendMessageResponseBuilder> {
  _$SendMessageResponse? _$v;

  MessageBuilder? _userMessage;
  MessageBuilder get userMessage => _$this._userMessage ??= MessageBuilder();
  set userMessage(MessageBuilder? userMessage) =>
      _$this._userMessage = userMessage;

  ListBuilder<Message>? _replies;
  ListBuilder<Message> get replies =>
      _$this._replies ??= ListBuilder<Message>();
  set replies(ListBuilder<Message>? replies) => _$this._replies = replies;

  SendMessageResponseBuilder() {
    SendMessageResponse._defaults(this);
  }

  SendMessageResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userMessage = $v.userMessage.toBuilder();
      _replies = $v.replies.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SendMessageResponse other) {
    _$v = other as _$SendMessageResponse;
  }

  @override
  void update(void Function(SendMessageResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SendMessageResponse build() => _build();

  _$SendMessageResponse _build() {
    _$SendMessageResponse _$result;
    try {
      _$result = _$v ??
          _$SendMessageResponse._(
            userMessage: userMessage.build(),
            replies: replies.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'userMessage';
        userMessage.build();
        _$failedField = 'replies';
        replies.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'SendMessageResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
