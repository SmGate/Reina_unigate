// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:unigate/core/errors/failures.dart';

import 'dio_interceptor.dart';
import 'package:unigate/core/constants/environment.dart';
import 'isolate_parser.dart';

typedef ResponseConverter<T> = T Function(dynamic response);

class DioClient {
  DioClient() {
    _isUnitTest = true;

    _dio = _createDio();
  }

  final String baseUrl = Env.baseUrl;
  String? token;
  //String? _auth;
  bool _isUnitTest = false;
  late Dio _dio;

  Dio get dio {
    if (_isUnitTest) {
      return _dio;
    } else {
      final dio = _createDio();
      if (!_isUnitTest) dio.interceptors.add(DioInterceptor());
      return dio;
    }
  }

  Dio _createDio() {
    // var uuid = const Uuid();
    //  String requestId = uuid.v4();
    //   String token = MainBoxMixin.mainBox?.get(MainBoxKeys.token.name) ?? "";

    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        // headers: {
        //   'Content-Type': 'application/json',
        //   'Authorization': 'Bearer null',
        // },
        // headers: {
        //   'Content-Type': 'application/json',
        //   'Accept': 'application/json',
        //   'Access-Control-Allow-Origin': '*',
        //   'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        //   'Access-Control-Allow-Headers':
        //       'Origin, Content-Type, Accept, Authorization',
        //   'X-Request-ID': requestId,
        //   'Cache-Control': 'no-cache',
        //   //  'User-Agent': 'PicksApart',
        //   'Authorization': 'Bearer $token',
        //   if (_auth != null) ...{
        //     'Authorization': _auth,
        //   } else ...{
        //     'Authorization': 'Bearer $token',
        //   },
        // },

        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer null',
        },
        receiveTimeout: const Duration(minutes: 1),
        connectTimeout: const Duration(minutes: 1),
        validateStatus: (int? status) {
          return status! > 0;
        },
      ),
    );
  }

  Future<Either<Failure, T>> getRequest<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    required ResponseConverter<T> converter,
    bool isIsolate = kIsWeb ? false : true,
  }) async {
    print('url: $url');
    try {
      final response = await dio.get(url, queryParameters: queryParameters);
      print('Response: ${response.data}');
      //debugPrint('${response.statusCode} >>>> ${response.data} >> ');

      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 201) {
        if (response.statusCode == 401) {
          return Left(ServerException(false, 'Unauthorized!, Login Again'));
        }

        if (response.statusCode == 422) {
          return Left(ServerException(false, response.data['message']));
        }

        if (response.statusCode == 404) {
          return Left(ServerException(false, "Not Found"));
        }

        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }

      if (!isIsolate) {
        try {
          final cv = converter(response.data);
          return Right(cv);
        } on Exception catch (e) {
          return Left(MachineFailure(e.toString()));
        }
      }
      try {
        final isolateParse = IsolateParser<T>(
          response.data as Map<String, dynamic>,
          converter,
        );
        final result = await isolateParse.parseInBackground();
        return Right(result);
      } on Exception catch (e) {
        return Left(MachineFailure(e.toString()));
      }
    } on DioException {
      return Left(
        ServerFailure(
          'Something went wrong with server!',
        ),
      );
    }
  }

  Future<Either<Failure, T>> putRequest<T>(
    String url,
    String uid, {
    Map<String, dynamic>? data,
    required ResponseConverter<T> converter,
    bool isIsolate = kIsWeb ? false : true,
  }) async {
    print('url: $url');
    print(data);
    try {
      final response = await dio.put('$url/$uid', data: data);
      print('Response: ${response.data}');
      //debugPrint('${response.statusCode} >>>> ${response.data} >> ');

      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 201) {
        if (response.statusCode == 401) {
          return Left(ServerException(false, 'Unauthorized!, Login Again'));
        }

        if (response.statusCode == 422) {
          return Left(ServerException(false, response.data['message']));
        }

        if (response.statusCode == 500) {
          return Left(ServerException(false, response.data['message']));
        }
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
      if (!isIsolate) {
        return Right(converter(response.data));
      }
      final isolateParse = IsolateParser<T>(
        response.data as Map<String, dynamic>,
        converter,
      );
      final result = await isolateParse.parseInBackground();
      return Right(result);
    } on DioException {
      return Left(
        ServerFailure(
          'Something went wrong with server!',
        ),
      );
    }
  }

  Future<Either<Failure, T>> deleteRequest<T>(
    String url,
    String uid, {
    Map<String, dynamic>? data,
    required ResponseConverter<T> converter,
    bool isIsolate = kIsWeb ? false : true,
  }) async {
    print('url: $url');
    print(data);
    try {
      final response = await dio.delete('$url/$uid', data: data);
      print('Response: ${response.data}');
      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 201) {
        if (response.statusCode == 401) {
          return Left(ServerException(false, 'Unauthorized!, Login Again'));
        }

        if (response.statusCode == 422) {
          return Left(ServerException(false, response.data['message']));
        }
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
      if (!isIsolate) {
        return Right(converter(response.data));
      }
      final isolateParse = IsolateParser<T>(
        response.data as Map<String, dynamic>,
        converter,
      );
      final result = await isolateParse.parseInBackground();
      return Right(result);
    } on DioException {
      return Left(
        ServerFailure(
          'Something went wrong with server!',
        ),
      );
    }
  }

  Future<Either<Failure, T>> postRequest<T>(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    required ResponseConverter<T> converter,
    bool isIsolate = kIsWeb ? false : true,
  }) async {
    print('url: $url');
    print(data);
    try {
      final response = await dio.post(url, data: data, queryParameters: query);
      print('Response: ${response.data}');
      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 201) {
        final String errorMessage = _extractErrorMessage(response.data);

        if (response.statusCode == 401 ||
            response.statusCode == 400 ||
            response.statusCode == 409 ||
            response.statusCode == 422) {
          return Left(ServerException(false, errorMessage));
        }
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
      if (!isIsolate) {
        return Right(converter(response.data));
      }
      final isolateParse = IsolateParser<T>(
        response.data as Map<String, dynamic>,
        converter,
      );
      final result = await isolateParse.parseInBackground();

      return Right(result);
    } on DioException catch (e) {
      print('DioException type: ${e.type}');
      print('DioException message: ${e.message}');
      print('DioException request: ${e.requestOptions}');
      print('DioException response: ${e.response}');
      // Surface clearer messages for connectivity/DNS errors
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.unknown) {
        final host = e.requestOptions.uri.host;
        final message =
            'Network error. Unable to reach $host. Check your internet connection and try again.';
        return Left(MachineFailure(message));
      }
      return Left(ServerFailure('Something went wrong with server!'));
    }
  }

  String _extractErrorMessage(dynamic data) {
   
    if (data is Map<String, dynamic>) {
      final dynamic message = data['message'];
      if (message is String) return message;
      if (message is Map) {
        final List<String> parts = [];
        message.forEach((key, value) {
          if (value is List) {
            parts.add('$key: ${value.join(', ')}');
          } else {
            parts.add('$key: $value');
          }
        });
        if (parts.isNotEmpty) return parts.join('\n');
      }
      if (data['error'] is String) return data['error'] as String;
    }
    if (data is String) return data;
    return 'Request failed';
  }
}
