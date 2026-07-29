import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studetra/app/routes/app_pages.dart';
import 'package:studetra/app/routes/app_routes.dart';
import 'package:studetra/app/widgets/bottom_tabs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const StudyScheduleApp());
}

class StudyScheduleApp extends StatelessWidget {
  const StudyScheduleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Studetra',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.DASHBOARD,
      getPages: AppPages.routes,
    );
  }
}
