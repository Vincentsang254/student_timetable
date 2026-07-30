import 'package:get/get.dart';
import 'package:studetra/app/modules/add_unit/bindings/add_unit_binding.dart';
import 'package:studetra/app/modules/add_unit/views/add_unit_view.dart';
import 'package:studetra/app/modules/assignment_details/views/assignment_details_view.dart';
import 'package:studetra/app/modules/assignments/bindings/assignments_bindings.dart';
import 'package:studetra/app/modules/assignments/views/assignments_view.dart';
import 'package:studetra/app/modules/unit_details/views/unit_details_view.dart';
import 'package:studetra/app/routes/app_routes.dart';

import 'package:studetra/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:studetra/app/modules/dashboard/views/dashboard_view.dart';
import 'package:studetra/app/widgets/bottom_tabs.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.DASHBOARD,
      page: () => const CustomBottomTabs(),
      binding: DashboardBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 350),
    ),
    GetPage(
      name: Routes.ADD_UNIT,
      page: () => AddUnitView(),
      binding: AddUnitBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 350),
    ),
    GetPage(
      name: Routes.ASSIGNMENTS,
      page: () => AssignmentsView(),
      binding: AssignmentsBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 350),
    ),
    GetPage(
      name: Routes.ADD_ASSIGNMENT,
      page: () => AssignmentsView(),
      binding: AssignmentsBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 350),
    ),
    GetPage(
      name: Routes.UNIT_DETAILS,
      page: () => UnitDetailsView(unit: Get.arguments as dynamic),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 350),
    ),
    GetPage(
      name: Routes.ASSIGNMENT_DETAILS,
      page: () => AssignmentDetailsView(assignment: Get.arguments as dynamic),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 350),
    ),
  ];
}
