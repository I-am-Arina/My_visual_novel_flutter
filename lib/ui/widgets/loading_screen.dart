import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: AppColors.primaryBlue),
            SizedBox(height: 16),
            Text(
              'Загрузка визуальной новеллы...',
              style: TextStyle(color: AppColors.textWhite, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
