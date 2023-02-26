import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shoes_app/data/datasource/preferences/preferences_helper.dart';
import 'package:shoes_app/utils/constant.dart';


class DioHelper {
  var logger = Logger(
    printer: PrettyPrinter(
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  // this code is defining a set of interceptors that can be added to a Dio HTTP client to
  // modify requests and responses and to log information about them.
  InterceptorsWrapper getDioInterceptor() {
    return InterceptorsWrapper(

      //The "onRequest" interceptor is executed before the request is made, and it does the following:
      onRequest: ((options, handler) async {
        //Calls the "getAccessToken" method of the "AuthHelper" class to retrieve the access token needed for the request.
        final accessToken = await PreferencesHelper().getAccessToken();
        options.headers = {
          'Content-Type': Headers.jsonContentType,
        };
        //If an access token is available, it removes the "Authorization" header (if present)
        // and adds a new "Authorization" header with the access token.
        if (accessToken != null) {
          options.headers.remove('Authorization');
          options.headers.addAll({'Authorization': 'Bearer $accessToken'});
        }
        //Logs information about the request headers, path, and query parameters using the "logger" utility
        logger.i("${options.headers}\n${options.path}\n${options.queryParameters}");
        //If the request has a body (i.e. "options.data" is not null), logs information about the body using the "logger" utility.
        if (options.data != null) {
          logger.i("${options.data}");
        }
        //Calls the "next" method of the "handler" parameter to proceed to the next interceptor
        // in the chain or to send the request if this is the last interceptor.
        return handler.next(options);
      }),

      //The "onResponse" interceptor is executed after a successful response is received,
      //Logs information about the response using the "logger" utility.
      // Returns the response.
      onResponse: (response, handler) {
        try {
          logger.i("\n${response.statusCode}\n${response.data}");
          return handler.next(response);
        } catch (e) {
          logger.e("$response");
          return handler.next(response);
        }
      },

      //The "onError" interceptor is executed if an error occurs during the request, and it does the following:
      //Logs information about the error and the response (if available) using the "logger" utility.
      // Returns the error.
      onError: (DioError e, handler) {
        logger.e("$e");
        logger.e("${e.response}");
        return handler.next(e);
      },
    );
  }

  // this function returns a configured Dio instance that can be used to send HTTP
  // requests with the specified base URL and interceptor
  // this class will be using as paramer
  Dio getDioClient() {
    var dio = Dio();
    //Adds the interceptor returned by the "getDioInterceptor" function using the
    // "add" method of the "interceptors" property of the Dio instance.
    dio.interceptors.add(getDioInterceptor());
    //Sets the base URL of the Dio instance to the value of the "baseUrl" variable using
    // the "BASE_URL" from constant class.
    dio.options.baseUrl = BASE_URL;
    return dio;
  }
}
