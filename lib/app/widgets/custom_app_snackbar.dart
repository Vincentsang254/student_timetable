import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppSnackbar {
  static void show({
    required String title,
    required String message,
    IconData icon = Icons.check_circle_outline,
    bool isError = false,
    Color? textColor,
  }) {
    final bgColor = isError ? Colors.red.shade600 : Colors.green.shade600;
    final iconData = isError ? Icons.error_outline : icon;
    final fgColor = textColor ?? Colors.white;

    Get.rawSnackbar(
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      borderRadius: 14,
      backgroundColor: bgColor,
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 250),
      forwardAnimationCurve: Curves.easeOutCubic,
      messageText: Row(
        children: [
          Icon(iconData, color: fgColor),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: fgColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  message,
                  style: TextStyle(
                    color: fgColor.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
