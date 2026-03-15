# wai_api.api.ChatsApi

## Load the API package
```dart
import 'package:wai_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createChat**](ChatsApi.md#createchat) | **POST** /chats | チャット作成
[**listChats**](ChatsApi.md#listchats) | **GET** /chats | チャット一覧


# **createChat**
> Chat createChat(createChatRequest)

チャット作成

カスタム先輩の情報と一緒にチャットを作成します

### Example
```dart
import 'package:wai_api/api.dart';

final api = WaiApi().getChatsApi();
final CreateChatRequest createChatRequest = ; // CreateChatRequest | 

try {
    final response = api.createChat(createChatRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ChatsApi->createChat: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createChatRequest** | [**CreateChatRequest**](CreateChatRequest.md)|  | 

### Return type

[**Chat**](Chat.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listChats**
> BuiltList<Chat> listChats()

チャット一覧

ログインユーザーのチャット一覧を取得します

### Example
```dart
import 'package:wai_api/api.dart';

final api = WaiApi().getChatsApi();

try {
    final response = api.listChats();
    print(response);
} on DioException catch (e) {
    print('Exception when calling ChatsApi->listChats: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;Chat&gt;**](Chat.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

