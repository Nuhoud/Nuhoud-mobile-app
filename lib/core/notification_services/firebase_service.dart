import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:nuhoud/core/utils/cache_helper.dart';

import 'notification_navigation_helper.dart';

/// -------------------------------
/// Background FCM handler
/// -------------------------------
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('[FCM] Background message: ${message.data}');
}

/// -------------------------------
/// Firebase Messaging Service
/// -------------------------------
class FirebaseMessagingService {
  FirebaseMessagingService(this._router);

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  final GoRouter _router;

  static const String _pendingNavKey = 'pending_notification_nav';

  // ===============================
  // Public API
  // ===============================
  Future<void> initialize() async {
    await _requestPermission();
    await _initLocalNotifications();
    await _initFirebaseListeners();
    await _handleInitialMessage();
    await _logToken();
  }

  /// Called from root widget AFTER first frame
  Future<void> handlePendingNavigation() async {
    final raw = CacheHelper.getData(key: _pendingNavKey);
    if (raw == null) return;

    CacheHelper.removeData(key: _pendingNavKey);

    try {
      final data = Map<String, dynamic>.from(jsonDecode(raw));
      await NotificationNavigationHelper.handle(
        router: _router,
        data: data,
      );
    } catch (e) {
      log('[FCM] Failed to parse pending navigation: $e');
    }
  }

  // ===============================
  // Init helpers
  // ===============================
  Future<void> _requestPermission() async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _logToken() async {
    try {
      final token = await _messaging.getToken();
      log('[FCM] Token: $token');

      _messaging.onTokenRefresh.listen((newToken) {
        log('[FCM] Token refreshed: $newToken');
      });
    } catch (e) {
      log('[FCM] Token error: $e');
    }
  }

  Future<void> _initFirebaseListeners() async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    /// Foreground
    FirebaseMessaging.onMessage.listen((message) async {
      log('[FCM] Foreground message: ${message.data}');
      await _showLocalNotification(message);
    });

    /// Background → foreground (notification tap)
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      log('[FCM] Opened from background: ${message.data}');
      await NotificationNavigationHelper.handle(
        router: _router,
        data: message.data,
      );
    });
  }

  /// Terminated → opened via notification
  Future<void> _handleInitialMessage() async {
    final message = await FirebaseMessaging.instance.getInitialMessage();
    if (message == null) return;

    log('[FCM] Opened from terminated: ${message.data}');
    await CacheHelper.setString(
      key: _pendingNavKey,
      value: jsonEncode(message.data),
    );
  }

  // ===============================
  // Local notifications
  // ===============================
  Future<void> _initLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (response) async {
        final payload = response.payload;
        if (payload == null || payload.isEmpty) return;

        try {
          final data = Map<String, dynamic>.from(jsonDecode(payload));
          await NotificationNavigationHelper.handle(
            router: _router,
            data: data,
          );
        } catch (e) {
          log('[LocalNotif] Invalid payload: $e');
        }
      },
    );
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    final payload = jsonEncode(message.data);
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    await _localNotifications.show(
      id,
      message.notification?.title,
      message.notification?.body,
      details,
      payload: payload,
    );
  }
}
