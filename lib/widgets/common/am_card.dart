import 'package:flutter/material.dart';

class AMCard extends StatelessWidget {
  const AMCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    final defaultPadding = EdgeInsets.all(shortestSide * 0.03);

    final content = Padding(
      padding: padding ?? defaultPadding,
      child: child,
    );

    if (onTap != null) {
      return Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: content,
        ),
      );
    }

    return Card(child: content);
  }
}
