import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/init/app_init.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';

void main() async {
  await initializeApp();
  runApp(
    const ProviderScope(
      child: AutoMobileApp(),
    ),
  );
}

class AutoMobileApp extends ConsumerWidget {
  const AutoMobileApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'AutoMobile',
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      routerConfig: router,
    );
  }
}
