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

    log('Notification Navigation - Path: $path, Segments: ${uri.pathSegments}');

    try {
      /// Handle job-details with ID: /job-details/68725f64cc482e8b6ade45f0
      if (_isJobDetails(uri)) {
        final jobId = uri.pathSegments[1];
        log('Navigating to job details with ID: $jobId');

        // Navigate using path parameter format
        router.push('${Routers.kJobDetailsPage}/$jobId');
        return;
      }

      /// Handle job-application-details with ID: /job-application-details/99
      if (_isJobApplicationDetails(uri)) {
        final applicationId = uri.pathSegments[1];
        log('Navigating to job application details with ID: $applicationId');

        // Navigate using path parameter format
        router.push('${Routers.kJobApplicationDetailsScreen}/$applicationId');
        return;
      }

      // For static routes (like /filterPage, /profilePage)
      final routePath = _mapPathToRoute(uri);
      if (routePath != null) {
        log('Navigating to static route: $routePath');
        router.push(routePath);
      } else {
        log('Route not mapped, falling back to home');
        _fallback(router, 'Route not found: ${uri.path}');
      }
    } catch (e, st) {
      log('[NotifNav] Navigation error: $e', stackTrace: st);
      _fallback(router, 'Exception: $e');
    }
  }

  static String? _extractPath(Map<String, dynamic> data) {
    // Try 'screen' key first
    final rawScreen = data['screen'];
    if (rawScreen is String && rawScreen.isNotEmpty) {
      // Ensure the path starts with a slash
      return rawScreen.startsWith('/') ? rawScreen : '/$rawScreen';
    }

    // Also check for 'deeplink' key (like in working project)
    final deeplink = data['deeplink'];
    if (deeplink is String && deeplink.isNotEmpty) {
      final uri = Uri.tryParse(deeplink);
      if (uri != null) {
        final fromQuery = uri.queryParameters['screen'];
        if (fromQuery != null && fromQuery.isNotEmpty) {
          return fromQuery.startsWith('/') ? fromQuery : '/$fromQuery';
        }
        return deeplink;
      }
    }

    return null;
  }

  static String? _mapPathToRoute(Uri uri) {
    final path = uri.path;

    // Direct route mappings
    switch (path) {
      case '/filterPage':
      case '/filter':
        return Routers.kFilterPage;

      case '/profilePage':
      case '/profile':
        return Routers.kProfilePage;

      case '/ApplicationsScreen':
      case '/applications':
        return Routers.kJobApplicationsScreen;

      case '/homePage':
      case '/home':
        return Routers.kHomePageRoute;

      // Add more mappings as needed
    }

    return null;
  }

  static bool _isJobDetails(Uri uri) {
    return uri.pathSegments.length == 2 && uri.pathSegments.first == 'job-details';
  }

  static bool _isJobApplicationDetails(Uri uri) {
    return uri.pathSegments.length == 2 && uri.pathSegments.first == 'job-application-details';
  }

  static void _fallback(GoRouter router, String reason) {
    log('[NotifNav] Fallback → home ($reason)');
    router.push(Routers.kHomePageRoute);
  }
}
