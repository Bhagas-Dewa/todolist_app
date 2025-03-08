import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_application_todolist/home/task/appBarTask.dart';
import 'package:flutter_application_todolist/widgets/upper_task.dart';
import 'package:flutter_application_todolist/widgets/lower_task.dart';

class BuildTask extends StatelessWidget {
  BuildTask({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: UpperTask(),
    );
  }
}
