class Urls {
  static bool isJobUrl = false;
  static String jobPort = "4000";
  static String mainPort = "3000";
  static String baseUrl = "http://10.0.2.2:$mainPort/";
  Urls() {
    if (isJobUrl) {
      baseUrl = "http://10.0.2.2:$jobPort/";
    } else {
      baseUrl = "http://10.0.2.2:$mainPort/";
    }
  }
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
  static String getJobs = "jobs-offers";
  static String getSearchJobs = "jobs-offers/search";
}
