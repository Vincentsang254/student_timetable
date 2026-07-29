import 'package:get/get.dart';
import 'package:studetra/app/modules/assignments/controllers/assignments_controller.dart';

class AssignmentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AssignmentsController(), permanent: true);
  }
}
