# wai_api.api.MessagesApi

## Load the API package
```dart
import 'package:wai_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**listMessages**](MessagesApi.md#listmessages) | **GET** /chats/{chatId}/messages | メッセージ一覧
[**sendMessage**](MessagesApi.md#sendmessage) | **POST** /chats/{chatId}/messages | メッセージ送信


# **listMessages**
> MessageList listMessages(chatId, limit, before)

メッセージ一覧

チャット内のメッセージ一覧を取得します

### Example
```dart
import 'package:wai_api/api.dart';

final api = WaiApi().getMessagesApi();
final String chatId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final int limit = 56; // int | 取得件数（デフォルト 50）
final String before = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | このIDより前のメッセージを取得（カーソルページネーション）

try {
    final response = api.listMessages(chatId, limit, before);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MessagesApi->listMessages: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **chatId** | **String**|  | 
 **limit** | **int**| 取得件数（デフォルト 50） | [optional] [default to 50]
 **before** | **String**| このIDより前のメッセージを取得（カーソルページネーション） | [optional] 

### Return type

[**MessageList**](MessageList.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sendMessage**
> SendMessageResponse sendMessage(chatId, sendMessageRequest)

メッセージ送信

ユーザーのメッセージを送信し、AI先輩からの応答を返します

### Example
```dart
import 'package:wai_api/api.dart';

final api = WaiApi().getMessagesApi();
final String chatId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final SendMessageRequest sendMessageRequest = ; // SendMessageRequest | 

try {
    final response = api.sendMessage(chatId, sendMessageRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MessagesApi->sendMessage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **chatId** | **String**|  | 
 **sendMessageRequest** | [**SendMessageRequest**](SendMessageRequest.md)|  | 

### Return type

[**SendMessageResponse**](SendMessageResponse.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

