import 'package:devkit/core/errors/exceptions.dart';
import 'package:devkit/core/errors/failure.dart';
import 'package:devkit/core/utils/safe_call.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Result', () {
    test('success constructor sets data and null failure', () {
      const result = Result.success('test_data');
      expect(result.isSuccess, isTrue);
      expect(result.isFailure, isFalse);
      expect(result.data, equals('test_data'));
      expect(result.failure, isNull);
    });

    test('failure constructor sets failure and null data', () {
      const failure = PlatformFailure(message: 'Platform error');
      const result = Result<String>.failure(failure);
      expect(result.isSuccess, isFalse);
      expect(result.isFailure, isTrue);
      expect(result.data, isNull);
      expect(result.failure, equals(failure));
    });
  });

  group('safeCall', () {
    test('returns Result.success when call completes successfully', () async {
      final result = await safeCall(() async => 'hello');
      expect(result.isSuccess, isTrue);
      expect(result.data, equals('hello'));
    });

    test('catches PlatformException and returns PlatformFailure', () async {
      final result = await safeCall<String>(() async {
        throw PlatformException(code: '404', message: 'Platform failure');
      });
      expect(result.isFailure, isTrue);
      expect(result.failure, isA<PlatformFailure>());
      expect(result.failure?.message, equals('Platform failure'));
    });

    test('catches CustomPlatformException and returns PlatformFailure',
        () async {
      final result = await safeCall<String>(() async {
        throw const CustomPlatformException(
          message: 'Custom platform error',
          code: '500',
        );
      });
      expect(result.isFailure, isTrue);
      expect(result.failure, isA<PlatformFailure>());
      expect(result.failure?.message, equals('Custom platform error'));
    });

    test('catches FormatException and returns PlatformFailure with message',
        () async {
      final result = await safeCall<String>(() async {
        throw const FormatException('Bad format');
      });
      expect(result.isFailure, isTrue);
      expect(result.failure, isA<PlatformFailure>());
      expect(
        result.failure?.message,
        equals('Invalid data format: Bad format'),
      );
    });

    test('catches generic Exception and returns PlatformFailure', () async {
      final result = await safeCall<String>(() async {
        throw Exception('Something went wrong');
      });
      expect(result.isFailure, isTrue);
      expect(result.failure, isA<PlatformFailure>());
      expect(result.failure?.message, equals('Something went wrong'));
    });

    test('uses customFailure when provided', () async {
      const custom = PlatformFailure(message: 'Custom error');
      final result = await safeCall<String>(
        () async => throw Exception('Generic error'),
        customFailure: custom,
      );
      expect(result.isFailure, isTrue);
      expect(result.failure, equals(custom));
    });
  });
}
