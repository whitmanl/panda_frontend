// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Project imports:
import 'package:panda_frontend/common/widgets/show_ok_dialog.dart';

class ApiHelper {
  ApiHelper._();

  static final BaseOptions _options = BaseOptions(
    baseUrl: dotenv.env['BASE_URL'] ?? '',
    responseType: ResponseType.json,
  );

  static Future<dynamic> get(
    BuildContext? context, {
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await Dio(_options).get(
        path,
        queryParameters: queryParameters,
      );

      return response.data;
    } on DioException catch (e) {
      if (context != null && context.mounted) {
        await showOkDialog(
          context,
          content: e.response?.statusMessage ?? 'Unexpected Error',
        );
      }
    }
  }

  static Future<Map> post(
    BuildContext? context, {
    required String path,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await Dio(_options).post(
        path,
        data: json.encode(body),
      );

      return response.data ?? {};
    } on DioException catch (e) {
      if (context != null && context.mounted) {
        await showOkDialog(
          context,
          content: e.response?.statusMessage ?? 'Unexpected Error',
        );
      }
      rethrow;
    }
  }

  static Future<Map> put(
    BuildContext? context, {
    required String path,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await Dio(_options).put(
        path,
        data: json.encode(body),
      );

      return response.data ?? {};
    } on DioException catch (e) {
      if (context != null && context.mounted) {
        await showOkDialog(
          context,
          content: e.response?.statusMessage ?? 'Unexpected Error',
        );
      }
      rethrow;
    }
  }

  static Future<dynamic> delete(
    BuildContext? context, {
    required String path,
  }) async {
    try {
      final response = await Dio(_options).delete(
        path,
      );

      return response.data ?? {};
    } on DioException catch (e) {
      if (context != null && context.mounted) {
        await showOkDialog(
          context,
          content: e.message ?? 'Unexpected Error',
        );
      }
      rethrow;
    }
  }
}
