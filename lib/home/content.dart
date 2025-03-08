import 'package:flutter/material.dart';
import 'package:flutter_application_todolist/widgets/upper.dart';
import 'package:flutter_application_todolist/widgets/lower.dart';

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Upper(),
        Lower(),
      ],
    );
  }
}