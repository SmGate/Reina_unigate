import 'package:flutter/material.dart';
import 'package:unigate/injection/injection_container.dart';
import 'package:unigate/main_template.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjection();
  runApp(const MainTemplate());
}
