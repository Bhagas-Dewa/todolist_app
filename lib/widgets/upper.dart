import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_application_todolist/widgets/searchbar.dart'; // Pastikan import ini ada!

class Upper extends StatelessWidget {
  const Upper({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF4864EC),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hello,',
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
              ),
            ),
            const Text(
              'Cristiano Ronaldo',
              style: TextStyle(
                fontSize: 33,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            const CustomSearchBar(),
          ],
          
        ),
      ),
    );
  }
}
