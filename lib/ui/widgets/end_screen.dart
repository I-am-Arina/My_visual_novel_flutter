import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';

class EndScreen extends StatelessWidget {
  const EndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundDark.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(
            color: AppColors.textWhite.withValues(alpha: 0.3), width: 2),
      ),
      padding: const EdgeInsets.all(24),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle_outline,
            color: AppColors.successGreen,
            size: 48,
          ),
          SizedBox(height: 16),
          Text(
            'Конец истории',
            style: TextStyle(
              color: AppColors.textWhite,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Спасибо за игру!',
            style: TextStyle(
              color: AppColors.textWhite70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
