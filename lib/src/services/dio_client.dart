import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../config/alert_utils.dart';
import 'service_endpoints.dart';

class DioClient {
  late final Dio dio;

  DioClient() {
    // Initialize dio with baseOptions
    dio = Dio(
      BaseOptions(
        baseUrl: ServiceEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Accept': 'application/json;',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ),
    );

    // Add interceptors
    dio.interceptors.add(CommonInterceptor());
  }
}

/// Interceptor to handle authentication related logic
class CommonInterceptor implements Interceptor {
  final _logger = Logger(printer: PrettyPrinter(methodCount: 0));

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e(
      "ERROR FOR HTTP [${err.requestOptions.method}] request ==> ${err.requestOptions.baseUrl}${err.requestOptions.path}\nStatus code => ${err.response?.statusCode}\nData => ${err.response?.data}",
    );

    // Handle connection error
    if (err.type == DioExceptionType.connectionError) {
      AlertUtils.showSnackBar("Error connecting to server", AlertTypes.warning, duration: const Duration(seconds: 6));
    }

    // Handle timeout error
    if (err.type == DioExceptionType.connectionTimeout) {
      AlertUtils.showSnackBar(
        "Unable to establish a connection. Please try again later!",
        AlertTypes.warning,
        duration: const Duration(seconds: 5),
      );
    }

    // Handle timeout error
    if (err.type == DioExceptionType.receiveTimeout) {
      AlertUtils.showSnackBar(
        "This is taking longer than expected.\nCheck your internet connection.",
        AlertTypes.warning,
        duration: const Duration(seconds: 5),
      );
    }

    if (err.type == DioExceptionType.badResponse) {
      var responseData = err.response?.data;
      if (responseData != null) {
        var messages = responseData["message"];

        if (messages is List<dynamic>) {
          // List of String messages
          if (messages.isNotEmpty && messages.length > 1) {
            // Contains more messages
            StringBuffer errorPayload = StringBuffer("");
            for (String x in messages) {
              errorPayload.writeln("⦿ ${x.toString()}");
            }
            AlertUtils.showSnackBar(errorPayload.toString(), AlertTypes.error);
          } else if (messages.isNotEmpty && messages.length == 1) {
            // Contains only one message
            if (messages.first.toString().toLowerCase() != "token has expired") {
              AlertUtils.showSnackBar(messages.first.toString(), AlertTypes.error);
            }
          } else {
            AlertUtils.showSnackBar("Something went wrong!", AlertTypes.error);
          }
        } else {
          AlertUtils.showSnackBar(messages ?? "Something went wrong!", AlertTypes.error);
        }
      }
    }

    // continue
    handler.next(err);
  }

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    _logger
        .i("HTTP [${options.method}] REQUEST ==> ${options.baseUrl}${options.path}\nREQUEST Body => ${options.data}");
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.i(
      "RESPONSE OF HTTP [${response.requestOptions.method}] request ==> ${response.requestOptions.baseUrl}${response.requestOptions.path}\nStatus code => ${response.statusCode}\nData => ${response.data}",
    );
    // continue
    handler.next(response);
  }
}
