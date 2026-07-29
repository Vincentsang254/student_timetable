import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studetra/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:studetra/app/modules/assignments/controllers/assignments_controller.dart';

class DashboardView extends GetView<DashboardController> {
  DashboardView({super.key});

  final AssignmentsController assignmentsController = Get.find();

  final List<String> sortedDays = const [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  final Map<String, Color> dayColors = {
    'Monday': Colors.greenAccent,
    'Tuesday': Colors.blueAccent,
    'Wednesday': Colors.orangeAccent,
    'Thursday': Colors.purpleAccent,
    'Friday': Colors.redAccent,
    'Saturday': Colors.tealAccent,
  };

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.units.isEmpty) {
        return const Center(
          child: Text(
            'No units added yet',
            style: TextStyle(fontSize: 18),
          ),
        );
      }

      final unitsByDay = <String, List<dynamic>>{};
      for (var unit in controller.units) {
        unitsByDay.putIfAbsent(unit.day, () => []).add(unit);
      }

      return ListView(
        padding: const EdgeInsets.all(12),
        children: sortedDays.map((day) {
          final dayUnits = unitsByDay[day] ?? [];
          if (dayUnits.isEmpty) return const SizedBox.shrink();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                day,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              ...dayUnits.map((unit) {
                return Card(
                  color: dayColors[unit.day] ?? Colors.grey.shade200,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    leading: const Icon(Icons.book, color: Colors.deepPurple),
                    title: Text(
                      '${unit.code} - ${unit.name}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Lecturer: ${unit.lecturer}\nTime: ${unit.startTime} - ${unit.endTime}\nVenue: ${unit.venue}',
                    ),
                    trailing: Obx(() {
                      final pending = assignmentsController.pendingCountForUnit(
                        unit.code,
                      );

                      if (pending == 0) {
                        return const SizedBox.shrink();
                      }

                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '$pending',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }),
              const SizedBox(height: 12),
            ],
          );
        }).toList(),
      );
    });
  }
}