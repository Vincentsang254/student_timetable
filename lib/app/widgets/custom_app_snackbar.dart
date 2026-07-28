import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppSnackbar {
  static void show({
    required String title,
    required String message,
    IconData icon = Icons.info_outline,
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
  }) {
    Get.rawSnackbar(
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 3),
      messageText: Row(
        children: [
          Icon(icon, color: textColor),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  message,
                  style: TextStyle(
                    color: textColor.withOpacity(0.9),
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
