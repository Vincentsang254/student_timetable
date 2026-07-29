import 'package:get/get.dart';
import 'package:studetra/app/models/assignment_model.dart';
import 'package:studetra/app/services/local_storage.dart';

class AssignmentsController extends GetxController {
  var assignments = <Assignment>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAssignments();
  }

  Future<void> loadAssignments() async {
    assignments.value = await LocalStorage.getAssignments();
  }

  Future<void> addAssignment(Assignment assignment) async {
    assignments.add(assignment);
    await LocalStorage.saveAssignments(assignments);
  }

  Future<void> deleteAssignment(String id) async {
    assignments.removeWhere((a) => a.id == id);
    await LocalStorage.saveAssignments(assignments);
  }

  Future<void> toggleComplete(String id) async {
    final index = assignments.indexWhere((a) => a.id == id);

    if (index != -1) {
      assignments[index] = assignments[index].copyWith(
        isCompleted: !assignments[index].isCompleted,
      );

      await LocalStorage.saveAssignments(assignments);
    }
  }

  int pendingCountForUnit(String unitCode) {
    return assignments
        .where((a) => a.unitCode == unitCode && !a.isCompleted)
        .length;
  }
}
