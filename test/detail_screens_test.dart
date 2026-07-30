import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:studetra/app/models/assignment_model.dart';
import 'package:studetra/app/models/unit_model.dart';
import 'package:studetra/app/modules/assignment_details/views/assignment_details_view.dart';
import 'package:studetra/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:studetra/app/modules/dashboard/views/dashboard_view.dart';
import 'package:studetra/app/modules/unit_details/views/unit_details_view.dart';
import 'package:studetra/app/widgets/bottom_tabs.dart';

void main() {
  setUp(() {
    Get.reset();
  });

  testWidgets('shows unit details screen content', (tester) async {
    final unit = Unit(
      code: 'IT101',
      name: 'Programming 101',
      lecturer: 'Dr. Smith',
      day: 'Monday',
      startTime: '09:00',
      endTime: '11:00',
      venue: 'Lab 1',
    );

    await tester.pumpWidget(GetMaterialApp(home: UnitDetailsView(unit: unit)));

    expect(find.text('Unit details'), findsOneWidget);
    expect(find.text('Programming 101'), findsOneWidget);
    expect(find.text('IT101'), findsOneWidget);
  });

  testWidgets('shows assignment details screen content', (tester) async {
    final assignment = Assignment(
      id: '1',
      unitCode: 'IT101',
      title: 'Lab report',
      description: 'Submit the final draft',
      dueDate: '2026-08-10',
      isCompleted: false,
    );

    await tester.pumpWidget(
      GetMaterialApp(home: AssignmentDetailsView(assignment: assignment)),
    );

    expect(find.text('Assignment details'), findsOneWidget);
    expect(find.text('Lab report'), findsOneWidget);
    expect(find.text('Submit the final draft'), findsOneWidget);
  });

  testWidgets('shows assignment actions directly on the assignments tab', (
    tester,
  ) async {
    await tester.pumpWidget(const GetMaterialApp(home: CustomBottomTabs()));

    await tester.tap(find.text('Assignments'));
    await tester.pumpAndSettle();

    expect(find.byType(FloatingActionButton), findsNothing);
    expect(find.text('Add Assignment'), findsOneWidget);
  });

  testWidgets('shows edit and delete actions for a unit', (tester) async {
    final controller = Get.put(DashboardController(), permanent: true);
    controller.units.assignAll([
      Unit(
        code: 'IT101',
        name: 'Programming 101',
        lecturer: 'Dr. Smith',
        day: 'Monday',
        startTime: '09:00',
        endTime: '11:00',
        venue: 'Lab 1',
      ),
    ]);

    await tester.pumpWidget(
      const GetMaterialApp(home: DashboardView(showAppBar: false)),
    );

    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();

    expect(find.text('Edit'), findsOneWidget);
    expect(find.text('Delete'), findsOneWidget);
  });
}
