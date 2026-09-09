import 'package:devkit/core/errors/exceptions.dart';
import 'package:devkit/core/errors/failure.dart';
import 'package:devkit/core/extensions/exception.dart';
import 'package:devkit/core/utils/utils.dart';
import 'package:flutter/services.dart';

class Result<T> {
  const new success(this.data) : failure = null;
  const new failure(this.failure) : data = null;

  final T? data;
  final Failure? failure;

  bool get isSuccess => failure == null;
  bool get isFailure => failure != null;
}

Future<Result<T>> safeCall<T>(
  Future<T> Function() call, {
  Failure? customFailure,
}) async {
  try {
    final result = await call();
    return Result.success(result);
  } on PlatformException catch (e, s) {
    Utils.log('PlatformException: $e');
    Utils.log('Stack Trace: $s');
    return Result.failure(
      customFailure ??
          PlatformFailure(message: e.message ?? 'Platform error occurred'),
    );
  } on CustomPlatformException catch (e, s) {
    Utils.log('CustomPlatformException: $e');
    Utils.log('Stack Trace: $s');
    return Result.failure(
      customFailure ?? PlatformFailure(message: e.message, code: e.code),
    );
  } on FormatException catch (e, s) {
    Utils.log('FormatException: $e');
    Utils.log('Stack Trace: $s');
    return Result.failure(
      customFailure ??
          PlatformFailure(message: 'Invalid data format: ${e.message}'),
    );
  } on Object catch (e, s) {
    Utils.log('Exception: $e');
    Utils.log('Stack Trace: $s');
    if (e is Error) {
      return Result.failure(
        customFailure ??
            PlatformFailure(message: 'An unexpected error occurred: $e'),
      );
    }
    return Result.failure(
      customFailure ?? PlatformFailure(message: (e as Exception).getMessage),
    );
  }
}
