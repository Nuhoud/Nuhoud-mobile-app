class Urls {
  static const String mainPort = "3000";
  static const String jobPort = "4000";
  static const String mainBaseUrl = "http://10.0.2.2:$mainPort/";
  static const String jobsBaseUrl = "http://10.0.2.2:$jobPort/";

  //auth endpoint
  static String login = "auth/login";
  static String register = "auth/signup";
  static String verifyOtp = "auth/verify-otp";
  static String resendOtp = "auth/resend-otp";
  static String resetPassword = "auth/resetPassword";
  static String verifyResetPasswordOtp = "auth/verifyResetPasswordOtp";
  static String requestResetPassword = "auth/requestResetPassword";
  static String logout = "auth/logout";

  //onboarding endpoint
  static String saveUserInfoStepOne = "profile/profileInfoStepOne";
  static String saveUserInfoStepTwo = "profile/profileInfoStepTwo";

  //job endpoint
  static String getJobs = "job-offers";
  static String getSearchJobs = "job-offers/search";
}
