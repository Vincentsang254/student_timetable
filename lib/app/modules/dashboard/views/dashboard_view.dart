import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studetra/app/models/unit_model.dart';
import 'package:studetra/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:studetra/app/modules/assignments/controllers/assignments_controller.dart';
import 'package:studetra/app/routes/app_routes.dart';
import 'package:studetra/app/widgets/custom_app_bar.dart';
import 'package:studetra/app/widgets/custom_app_snackbar.dart';

class DashboardView extends GetView<DashboardController> {
  DashboardView({super.key, this.showAppBar = true});

  final bool showAppBar;

  AssignmentsController get assignmentsController => Get.find<AssignmentsController>();

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

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final theme = Theme.of(context);

    return CustomAppBar(
      title: 'Units',
      centerTitle: false,
      backgroundColor: theme.colorScheme.surface,
      foregroundColor: theme.colorScheme.onSurface,
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.school_outlined,
                  size: 72,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'No units added',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Add your first unit to start building your weekly timetable.',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () => Get.toNamed(Routes.ADD_UNIT),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Unit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEditUnitDialog(BuildContext context, Unit unit) {
    final codeController = TextEditingController(text: unit.code);
    final nameController = TextEditingController(text: unit.name);
    final lecturerController = TextEditingController(text: unit.lecturer);
    final venueController = TextEditingController(text: unit.venue);
    final startTimeController = TextEditingController(text: unit.startTime);
    final endTimeController = TextEditingController(text: unit.endTime);
    final dayController = TextEditingController(text: unit.day);

    Get.defaultDialog(
      title: 'Edit Unit',
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(controller: codeController, decoration: const InputDecoration(labelText: 'Code')),
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: lecturerController, decoration: const InputDecoration(labelText: 'Lecturer')),
            TextField(controller: venueController, decoration: const InputDecoration(labelText: 'Venue')),
            TextField(controller: dayController, decoration: const InputDecoration(labelText: 'Day')),
            TextField(controller: startTimeController, decoration: const InputDecoration(labelText: 'Start Time')),
            TextField(controller: endTimeController, decoration: const InputDecoration(labelText: 'End Time')),
          ],
        ),
      ),
      textConfirm: 'Save',
      textCancel: 'Cancel',
      onConfirm: () async {
        final updatedUnit = unit.copyWith(
          code: codeController.text,
          name: nameController.text,
          lecturer: lecturerController.text,
          venue: venueController.text,
          day: dayController.text,
          startTime: startTimeController.text,
          endTime: endTimeController.text,
        );

        await controller.updateUnit(unit, updatedUnit);
        Get.back();
        CustomAppSnackbar.show(
          title: 'Updated',
          message: 'Unit updated',
          isError: false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.units.isEmpty) {
        return _buildEmptyState(context);
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
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(() {
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
                        const SizedBox(width: 8),
                        PopupMenuButton<String>(
                          onSelected: (value) async {
                            if (value == 'edit') {
                              _showEditUnitDialog(context, unit);
                            } else if (value == 'delete') {
                              await controller.deleteUnit(unit);
                              CustomAppSnackbar.show(
                                title: 'Deleted',
                                message: 'Unit removed',
                                isError: false,
                              );
                            }
                          },
                          itemBuilder: (context) => const [
                            PopupMenuItem(value: 'edit', child: Text('Edit')),
                            PopupMenuItem(value: 'delete', child: Text('Delete')),
                          ],
                        ),
                      ],
                    ),
                    onTap: () => Get.toNamed(Routes.UNIT_DETAILS, arguments: unit as Unit),
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