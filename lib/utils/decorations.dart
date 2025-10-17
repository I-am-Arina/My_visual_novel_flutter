import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';

final dialogueBoxDecoration = BoxDecoration(
  color: AppColors.backgroundDark.withValues(alpha: 0.8),
  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
  border:
      Border.all(color: AppColors.textWhite.withValues(alpha: 0.3), width: 2),
  boxShadow: [
    BoxShadow(
      color: AppColors.backgroundDark.withValues(alpha: 0.5),
      blurRadius: 10,
      offset: const Offset(0, 5),
    ),
  ],
);

final choiceBoxDecoration = BoxDecoration(
  color: AppColors.backgroundDark.withValues(alpha: 0.9),
  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
  border:
      Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.5), width: 2),
  boxShadow: [
    BoxShadow(
      color: AppColors.backgroundDark.withValues(alpha: 0.7),
      blurRadius: 15,
      offset: const Offset(0, 8),
    ),
  ],
);

final backgroundGradient = const LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [AppColors.backgroundDark, AppColors.backgroundDarker],
);
