import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_timetable/app/modules/add_unit/controllers/add_unit_controller.dart';

class AddUnitView extends GetView<AddUnitController> {
  const AddUnitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Unit'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          children: [
            _buildTextField(controller.code, 'Unit Code'),
            _buildTextField(controller.name, 'Unit Name'),
            _buildTextField(controller.lecturer, 'Lecturer'),
            _buildTextField(controller.venue, 'Venue'),
            const SizedBox(height: 10),
            Obx(
              () => DropdownButtonFormField<String>(
                value: controller.selectedDay.value.isEmpty
                    ? null
                    : controller.selectedDay.value,
                decoration: _inputDecoration('Day'),
                items: controller.days
                    .map(
                      (day) => DropdownMenuItem<String>(
                        value: day,
                        child: Text(day),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.selectedDay.value = value;
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller.startTime,
                    'Start Time',
                    hint: 'HH:MM',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTextField(
                    controller.endTime,
                    'End Time',
                    hint: 'HH:MM',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                onPressed: controller.addUnit,
                child: const Text(
                  'Add Unit',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    RxString controllerValue,
    String label, {
    String? hint,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        onChanged: (value) => controllerValue.value = value,
        decoration: _inputDecoration(label, hint: hint),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, {String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
    );
  }
}