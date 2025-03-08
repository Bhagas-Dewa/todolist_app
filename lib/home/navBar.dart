import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return _buildBottomNavBar(); // Pastikan navbar ditampilkan dalam build()
  }

  Widget _buildBottomNavBar() {
    return Container(
      width: double.infinity,
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, defaultIcon: 'assets/navbar1_false.svg', selectedIcon: 'assets/navbar1_true.svg'),
          _buildNavItem(1, defaultIcon: 'assets/navbar2_false.svg', selectedIcon: 'assets/navbar2_true.svg'),
          _buildNavItem(2, defaultIcon: 'assets/navbar3_false.svg', selectedIcon: 'assets/navbar3_true.svg'),
          _buildNavItem(3, defaultIcon: 'assets/navbar4_false.svg', selectedIcon: 'assets/navbar4_true.svg'),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, {required String defaultIcon, required String selectedIcon}) {
    final bool isSelected = _selectedIndex == index;

    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
          },
          child: SvgPicture.asset(
            isSelected ? selectedIcon : defaultIcon,
            width: 44,
            height: 44,
          ),
        ),
      ),
    );
  }
}
