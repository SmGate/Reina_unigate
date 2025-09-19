// ignore_for_file: unused_local_variable

part of 'routes_imports.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

class AppRoutes {
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: Routes.splash.path,
    routerNeglect: true,
    debugLogDiagnostics: kDebugMode,
    errorBuilder: (ctx, stx) => const Center(
      child: Text('Error Screen'),
    ),
    routes: <RouteBase>[
      GoRoute(
        path: Routes.splash.path,
        name: Routes.splash.name,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.appShell.path,
        name: Routes.appShell.name,
        builder: (_, __) => const AppShell(),
      ),
      GoRoute(
        path: Routes.onboarding.path,
        name: Routes.onboarding.name,
        builder: (_, __) => const OnboardingScreen(),
      ),
      GoRoute(
        path: Routes.login.path,
        name: Routes.login.name,
        builder: (_, __) => const LoginPage(),
      ),
      GoRoute(
        path: Routes.forgotPassword.path,
        name: Routes.forgotPassword.name,
        builder: (_, __) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: Routes.signUpOptions.path,
        name: Routes.signUpOptions.name,
        builder: (_, __) => const SignupOptionsPage(),
      ),
      GoRoute(
        path: Routes.userSignup.path,
        name: Routes.userSignup.name,
        builder: (_, __) => const UserSignUp(),
      ),
      GoRoute(
        path: '${Routes.otpScreen.path}/:email',
        name: Routes.otpScreen.name,
        builder: (context, state) {
          final email = state.pathParameters['email'] ?? '';
          return OtpScreen(email: email);
        },
      ),
      GoRoute(
        path: Routes.profileSetupMain.path,
        name: Routes.profileSetupMain.name,
        builder: (_, __) => const ProfileSetupMainPage(),
      ),
    ],
  );
}
