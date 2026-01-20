class NotificationParams {
  final int limit;
  final String? nextCursor;

  NotificationParams({this.limit = 10, this.nextCursor});

  Map<String, dynamic> toMap() {
    final params = <String, dynamic>{'limit': limit};
    if (nextCursor != null && nextCursor!.isNotEmpty) {
      params['nextCursor'] = nextCursor;
    }
    return params;
  }
}
