import 'package:flutter/material.dart';
import 'package:unigate/core/routing/routes_imports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unigate/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:unigate/injection/injection_container.dart';

class MainTemplate extends StatelessWidget {
  const MainTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()),
      ],
      child: MaterialApp.router(
        routerConfig: AppRoutes.router,
        debugShowCheckedModeBanner: false,
        builder: (BuildContext context, Widget? child) {
          return child ?? const SizedBox();
        },
      ),
    );
  }
}
