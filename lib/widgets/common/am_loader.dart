import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class AMLoader extends StatelessWidget {
  const AMLoader({super.key, this.size});

  final double? size;

  @override
  Widget build(BuildContext context) {
    final indicator = CircularProgressIndicator.adaptive(
      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
    );

    if (size != null) {
      return Center(
        child: SizedBox(
          width: size,
          height: size,
          child: indicator,
        ),
      );
    }

    return Center(child: indicator);
  }
}
