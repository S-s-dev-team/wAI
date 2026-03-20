# wai_api.api.InsightsApi

## Load the API package
```dart
import 'package:wai_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**analyzeChat**](InsightsApi.md#analyzechat) | **POST** /chats/{chatId}/analyze | チャット分析
[**getDashboard**](InsightsApi.md#getdashboard) | **GET** /dashboard | ダッシュボード取得


# **analyzeChat**
> AnalyzeChatResponse analyzeChat(chatId)

チャット分析

会話を分析してインサイトを生成・保存します

### Example
```dart
import 'package:wai_api/api.dart';

final api = WaiApi().getInsightsApi();
final String chatId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.analyzeChat(chatId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling InsightsApi->analyzeChat: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **chatId** | **String**|  | 

### Return type

[**AnalyzeChatResponse**](AnalyzeChatResponse.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getDashboard**
> DashboardResponse getDashboard()

ダッシュボード取得

ユーザーのインサイトをカテゴリ別に返します

### Example
```dart
import 'package:wai_api/api.dart';

final api = WaiApi().getInsightsApi();

try {
    final response = api.getDashboard();
    print(response);
} on DioException catch (e) {
    print('Exception when calling InsightsApi->getDashboard: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**DashboardResponse**](DashboardResponse.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

