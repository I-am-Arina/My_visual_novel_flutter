import 'package:flutter/material.dart';
import 'constants/app_constants.dart';
import 'constants/app_colors.dart';
import 'screens/novel_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const VNApp());
}

class VNApp extends StatelessWidget {
  const VNApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryBlue),
        useMaterial3: true,
      ),
      home: const NovelScreen(),
    );
  }
}
