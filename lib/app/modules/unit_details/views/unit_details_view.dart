import 'package:flutter/material.dart';
import 'package:studetra/app/models/unit_model.dart';
import 'package:studetra/app/widgets/custom_app_bar.dart';
import 'package:studetra/app/widgets/detail_view_widgets.dart';

class UnitDetailsView extends StatelessWidget {
  const UnitDetailsView({super.key, required this.unit});

  final Unit unit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Unit details',
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
                title: unit.name,
                subtitle: unit.code,
                icon: Icons.school_outlined,
                accentColor: Colors.deepPurple,
              ),
              const SizedBox(height: 18),
              DetailInfoSection(
                title: 'Class information',
                child: Column(
                  children: [
                    DetailInfoRow(label: 'Unit code', value: unit.code, icon: Icons.code),
                    DetailInfoRow(label: 'Lecturer', value: unit.lecturer, icon: Icons.person_outline),
                    DetailInfoRow(label: 'Day', value: unit.day, icon: Icons.calendar_today_outlined),
                    DetailInfoRow(label: 'Time', value: '${unit.startTime} - ${unit.endTime}', icon: Icons.access_time),
                    DetailInfoRow(label: 'Venue', value: unit.venue, icon: Icons.location_on_outlined),
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
