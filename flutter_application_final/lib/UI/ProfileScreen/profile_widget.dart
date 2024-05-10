import 'package:flutter/material.dart';
import 'package:flutter_application_final/UI/ProfileScreen/constants.dart';

class ProfileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap; // Thêm thuộc tính onTap kiểu VoidCallback

  const ProfileWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap, // Thêm tham số onTap vào constructor
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Gọi hàm onTap khi người dùng nhấn vào widget
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Constants.blackColor.withOpacity(.5),
                  size: 24,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Constants.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Constants.blackColor.withOpacity(.4),
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}