import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_todolist/providers/task_provider.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF304CC4),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  Provider.of<TaskProvider>(context, listen: false).searchTask(value);
                },
                decoration: const InputDecoration(
                  hintText: "Cari task...",
                  hintStyle: TextStyle(
                    color: Color(0xff4864EC),
                  ),
                  border: InputBorder.none,
                ),
                
              ),
            ),
            SvgPicture.asset(
              'assets/icon_search.svg',
              height: 26,
              width: 26,
            ),
          ],
        ),
      ),
    );
  }
}
