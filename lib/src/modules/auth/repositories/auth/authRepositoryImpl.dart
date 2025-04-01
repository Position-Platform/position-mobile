// ignore_for_file: file_names

import 'package:chopper/chopper.dart';
import 'package:drift/drift.dart';
import 'package:position/src/core/database/db.dart';
import 'package:position/src/core/helpers/network.dart';
import 'package:position/src/core/helpers/sharedpreferences.dart';
import 'package:position/src/core/services/log.service.dart';
import 'package:position/src/modules/auth/api/auth/authApiService.dart';
import 'package:position/src/modules/auth/db/user/user.dao.dart';
import 'package:position/src/modules/auth/models/user_model/user.dart';
import 'package:position/src/modules/auth/models/user_model/user_model.dart';
import 'package:position/src/modules/auth/models/auth_model/auth_model.dart';
import 'package:position/src/core/utils/result.dart';
import 'package:position/src/modules/app/models/api_model/api_model.dart';
import 'package:position/src/modules/auth/repositories/auth/authRepository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final NetworkInfoHelper? networkInfoHelper;
  final AuthApiService? authApiService;
  final SharedPreferencesHelper? sharedPreferencesHelper;
  final UserDao? userDao;
  final LogService logger;

  AuthRepositoryImpl(
      {this.networkInfoHelper,
      this.authApiService,
      this.sharedPreferencesHelper,
      this.userDao,
      required this.logger});
  @override
  Future<bool> deletetoken() async {
    bool delete = await sharedPreferencesHelper!.deleteToken();
    logger.info('Token $delete');
    return delete;
  }

  @override
  Future<Result<ApiModel>> forgotpassword(String email) async {
    bool isConnected = await networkInfoHelper!.isConnected();
    if (isConnected) {
      try {
        // Log the email being used for password reset
        logger.info('Forgot password request for email: $email');
        final Response response = await authApiService!.forgotpassword(email);

        // Log the response from the API
        logger.info('Forgot password response: ${response.body}');

        var model = ApiModel.fromJson(response.body);
        // Log the model created from the response
        logger.info('Forgot password model: ${model.toString()}');

        return Result(success: model);
      } catch (e) {
        // Log the error
        logger.error('Caught error during forgot password: ${e.toString()}');
        return Result(error: ServerError());
      }
    } else {
      // Log the no internet error
      logger.error('No internet connection for forgot password request');
      return Result(error: NoInternetError());
    }
  }

  @override
  Future<Result<User>> getuser(String token) async {
    bool isConnected = await networkInfoHelper!.isConnected();
    if (isConnected) {
      try {
        // Log the token being used to get user information
        logger.info('Get user request with token: $token');
        final Response response = await authApiService!.getuser(token);

        // Log the response from the API
        logger.info('Get user response: ${response.body}');

        var model = UserModel.fromJson(response.body);

        // Log the model created from the response
        logger.info('Get user model: ${model.toString()}');

        await userDao!.updateUser(UserTableCompanion(
            id: const Value(1), user: Value(model.data!.user)));

        // Log the user update in the database
        logger.info('User updated in database: ${model.data!.user}');

        return Result(success: model.data!.user);
      } catch (e) {
        // Log the error
        logger.error('Caught error during get user: ${e.toString()}');
        return Result(error: ServerError());
      }
    } else {
      // Log the no internet error
      logger.error('No internet connection for get user request');
      return Result(error: NoInternetError());
    }
  }

  @override
  Future<bool> hastoken() async {
    bool hasToken;
    String? token = await sharedPreferencesHelper!.getToken();
    if (token != null) {
      hasToken = true;
    } else {
      hasToken = false;
    }

    return hasToken;
  }

  @override
  Future<Result<AuthModel>> login(
    String indentifiant,
    String password,
  ) async {
    bool isConnected = await networkInfoHelper!.isConnected();
    if (isConnected) {
      try {
        // Log the login attempt with the identifier and password
        logger.info(
            'Login attempt with identifier: $indentifiant and password: $password');
        final Response response =
            await authApiService!.login(indentifiant, password);

        // Log the response from the API
        logger.info('Login response: ${response.body}');

        var model = AuthModel.fromJson(response.body);
        // Log the model created from the response
        logger.info('Login model: ${model.toString()}');

        try {
          await userDao!.addUser(UserTableCompanion(
              id: const Value(1), user: Value(model.data!.user)));
          // Log the user added to the database
          logger.info('User added to database: ${model.data!.user}');
        } catch (e) {
          // Log the error while adding user to the database
          logger.error('Error adding user to database: ${e.toString()}');
          return Result(error: DbInsertError());
        }
        return Result(success: model);
      } catch (e) {
        // Log the error during login
        logger.error('Caught error during login: ${e.toString()}');
        return Result(error: ServerError());
      }
    } else {
      // Log the no internet error
      logger.error('No internet connection for login request');
      return Result(error: NoInternetError());
    }
  }

  @override
  Future<Result<ApiModel>> logout(String token) async {
    bool isConnected = await networkInfoHelper!.isConnected();
    if (isConnected) {
      try {
        // Log the logout attempt with the token
        logger.info('Logout attempt with token: $token');
        final Response response = await authApiService!.logout(token);

        // Log the response from the API
        logger.info('Logout response: ${response.body}');

        var model = ApiModel.fromJson(response.body);
        // Log the model created from the response
        logger.info('Logout model: ${model.toString()}');

        try {
          await userDao!.deleteUser();
          // Log the user deleted from the database
          logger.info('User deleted from database');
        } catch (e) {
          // Log the error while deleting user from the database
          logger.error('Error deleting user from database: ${e.toString()}');
          return Result(error: DbDeleteError());
        }
        return Result(success: model);
      } catch (e) {
        // Log the error during logout
        logger.error('Caught error during logout: ${e.toString()}');
        return Result(error: ServerError());
      }
    } else {
      // Log the no internet error
      logger.error('No internet connection for logout request');
      return Result(error: NoInternetError());
    }
  }

  @override
  Future<Result<AuthModel>> register(
      String name, String email, String phone, String password) async {
    bool isConnected = await networkInfoHelper!.isConnected();
    if (isConnected) {
      try {
        // Log the registration attempt with the name, email, phone, and password
        logger.info(
            'Register attempt with name: $name, email: $email, phone: $phone, password: $password');
        final Response response =
            await authApiService!.register(name, email, phone, password);

        // Log the response from the API
        logger.info('Register response: ${response.body}');

        var model = AuthModel.fromJson(response.body);
        // Log the model created from the response
        logger.info('Register model: ${model.toString()}');

        return Result(success: model);
      } catch (e) {
        // Log the error during registration
        logger.error('Caught error during registration: ${e.toString()}');
        return Result(error: ServerError());
      }
    } else {
      // Log the no internet error
      logger.error('No internet connection for registration request');
      return Result(error: NoInternetError());
    }
  }

  @override
  Future<Result<ApiModel>> resetpassword(
      String email, String password, String resettoken) async {
    bool isConnected = await networkInfoHelper!.isConnected();
    if (isConnected) {
      try {
        // Log the password reset attempt with the email, password, and reset token
        logger.info(
            'Password reset attempt with email: $email, password: $password, reset token: $resettoken');
        final Response response =
            await authApiService!.resetpassword(email, password, resettoken);

        // Log the response from the API
        logger.info('Password reset response: ${response.body}');

        var model = ApiModel.fromJson(response.body);

        // Log the model created from the response
        logger.info('Password reset model: ${model.toString()}');

        return Result(success: model);
      } catch (e) {
        // Log the error during password reset
        logger.error('Caught error during password reset: ${e.toString()}');
        return Result(error: ServerError());
      }
    } else {
      // Log the no internet error
      logger.error('No internet connection for password reset request');
      return Result(error: NoInternetError());
    }
  }

  @override
  Future<bool> savetoken(String token) async {
    bool saveT = await sharedPreferencesHelper!.setToken(token);
    return saveT;
  }

  @override
  Future<Result<AuthModel>> registerfacebook(String token) async {
    bool isConnected = await networkInfoHelper!.isConnected();
    if (isConnected) {
      try {
        // Log the Facebook registration attempt with the token
        logger.info('Facebook registration attempt with token: $token');
        final Response response = await authApiService!.registerfacebook(token);

        // Log the response from the API
        logger.info('Facebook registration response: ${response.body}');

        var model = AuthModel.fromJson(response.body);
        // Log the model created from the response
        logger.info('Facebook registration model: ${model.toString()}');

        await userDao!.addUser(UserTableCompanion(
            id: const Value(1), user: Value(model.data!.user)));
        // Log the user added to the database
        logger.info('User added to database: ${model.data!.user}');

        return Result(success: model);
      } catch (e) {
        // Log the error during Facebook registration
        logger.error(
            'Caught error during Facebook registration: ${e.toString()}');
        return Result(error: ServerError());
      }
    } else {
      // Log the no internet error
      logger.error('No internet connection for Facebook registration request');
      return Result(error: NoInternetError());
    }
  }

  @override
  Future<Result<AuthModel>> registergoogle(String token) async {
    bool isConnected = await networkInfoHelper!.isConnected();
    if (isConnected) {
      try {
        // Log the Google registration attempt with the token
        logger.info('Google registration attempt with token: $token');
        final Response response = await authApiService!.registergoogle(token);

        // Log the response from the API
        logger.info('Google registration response: ${response.body}');

        var model = AuthModel.fromJson(response.body);
        // Log the model created from the response
        logger.info('Google registration model: ${model.toString()}');

        await userDao!.addUser(UserTableCompanion(
            id: const Value(1), user: Value(model.data!.user)));
        // Log the user added to the database
        logger.info('User added to database: ${model.data!.user}');

        return Result(success: model);
      } catch (e) {
        // Log the error during Google registration
        logger
            .error('Caught error during Google registration: ${e.toString()}');
        return Result(error: ServerError());
      }
    } else {
      // Log the no internet error
      logger.error('No internet connection for Google registration request');
      return Result(error: NoInternetError());
    }
  }

  @override
  Future<Result<AuthModel>> registerapple(String token) async {
    bool isConnected = await networkInfoHelper!.isConnected();
    if (isConnected) {
      try {
        // Log the Apple registration attempt with the token
        logger.info('Apple registration attempt with token: $token');
        final Response response = await authApiService!.registerapple(token);

        // Log the response from the API
        logger.info('Apple registration response: ${response.body}');

        var model = AuthModel.fromJson(response.body);
        // Log the model created from the response
        logger.info('Apple registration model: ${model.toString()}');

        await userDao!.addUser(UserTableCompanion(
            id: const Value(1), user: Value(model.data!.user)));
        // Log the user added to the database
        logger.info('User added to database: ${model.data!.user}');

        return Result(success: model);
      } catch (e) {
        // Log the error during Apple registration
        logger.error('Caught error during Apple registration: ${e.toString()}');
        return Result(error: ServerError());
      }
    } else {
      // Log the no internet error
      logger.error('No internet connection for Apple registration request');
      return Result(error: NoInternetError());
    }
  }
}
