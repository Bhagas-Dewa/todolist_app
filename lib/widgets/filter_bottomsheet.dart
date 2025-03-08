import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_todolist/providers/task_provider.dart';

class ShowFilterBottomSheet extends StatefulWidget {
  const ShowFilterBottomSheet({super.key});

  @override
  State<ShowFilterBottomSheet> createState() => _ShowFilterBottomSheetState();
}

class _ShowFilterBottomSheetState extends State<ShowFilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Container(
      padding: const EdgeInsets.all(16),
      height: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text(
            "Pilih Rentang Waktu",
              style: 
              TextStyle(
                fontSize: 20,
                fontWeight:
                FontWeight.bold,
                color: Colors.black,
                )
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      taskProvider.setStartDate(pickedDate);
                    }
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Color(0xff4864EC),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(taskProvider.startDate == null
                      ? "Pilih Start Date"
                      : "${taskProvider.startDate!.day}/${taskProvider.startDate!.month}/${taskProvider.startDate!.year}"),
                ),
              ),
              const Text(
                " - ", 
                style: TextStyle(
                  color: Color(0xff4864EC),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      taskProvider.setEndDate(pickedDate);
                    }
                  },
                   style: TextButton.styleFrom(
                    foregroundColor: Color(0xff4864EC),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(taskProvider.endDate == null
                      ? "Pilih End Date"
                      : "${taskProvider.endDate!.day}/${taskProvider.endDate!.month}/${taskProvider.endDate!.year}"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
               onPressed: () {
                  Provider.of<TaskProvider>(context, listen: false).clearDateFilter();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff5371FF), 
                  foregroundColor: Colors.white,
                  
                ),
                child: const Text("Reset Filter"),
              ),  SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); 
                },
                 style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: Text(
                  "Terapkan Filter",
                  style: TextStyle(),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
