import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/assignments/views/assignments_view.dart';
import '../modules/dashboard/controllers/dashboard_controller.dart';
import '../modules/assignments/controllers/assignments_controller.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_app_bar.dart';

class CustomBottomTabs extends StatefulWidget {
  const CustomBottomTabs({super.key});

  @override
  State<CustomBottomTabs> createState() => _CustomBottomTabsState();
}

class _CustomBottomTabsState extends State<CustomBottomTabs> {
  int currentIndex = 0;

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    if (!Get.isRegistered<DashboardController>()) {
      Get.put(DashboardController(), permanent: true);
    }

    if (!Get.isRegistered<AssignmentsController>()) {
      Get.put(AssignmentsController(), permanent: true);
    }

    pages = [
      DashboardView(showAppBar: false),
      AssignmentsView(showAppBar: false),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: currentIndex == 0 ? 'Classes' : 'Assignments',
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Classes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Assignments',
          ),
        ],
      ),
    );
  }
}