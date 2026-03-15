import 'package:flutter/material.dart';
import 'package:automobile/app/route.dart';
import 'package:automobile/app/theme.dart';
import 'package:automobile/app/font.dart';
import 'package:automobile/core/utils/size_config.dart';

class AutoVault extends StatelessWidget {
  const AutoVault({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, "Manrope", "Inter");
    MaterialTheme theme = MaterialTheme(textTheme);
    SizeConfig().init(context);
    return MaterialApp.router(
      routerConfig: goRouter,
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      debugShowCheckedModeBanner: false,
      title: 'AutoVault',
    );
  }
}