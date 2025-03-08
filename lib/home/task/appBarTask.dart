import 'package:flutter/material.dart';
import 'package:flutter_application_todolist/home/home.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTaskAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTaskAppBar({super.key});

  @override
  Widget build(BuildContext context) {
  return Container(
    color: Colors.white, // Pastikan warna background
    padding: const EdgeInsets.only(top: 40,right: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Tombol Back
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/icon_back.svg',
              width: 28,
              height: 28,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
          ),
        ),

        // Ikon 3 Titik
        Padding(
          padding: const EdgeInsets.only(right: 28),
          child: SvgPicture.asset(
            'assets/dot3.svg',
            width: 28,
            height: 28,
          ),
        ),
      ],
    ),
  );
}

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
