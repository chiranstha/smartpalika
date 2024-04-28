// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, file_names, await_only_futures

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../config/my_config.dart';
import '../helper/constants.dart';
import 'app_navigator_service.dart';

class Api {
  final Dio api = Dio();

  final dio = createDio();

  final tokenDio = Dio(BaseOptions(baseUrl: MyConfig.appUrl));

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio createDio() {
    // String accesstoken = StorageUtil.getString(access);
    var dio = Dio(BaseOptions(
      baseUrl: MyConfig.appUrl,
      receiveTimeout: Durations.extralong1 , // 15 seconds
      connectTimeout: Durations.short2,
      sendTimeout: Durations.short2,
    ));
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        return handler.next(e);
      },
    ));
    // dio.options.headers = {
    //   'Content-Type': 'application/json; charset=UTF-8',
    //   'Authorization': 'Bearer $accesstoken',
    // };
    dio.interceptors.addAll({
      AppInterceptors(dio),
    });

    return dio;
  }

  Future<Response> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    DioException? error,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      Response response = await dio.post<String>(
        uri,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      print("Post " + response.data);

      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      print(e.toString());

      Fluttertoast.showToast(
        msg: e.toString(),
      );
      rethrow;
    }
  }

  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    DioException? error,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      Response response = await dio.get<String>(
        uri,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      // refreshToken();
      throw const FormatException("Unable to get the data");
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
        msg: e.toString(),
      );
      rethrow;
    }
  }

  Future<Response> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    DioException? error,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      Response response = await dio.put<String>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to get the data");
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
        msg: e.toString(),
      );
      rethrow;
    }
  }

  Future<Response> delete(
    String uri, {
    Future? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      Response response = await dio.delete<String>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to delete the data");
    } catch (e) {
      rethrow;
    }
  }
}

class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors(this.dio);

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await getStringAsync(accessToken);
    print(token);
    options.headers.addAll({
      "Authorization": "Bearer $token",
      'content-Type': 'application/json',
      "validateStatus": (_) => true,
    });
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print(err.type);
    print(err.response);
     String errorMsg =   json.decode(err.response.toString())["error"]["message"];
    switch (err.type) {      
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions, errorMsg);  
      case DioExceptionType.unknown:
        throw NoInternetConnectionException(err.requestOptions, errorMsg);
      case DioExceptionType.cancel:
        throw NoInternetConnectionException(err.requestOptions, errorMsg);       
      case DioExceptionType.connectionTimeout:
         throw NoInternetConnectionException(err.requestOptions, errorMsg);     
 
      case DioExceptionType.badCertificate:
         throw NoInternetConnectionException(err.requestOptions, errorMsg);
      case DioExceptionType.badResponse:
         throw NoInternetConnectionException(err.requestOptions, errorMsg);
      case DioExceptionType.connectionError:
        throw UnauthorizedException(err.requestOptions, errorMsg);
      
    }

  }
}

class BadRequestException extends DioException {
  BadRequestException(RequestOptions r, String errorMsg)
      : super(requestOptions: r, error: errorMsg);

  @override
  String toString() {
    return error.toString();
  }
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException(RequestOptions r, String errorMsg)
      : super(requestOptions: r, error: errorMsg);

  @override
  String toString() {
    return error.toString();
  }
}

class ConflictException extends DioException {
  ConflictException(RequestOptions r, String errorMsg)
      : super(requestOptions: r, error: errorMsg);

  @override
  String toString() {
    return error.toString();
  }
}

class UnauthorizedException extends DioException {
  UnauthorizedException(RequestOptions r, String errorMsg)
      : super(
          requestOptions: r,
          error: errorMsg,
        );

  @override
  String toString() {
    AppNavigatorService.pushNamedAndRemoveUntil("login");
    return error.toString();
  }
}

class NotFoundException extends DioException {
  NotFoundException(RequestOptions r, String errorMsg)
      : super(requestOptions: r, error: errorMsg);

  @override
  String toString() {
    return error.toString();
  }
}

class NoInternetConnectionException extends DioException {
  NoInternetConnectionException(RequestOptions r, String errorMsg)
      : super(requestOptions: r, error: errorMsg);
  @override
  String toString() {
    return error.toString();
  }
}

class DeadlineExceededException extends DioException {
  DeadlineExceededException(RequestOptions r, String errorMsg)
      : super(requestOptions: r, error: errorMsg);

  @override
  String toString() {
    AppNavigatorService.pushNamedAndRemoveUntil("login");

    return error.toString();
  }
}
