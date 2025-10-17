import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';
import '../../utils/decorations.dart';

class DialogueBox extends StatelessWidget {
  final String who;
  final String text;

  const DialogueBox({super.key, required this.who, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: dialogueBoxDecoration,
      padding: const EdgeInsets.all(AppConstants.defaultPadding + 4),
      child: DefaultTextStyle(
        style: const TextStyle(
          color: AppColors.textWhite,
          fontSize: 16,
          height: 1.4,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (who.isNotEmpty) ...[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withValues(alpha: 0.3),
                  borderRadius:
                      BorderRadius.circular(AppConstants.buttonBorderRadius),
                ),
                child: Text(
                  who,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.lightBlue,
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
            Text(text),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.textWhite.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Тапните, чтобы продолжить',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textWhite70,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
