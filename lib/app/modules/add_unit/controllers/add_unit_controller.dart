import 'package:get/get.dart';
import 'package:studetra/app/models/unit_model.dart';
import 'package:studetra/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:studetra/app/widgets/custom_app_snackbar.dart';

class AddUnitController extends GetxController {
  final DashboardController dashboardController = Get.find();

  final code = ''.obs;
  final name = ''.obs;
  final lecturer = ''.obs;
  final venue = ''.obs;
  final startTime = ''.obs;
  final endTime = ''.obs;
  final selectedDay = ''.obs;

  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  Future<void> addUnit() async {
    if (code.value.isEmpty ||
        name.value.isEmpty ||
        lecturer.value.isEmpty ||
        venue.value.isEmpty ||
        selectedDay.value.isEmpty ||
        startTime.value.isEmpty ||
        endTime.value.isEmpty) {
      CustomAppSnackbar.show(
        title: 'Error',
        message: 'All fields are required',
      );
      return;
    }

    final unit = Unit(
      code: code.value,
      name: name.value,
      lecturer: lecturer.value,
      day: selectedDay.value,
      startTime: startTime.value,
      endTime: endTime.value,
      venue: venue.value,
    );

    await dashboardController.addUnit(unit);

    clearFields();
    Get.back();

    CustomAppSnackbar.show(
      title: 'Success',
      message: 'Unit added to timetable',
    );
  }

  void clearFields() {
    code.value = '';
    name.value = '';
    lecturer.value = '';
    venue.value = '';
    startTime.value = '';
    endTime.value = '';
    selectedDay.value = '';
  }
}