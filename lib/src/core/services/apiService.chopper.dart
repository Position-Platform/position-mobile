// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apiService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$ApiService extends ApiService {
  _$ApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = ApiService;

  @override
  Future<Response<dynamic>> getAppSettings() {
    final Uri $url = Uri.parse('${apiUrl}/api/settings');
    final Map<String, String> $headers = {
      'Accept': 'application/json',
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> login(Map<String, dynamic> body) {
    final Uri $url = Uri.parse('${apiUrl}/api/auth/login');
    final Map<String, String> $headers = {
      'Accept': 'application/json',
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> register(Map<String, dynamic> body) {
    final Uri $url = Uri.parse('${apiUrl}/api/auth/register');
    final Map<String, String> $headers = {
      'Accept': 'application/json',
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> registerfacebook(Map<String, dynamic> body) {
    final Uri $url = Uri.parse('${apiUrl}/api/auth/register/facebook');
    final Map<String, String> $headers = {
      'Accept': 'application/json',
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> registergoogle(Map<String, dynamic> body) {
    final Uri $url = Uri.parse('${apiUrl}/api/auth/register/google');
    final Map<String, String> $headers = {
      'Accept': 'application/json',
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> registerapple(Map<String, dynamic> body) {
    final Uri $url = Uri.parse('${apiUrl}/api/auth/register/apple');
    final Map<String, String> $headers = {
      'Accept': 'application/json',
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getuser(String token) {
    final Uri $url = Uri.parse('${apiUrl}/api/user/me');
    final Map<String, String> $headers = {
      'Authorization': token,
      'Accept': 'application/json',
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> forgetPassword(Map<String, dynamic> body) {
    final Uri $url = Uri.parse('${apiUrl}/api/auth/password/forgot');
    final Map<String, String> $headers = {
      'Accept': 'application/json',
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> resetPassword(Map<String, dynamic> body) {
    final Uri $url = Uri.parse('${apiUrl}/api/auth/password/reset');
    final Map<String, String> $headers = {
      'Accept': 'application/json',
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> logout(String token) {
    final Uri $url = Uri.parse('${apiUrl}/api/auth/logout');
    final Map<String, String> $headers = {
      'Authorization': token,
      'Accept': 'application/json',
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getcategories() {
    final Uri $url = Uri.parse('${apiUrl}/api/categories');
    final Map<String, String> $headers = {
      'Accept': 'application/json',
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getcategoriesbyid(int idCategorie) {
    final Uri $url = Uri.parse('${apiUrl}/api/categories/${idCategorie}');
    final Map<String, String> $headers = {
      'Accept': 'application/json',
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> searchcategories(String query) {
    final Uri $url = Uri.parse('${apiUrl}/api/search/categories');
    final Map<String, dynamic> $params = <String, dynamic>{'q': query};
    final Map<String, String> $headers = {
      'Accept': 'application/json',
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updatecategoriebyid(
    String token,
    int idCategorie,
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('${apiUrl}/api/categories/${idCategorie}');
    final Map<String, String> $headers = {
      'Authorization': token,
      'Accept': 'application/json',
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
