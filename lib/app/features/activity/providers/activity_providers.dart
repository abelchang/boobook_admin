import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/activity.dart';

// Necessary for code-generation to work
part 'activity_providers.g.dart';

/// This will create a provider named `activityProvider`
/// which will cache the result of this function.
@riverpod
Future<Activity> activity(Ref ref) async {
  debugPrint('activity in');
  final Dio dio = Dio(
    BaseOptions(
        // connectTimeout: 10000,
        // receiveTimeout: 10000,
        ),
  );
  // Using package:http, we fetch a random activity from the Bored API.
  final response = await dio.get('https://boredapi.com/api/activity');

  // Using dart:convert, we then decode the JSON payload into a Map data structure.
  final json = jsonDecode(response.toString());

  debugPrint(Activity.fromJson(json).toString());
  // Finally, we convert the Map into an Activity instance.
  return Activity.fromJson(json);
}
