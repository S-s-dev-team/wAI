# wai_api.api.AuthApi

## Load the API package
```dart
import 'package:wai_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**login**](AuthApi.md#login) | **POST** /login | ログイン


# **login**
> LoginResponse login()

ログイン

Firebase ID Token を検証し、ユーザーを登録または取得します

### Example
```dart
import 'package:wai_api/api.dart';

final api = WaiApi().getAuthApi();

try {
    final response = api.login();
    print(response);
} on DioException catch (e) {
    print('Exception when calling AuthApi->login: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**LoginResponse**](LoginResponse.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

