# wai_api.api.HealthApi

## Load the API package
```dart
import 'package:wai_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**healthCheck**](HealthApi.md#healthcheck) | **GET** /health | ヘルスチェック


# **healthCheck**
> HealthResponse healthCheck()

ヘルスチェック

アプリケーションのヘルスステータスを確認します

### Example
```dart
import 'package:wai_api/api.dart';

final api = WaiApi().getHealthApi();

try {
    final response = api.healthCheck();
    print(response);
} on DioException catch (e) {
    print('Exception when calling HealthApi->healthCheck: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**HealthResponse**](HealthResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

