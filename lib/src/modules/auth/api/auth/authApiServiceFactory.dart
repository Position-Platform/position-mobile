// ignore_for_file: file_names, avoid_print

import 'package:chopper/chopper.dart';
import 'package:position/src/core/services/apiService.dart';
import 'package:position/src/core/services/log.service.dart';
import 'package:position/src/modules/auth/api/auth/authApiService.dart';

class AuthApiServiceFactory implements AuthApiService {
  final ApiService? apiService;
  final LogService _logger = LogService();

  AuthApiServiceFactory(this.apiService);

  @override
  Future<Response> forgotpassword(String email) async {
    Response response;

    try {
      // Log the email being used for password reset
      _logger.info('Forgot password request for email: $email');
      response = await apiService!.forgetPassword({"email": email});
      // Log the response from the API
      _logger.info('Forgot password response: ${response.body}');
    } catch (e) {
      // Log the error
      _logger.error('Caught error during forgot password: ${e.toString()}');
      print('Caught ${e.toString()}');
      rethrow;
    }
    return response;
  }

  @override
  Future<Response> getuser(String token) async {
    Response response;
    try {
      // Log the token being used to get user information
      _logger.info('Get user request with token: $token');
      response = await apiService!.getuser(token);
      // Log the response from the API
      _logger.info('Get user response: ${response.body}');
    } catch (e) {
      // Log the error
      _logger.error('Caught error during get user: ${e.toString()}');
      print('Caught ${e.toString()}');
      rethrow;
    }
    return response;
  }

  @override
  Future<Response> login(String identifiant, String password) async {
    Response response;
    try {
      // Log the login attempt with the identifier and password
      _logger.info(
          'Login attempt with identifier: $identifiant and password: $password');
      if (identifiant.contains('@')) {
        response = await apiService!
            .login({"email": identifiant, "password": password});
      } else {
        response = await apiService!
            .login({"phone": identifiant, "password": password});
      }
      // Log the response from the API
      _logger.info('Login response: ${response.body}');
    } catch (e) {
      // Log the error
      _logger.error('Caught error during login: ${e.toString()}');
      print('Caught ${e.toString()}');
      rethrow;
    }
    return response;
  }

  @override
  Future<Response> logout(String token) async {
    Response response;
    try {
      // Log the logout attempt with the token
      _logger.info('Logout attempt with token: $token');
      response = await apiService!.logout(token);
      // Log the response from the API
      _logger.info('Logout response: ${response.body}');
    } catch (e) {
      // Log the error
      _logger.error('Caught error during logout: ${e.toString()}');
      print('Caught ${e.toString()}');
      rethrow;
    }
    return response;
  }

  @override
  Future<Response> register(
      String name, String email, String phone, String password) async {
    Response response;
    try {
      // Log the registration attempt with the provided details
      _logger.info(
          'Registration attempt with name: $name, email: $email, phone: $phone');
      response = await apiService!.register(
          {"name": name, "email": email, "phone": phone, "password": password});
      // Log the response from the API
      _logger.info('Registration response: ${response.body}');
    } catch (e) {
      // Log the error
      _logger.error('Caught error during registration: ${e.toString()}');
      print('Caught ${e.toString()}');
      rethrow;
    }
    return response;
  }

  @override
  Future<Response> resetpassword(
      String email, String password, String resettoken) async {
    Response response;
    try {
      // Log the password reset attempt with the provided details
      _logger.info(
          'Password reset attempt for email: $email with token: $resettoken');
      response = await apiService!.resetPassword({
        "email": email,
        "password": password,
        "password_confirmation": password,
        "token": resettoken
      });
      // Log the response from the API
      _logger.info('Password reset response: ${response.body}');
    } catch (e) {
      // Log the error
      _logger.error('Caught error during password reset: ${e.toString()}');
      print('Caught ${e.toString()}');
      rethrow;
    }
    return response;
  }

  @override
  Future<Response> registerfacebook(String token) async {
    Response response;
    try {
      // Log the Facebook registration attempt with the token
      _logger.info('Facebook registration attempt with token: $token');
      response = await apiService!.registerfacebook({
        "token": token,
      });
      // Log the response from the API
      _logger.info('Facebook registration response: ${response.body}');
    } catch (e) {
      // Log the error
      _logger
          .error('Caught error during Facebook registration: ${e.toString()}');
      print('Caught ${e.toString()}');
      rethrow;
    }
    return response;
  }

  @override
  Future<Response> registergoogle(String token) async {
    Response response;
    try {
      // Log the Google registration attempt with the token
      _logger.info('Google registration attempt with token: $token');
      response = await apiService!.registergoogle({
        "token": token,
      });
      // Log the response from the API
      _logger.info('Google registration response: ${response.body}');
    } catch (e) {
      // Log the error
      _logger.error('Caught error during Google registration: ${e.toString()}');
      print('Caught ${e.toString()}');
      rethrow;
    }
    return response;
  }

  @override
  Future<Response> registerapple(String token) async {
    Response response;
    try {
      // Log the Apple registration attempt with the token
      _logger.info('Apple registration attempt with token: $token');
      response = await apiService!.registerapple({
        "token": token,
      });
      // Log the response from the API
      _logger.info('Apple registration response: ${response.body}');
    } catch (e) {
      // Log the error
      _logger.error('Caught error during Apple registration: ${e.toString()}');
      print('Caught ${e.toString()}');
      rethrow;
    }
    return response;
  }
}
