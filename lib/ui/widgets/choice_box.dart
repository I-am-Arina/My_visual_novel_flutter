import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';
import '../../models/script_nodes.dart';
import '../../utils/decorations.dart';

class ChoiceBox extends StatelessWidget {
  final ChoiceNode node;
  final void Function(int) onPick;

  const ChoiceBox({super.key, required this.node, required this.onPick});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: choiceBoxDecoration,
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.2),
                borderRadius:
                    BorderRadius.circular(AppConstants.buttonBorderRadius),
              ),
              child: Text(
                node.prompt,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.lightBlue,
                ),
              ),
            ),
            const SizedBox(height: 16),
            for (var i = 0; i < node.options.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => onPick(i),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          AppColors.primaryBlue.withValues(alpha: 0.8),
                      foregroundColor: AppColors.textWhite,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            AppConstants.buttonBorderRadius),
                      ),
                      elevation: 4,
                    ),
                    child: Text(
                      node.options[i].text,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
