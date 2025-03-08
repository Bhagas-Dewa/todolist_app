import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea( 
      child: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Color(0xFF4864EC), 
        ),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10), 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              'assets/appbar_menu.svg',
              width: 28,
              height: 28,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/appbar_notification.svg',
                  width: 26,
                  height: 26,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                const SizedBox(width: 18), 
                SvgPicture.asset(
                  'assets/appbar_akun.svg',
                  width: 28,
                  height: 28,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(70); 
}
