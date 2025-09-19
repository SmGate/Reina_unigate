enum Routes {
  appShell('/appShell'),
  splash('/'),
  home('/home'),
  onboarding('/onboarding'),
  signUpOptions('/signUpOptions'),
  userSignup('/userSignup'),
  otpScreen('/otpScreen'),
  profileSetupMain('/profileSetupMain'),
  studentAnalyticsHome('/studentAnalyticsHome'),
  universitiesExplorer('/universitiesExplorer'),
  applicationManagerScreen('/applicationManagerScreen'),
  documetCenterScreen('/documetCenterScreen'),
  chatSupport('/chatSupport'),
  visaFinancialAssistance('/visaFinancialAssistance'),
  learneExplore('/learneExplore'),
  testPrepResouces('/testPrepResouces'),
  login('/login'),
  forgotPassword('/forgotPassword');

  const Routes(this.path);

  final String path;
}
