import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studetra/app/models/unit_model.dart';
import 'package:studetra/app/models/assignment_model.dart';

class LocalStorage {
  static const String unitsKey = 'units';
  static const String assignmentsKey = 'assignments';

  static Future<void> saveUnits(List<Unit> units) async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> data = units
        .map((unit) => jsonEncode(unit.toMap()))
        .toList();

    await prefs.setStringList(unitsKey, data);
  }

  static Future<List<Unit>> getUnits() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> data = prefs.getStringList(unitsKey) ?? [];

    return data.map((item) => Unit.fromMap(jsonDecode(item))).toList();
  }

  static Future<void> addUnit(Unit unit) async {
    final units = await getUnits();

    final exists = units.any(
      (u) =>
          u.code == unit.code &&
          u.day == unit.day &&
          u.startTime == unit.startTime,
    );

    if (!exists) {
      units.add(unit);
      await saveUnits(units);
    }
  }

  static Future<void> deleteUnit(Unit unit) async {
    final units = await getUnits();

    units.removeWhere(
      (u) =>
          u.code == unit.code &&
          u.day == unit.day &&
          u.startTime == unit.startTime,
    );

    await saveUnits(units);
  }

  static Future<void> clearUnits() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(unitsKey);
  }

  static Future<void> saveAssignments(List<Assignment> assignments) async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> data = assignments
        .map((a) => jsonEncode(a.toMap()))
        .toList();

    await prefs.setStringList(assignmentsKey, data);
  }

  static Future<List<Assignment>> getAssignments() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> data = prefs.getStringList(assignmentsKey) ?? [];

    return data.map((item) => Assignment.fromMap(jsonDecode(item))).toList();
  }

  static Future<void> addAssignment(Assignment assignment) async {
    final assignments = await getAssignments();

    final exists = assignments.any((a) => a.id == assignment.id);

    if (!exists) {
      assignments.add(assignment);
      await saveAssignments(assignments);
    }
  }

  static Future<void> deleteAssignment(String id) async {
    final assignments = await getAssignments();

    assignments.removeWhere((a) => a.id == id);

    await saveAssignments(assignments);
  }

  static Future<void> toggleAssignment(String id) async {
    final assignments = await getAssignments();

    final index = assignments.indexWhere((a) => a.id == id);

    if (index != -1) {
      final assignment = assignments[index];

      assignments[index] = assignment.copyWith(
        isCompleted: !assignment.isCompleted,
      );

      await saveAssignments(assignments);
    }
  }

  static Future<List<Assignment>> getAssignmentsByUnit(String unitCode) async {
    final assignments = await getAssignments();

    return assignments.where((a) => a.unitCode == unitCode).toList();
  }

  static Future<void> clearAssignments() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(assignmentsKey);
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
