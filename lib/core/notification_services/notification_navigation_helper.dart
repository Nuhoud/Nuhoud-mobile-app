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
      if (!_isAllowed(uri.pathSegments.first)) {
        log('[NotifNav] Screen not allowed: ${uri.pathSegments.first}');
        router.go(Routers.kHomePageRoute);
        return;
      }

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

      try {
        router.go(uri.pathSegments.first);
      } catch (e, st) {
        log('[NotifNav] Navigation error: $e', stackTrace: st);
        router.go(Routers.kHomePageRoute);
      }
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

  static bool _isAllowed(String path) {
    final uri = Uri.tryParse(path);
    if (uri == null) return false;

    final first = uri.pathSegments.isEmpty ? '' : uri.pathSegments.first;

    const allowedRoots = {
      Routers.kHomePageRoute,
      Routers.kFilterPage,
      Routers.kProfilePage,
      Routers.kJobDetailsPage,
      Routers.kJobApplicationsScreen,
      Routers.kJobApplicationDetailsScreen,
    };

    return allowedRoots.contains(first);
  }

  static bool _isJobDetails(Uri uri) =>
      uri.pathSegments.length == 2 && uri.pathSegments.first == Routers.kJobDetailsPage;

  static bool _isJobApplicationDetails(Uri uri) =>
      uri.pathSegments.length == 2 && uri.pathSegments.first == Routers.kJobApplicationDetailsScreen;

  static void _fallback(GoRouter router, String reason) {
    log('[NotifNav] Fallback → home ($reason)');
    router.go(Routers.kHomePageRoute);
  }
}
