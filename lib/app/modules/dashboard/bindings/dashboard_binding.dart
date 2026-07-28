import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import 'package:student_timetable/app/modules/assignments/controllers/assignments_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AssignmentsController(), permanent: true);

    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
