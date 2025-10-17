import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../utils/decorations.dart';

class BackgroundWidget extends StatelessWidget {
  final String? bgPath;

  const BackgroundWidget({
    super.key,
    required this.bgPath,
  });

  @override
  Widget build(BuildContext context) {
    if (bgPath == null) {
      return Container(decoration: BoxDecoration(gradient: backgroundGradient));
    }

    return Image.asset(
      'assets/$bgPath',
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          decoration: BoxDecoration(gradient: backgroundGradient),
          child: const Center(
            child: Text(
              'Фон не найден',
              style: TextStyle(color: AppColors.textWhite70),
            ),
          ),
        );
      },
    );
  }
}
