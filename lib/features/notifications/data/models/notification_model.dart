class NotificationResponseModel {
  final List<NotificationModel> notifications;
  final String? nextCursor;
  final bool hasMore;

  NotificationResponseModel({required this.notifications, required this.nextCursor, required this.hasMore});

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    return NotificationResponseModel(
      notifications: (json['data'] as List<dynamic>? ?? [])
          .map((item) => NotificationModel.fromJson(Map<String, dynamic>.from(item)))
          .toList(),
      nextCursor: json['nextCursor'],
      hasMore: json['hasMore'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': notifications.map((notification) => notification.toJson()).toList(),
      'nextCursor': nextCursor,
      'hasMore': hasMore,
    };
  }
}

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final NotificationPayload? data;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.data,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      data: json['data'] != null ? NotificationPayload.fromJson(Map<String, dynamic>.from(json['data'])) : null,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'body': body,
      'data': data?.toJson(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class NotificationPayload {
  final String? screen;

  NotificationPayload({this.screen});

  factory NotificationPayload.fromJson(Map<String, dynamic> json) {
    return NotificationPayload(
      screen: json['screen'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'screen': screen,
    };
  }
}
