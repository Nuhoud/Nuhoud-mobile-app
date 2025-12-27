class FcmParams {
  final String token;
  final String platform;

  FcmParams({required this.token, required this.platform});

  Map<String, dynamic> toJson() {
    return {"token": token, "platform": platform};
  }
}
