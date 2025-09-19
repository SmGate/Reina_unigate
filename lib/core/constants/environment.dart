enum AppEnvironment { staging, live }

class Env {
  // Switch this to AppEnvironment.live to point to live URLs
  static const AppEnvironment current = AppEnvironment.live;

  // Unigate base API
  static String get baseUrl => switch (current) {
        AppEnvironment.staging => 'https://test-unigate.smartgate.pk/api',
        AppEnvironment.live => 'https://unigate.smartgate.pk/api',
      };
}

