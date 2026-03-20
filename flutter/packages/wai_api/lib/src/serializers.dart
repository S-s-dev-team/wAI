//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:wai_api/src/date_serializer.dart';
import 'package:wai_api/src/model/date.dart';

import 'package:wai_api/src/model/analyze_chat_response.dart';
import 'package:wai_api/src/model/call_persona_request.dart';
import 'package:wai_api/src/model/chat.dart';
import 'package:wai_api/src/model/create_chat_request.dart';
import 'package:wai_api/src/model/create_persona_input.dart';
import 'package:wai_api/src/model/dashboard_category.dart';
import 'package:wai_api/src/model/dashboard_response.dart';
import 'package:wai_api/src/model/error_response.dart';
import 'package:wai_api/src/model/health_response.dart';
import 'package:wai_api/src/model/insight.dart';
import 'package:wai_api/src/model/login_response.dart';
import 'package:wai_api/src/model/message.dart';
import 'package:wai_api/src/model/message_list.dart';
import 'package:wai_api/src/model/persona.dart';
import 'package:wai_api/src/model/send_message_request.dart';
import 'package:wai_api/src/model/send_message_response.dart';

part 'serializers.g.dart';

@SerializersFor([
  AnalyzeChatResponse,
  CallPersonaRequest,
  Chat,
  CreateChatRequest,
  CreatePersonaInput,
  DashboardCategory,
  DashboardResponse,
  ErrorResponse,
  HealthResponse,
  Insight,
  LoginResponse,
  Message,
  MessageList,
  Persona,
  SendMessageRequest,
  SendMessageResponse,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Chat)]),
        () => ListBuilder<Chat>(),
      )
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer())
    ).build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
