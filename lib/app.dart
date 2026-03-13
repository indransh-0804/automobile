import 'package:flutter/material.dart';
import 'package:automobile/core/theme/app_theme.dart';
import 'package:automobile/core/router/app_router.dart';

class AutoMobileApp extends StatelessWidget {
  const AutoMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'AutoMobile',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      routerConfig: appRouter,
    );
  }
}
