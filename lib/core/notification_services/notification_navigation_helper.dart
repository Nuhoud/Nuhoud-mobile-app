import 'dart:developer';
import 'package:go_router/go_router.dart';
import 'package:nuhoud/core/utils/routs.dart';

class NotificationNavigationHelper {
  NotificationNavigationHelper._();

  static Future<void> handle({
    required GoRouter router,
    required Map<String, dynamic> data,
  }) async {
    final path = _extractPath(data);

    if (path == null) {
      _fallback(router, 'No path in payload');
      return;
    }

    final uri = Uri.tryParse(path);
    if (uri == null || uri.pathSegments.isEmpty) {
      _fallback(router, 'Invalid URI: $path');
      return;
    }

    try {
      /// /job-details/234
      if (_isJobDetails(uri)) {
        final jobId = uri.pathSegments[1];
        router.go(Routers.kJobDetailsPage, extra: jobId);
        return;
      }

      /// /job-application-details/99
      if (_isJobApplicationDetails(uri)) {
        final applicationId = uri.pathSegments[1];
        router.go(
          Routers.kJobApplicationDetailsScreen,
          extra: applicationId,
        );
        return;
      }

      /// simple routes without params
      router.go('/${uri.pathSegments.first}');
    } catch (e, st) {
      log('[NotifNav] Navigation error: $e', stackTrace: st);
      _fallback(router, 'Exception');
    }
  }

  static String? _extractPath(Map<String, dynamic> data) {
    final raw = data['screen'];
    if (raw is String && raw.isNotEmpty) {
      return raw.startsWith('/') ? raw : '/$raw';
    }
    return null;
  }

  static bool _isJobDetails(Uri uri) => uri.pathSegments.length == 2 && uri.pathSegments.first == 'job-details';

  static bool _isJobApplicationDetails(Uri uri) =>
      uri.pathSegments.length == 2 && uri.pathSegments.first == 'job-application-details';

  static void _fallback(GoRouter router, String reason) {
    log('[NotifNav] Fallback → home ($reason)');
    router.go(Routers.kHomePageRoute);
  }
}
