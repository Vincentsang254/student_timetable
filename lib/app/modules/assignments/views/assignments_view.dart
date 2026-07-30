// lib/app/modules/assignments/views/assignments_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studetra/app/models/assignment_model.dart';
import 'package:studetra/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:studetra/app/modules/assignments/controllers/assignments_controller.dart';
import 'package:studetra/app/routes/app_routes.dart';
import 'package:studetra/app/widgets/custom_app_bar.dart';
import 'package:studetra/app/widgets/custom_app_snackbar.dart';

class AssignmentsView extends StatelessWidget {
  AssignmentsView({super.key, this.showAppBar = true});

  final bool showAppBar;

  AssignmentsController get controller => Get.find<AssignmentsController>();
  DashboardController get dashboardController => Get.find<DashboardController>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();

  void showAddAssignmentDialog(BuildContext context) {
    Get.defaultDialog(
      title: 'Add Assignment',
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: unitController,
              decoration: const InputDecoration(labelText: 'Unit Code'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: dueDateController,
              decoration: const InputDecoration(
                labelText: 'Due Date (YYYY-MM-DD)',
              ),
            ),
          ],
        ),
      ),
      textConfirm: 'Add',
      textCancel: 'Cancel',
      onConfirm: () {
        final id = DateTime.now().millisecondsSinceEpoch.toString();

        controller.addAssignment(
          Assignment(
            id: id,
            title: titleController.text,
            unitCode: unitController.text,
            description: descriptionController.text,
            dueDate: dueDateController.text,
            isCompleted: false,
          ),
        );

        titleController.clear();
        unitController.clear();
        descriptionController.clear();
        dueDateController.clear();

        Get.back();
        CustomAppSnackbar.show(
          title: 'Success',
          message: 'Assignment added',
          isError: false,
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final theme = Theme.of(context);

    return CustomAppBar(
      title: 'Assignments',
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
                  Icons.assignment_outlined,
                  size: 72,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'No assignments added',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Create your first assignment to keep track of due dates and deadlines.',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton.icon(
              onPressed: () => Get.toNamed(Routes.ADD_UNIT),
              icon: const Icon(Icons.school_outlined),
              label: const Text('Add Unit'),
            ),
            OutlinedButton.icon(
              onPressed: () => showAddAssignmentDialog(context),
              icon: const Icon(Icons.add_task_outlined),
              label: const Text('Add Assignment'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final body = Obx(() {
      final content = controller.assignments.isEmpty
          ? _buildEmptyState(context)
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: controller.assignments.length,
              itemBuilder: (context, index) {
                final assignment = controller.assignments[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      assignment.title,
                      style: TextStyle(
                        decoration: assignment.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    subtitle: Text(
                      'Unit: ${assignment.unitCode}\n'
                      'Due: ${assignment.dueDate}\n'
                      'Desc: ${assignment.description}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    leading: Checkbox(
                      value: assignment.isCompleted,
                      onChanged: (_) {
                        controller.toggleComplete(assignment.id);
                        CustomAppSnackbar.show(
                          title: 'Updated',
                          message: assignment.isCompleted
                              ? 'Marked pending'
                              : 'Marked completed',
                          isError: false,
                        );
                      },
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        controller.deleteAssignment(assignment.id);
                        CustomAppSnackbar.show(
                          title: 'Deleted',
                          message: 'Assignment removed',
                          isError: false,
                        );
                      },
                    ),
                    onTap: () => Get.toNamed(
                      Routes.ASSIGNMENT_DETAILS,
                      arguments: assignment,
                    ),
                  ),
                );
              },
            );

      return Column(
        children: [
          Expanded(child: content),
          _buildActionButtons(context),
        ],
      );
    });

    if (!showAppBar) {
      return Scaffold(body: body);
    }

    return Scaffold(
      appBar: _buildAppBar(context),
      body: body,
    );
  }
}
