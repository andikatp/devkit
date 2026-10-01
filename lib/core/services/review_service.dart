import 'package:devkit/core/constant/app_keys.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:in_app_review/in_app_review.dart';

/// Manages in-app review prompts using Google Play In-App Review API.
///
/// Strategy:
/// - Tracks how many successful actions the user performs
/// - After [_actionThreshold] actions, prompts for review once
/// - Respects a cooldown of [_cooldownDays] days between prompts
/// - Never prompts more than once per cooldown period
abstract final class ReviewService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static const int _actionThreshold = 5;
  static const int _cooldownDays = 60;

  /// Call this after a successful user action (toggle, command copy, etc.).
  /// Automatically decides whether to show the review prompt.
  static Future<void> recordSuccessfulAction() async {
    try {
      final lastPromptStr = await _storage.read(
        key: AppKeys.reviewLastPromptDate,
      );
      if (lastPromptStr != null) {
        final lastPrompt = DateTime.tryParse(lastPromptStr);
        if (lastPrompt != null) {
          final daysSince = DateTime.now().difference(lastPrompt).inDays;
          if (daysSince < _cooldownDays) return;
        }
      }

      final countStr = await _storage.read(key: AppKeys.reviewActionCount);
      final currentCount = int.tryParse(countStr ?? '') ?? 0;
      final newCount = currentCount + 1;

      await _storage.write(
        key: AppKeys.reviewActionCount,
        value: newCount.toString(),
      );

      if (newCount >= _actionThreshold) {
        await _tryRequestReview();
      }
    } on Exception catch (_) {
      // Never let review logic crash the app
    }
  }

  static Future<void> _tryRequestReview() async {
    final inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      await inAppReview.requestReview();
      // Reset counter and record prompt date
      await _storage.write(key: AppKeys.reviewActionCount, value: '0');
      await _storage.write(
        key: AppKeys.reviewLastPromptDate,
        value: DateTime.now().toIso8601String(),
      );
    }
  }

  /// Opens the Play Store listing directly. Use for a manual
  /// "Rate this app" button in settings or about screens.
  static Future<void> openStoreListing() async {
    final inAppReview = InAppReview.instance;
    await inAppReview.openStoreListing(appStoreId: 'com.andikatp.devkit');
  }
}
