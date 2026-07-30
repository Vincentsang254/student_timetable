import 'package:flutter/material.dart';
import 'package:studetra/app/models/assignment_model.dart';
import 'package:studetra/app/widgets/custom_app_bar.dart';
import 'package:studetra/app/widgets/detail_view_widgets.dart';

class AssignmentDetailsView extends StatelessWidget {
  const AssignmentDetailsView({super.key, required this.assignment});

  final Assignment assignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Assignment details',
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailHeader(
                title: assignment.title,
                subtitle: assignment.unitCode,
                icon: Icons.assignment_outlined,
                accentColor: Colors.orange,
              ),
              const SizedBox(height: 18),
              DetailInfoSection(
                title: 'Assignment details',
                child: Column(
                  children: [
                    DetailInfoRow(label: 'Title', value: assignment.title, icon: Icons.title),
                    DetailInfoRow(label: 'Unit', value: assignment.unitCode, icon: Icons.book_outlined),
                    DetailInfoRow(label: 'Due date', value: assignment.dueDate, icon: Icons.event_available_outlined),
                    DetailInfoRow(label: 'Status', value: assignment.isCompleted ? 'Completed' : 'Pending', icon: Icons.check_circle_outline),
                    DetailInfoRow(label: 'Description', value: assignment.description, icon: Icons.description_outlined),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
