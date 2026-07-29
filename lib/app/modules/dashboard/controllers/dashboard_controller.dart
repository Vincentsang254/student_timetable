import 'package:get/get.dart';
import 'package:studetra/app/models/unit_model.dart';
import 'package:studetra/app/services/local_storage.dart';

class DashboardController extends GetxController {
  var units = <Unit>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadUnits();
  }

  Future<void> loadUnits() async {
    units.value = await LocalStorage.getUnits();
  }

  Future<void> addUnit(Unit unit) async {
    units.add(unit);
    await LocalStorage.saveUnits(units);
  }

  Future<void> deleteUnit(Unit unit) async {
    units.removeWhere(
      (u) =>
          u.code == unit.code &&
          u.day == unit.day &&
          u.startTime == unit.startTime,
    );

    await LocalStorage.saveUnits(units);
  }
}
