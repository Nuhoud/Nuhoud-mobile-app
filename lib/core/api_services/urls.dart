class Urls {
  static String baseUrl = "http://10.0.2.2:3000/";

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
}
