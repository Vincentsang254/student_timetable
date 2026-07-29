import 'package:get/get.dart';
import 'package:studetra/app/modules/add_unit/controllers/add_unit_controller.dart';

class AddUnitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddUnitController>(() => AddUnitController());
  }
}
