import 'package:flutter/material.dart';
import 'package:flutter_application_todolist/providers/task_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class LowerTask extends StatefulWidget {
  const LowerTask({super.key});

  @override
  State<LowerTask> createState() => _LowerTaskState();
}

class _LowerTaskState extends State<LowerTask> {
  int hour = TimeOfDay.now().hour;
  int minute = TimeOfDay.now().minute;

  @override
  Widget build(BuildContext context) {
     final taskProvider = Provider.of<TaskProvider>(context);
    return Container(
      height: 380,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF4864EC),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "EDIT TIME",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                SvgPicture.asset(
                  'assets/indicator_today.svg',
                  width: 30,
                ),
                const SizedBox(height: 10),

                // Time Picker
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Picker Jam (0-23)
                      NumberPicker(
                        minValue: 0,
                        maxValue: 23,
                        value: hour,
                        zeroPad: true,
                        infiniteLoop: true,
                        itemWidth: 80,
                        itemHeight: 60,
                        onChanged: (value) {
                          setState(() {
                            hour = value;
                          });
                          taskProvider.setSelectedTime(TimeOfDay(hour: hour, minute: minute)); // Perbarui ke provider
                        },
                        textStyle: const TextStyle(color: Color(0xff526FFF), fontSize: 20, fontWeight: FontWeight.bold),
                        selectedTextStyle: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                      ),

                      const Text(":", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),

                      // Picker Menit (0-59)
                      NumberPicker(
                        minValue: 0,
                        maxValue: 59,
                        value: minute,
                        zeroPad: true,
                        infiniteLoop: true,
                        itemWidth: 80,
                        itemHeight: 60,
                        onChanged: (value) {
                          setState(() {
                            minute = value;
                          });
                          taskProvider.setSelectedTime(TimeOfDay(hour: hour, minute: minute)); // Perbarui ke provider
                        },
                        textStyle: const TextStyle(color: Color(0xff526FFF), fontSize: 20, fontWeight: FontWeight.bold),
                        selectedTextStyle: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                      ),

                    ],
                  ),
                ),

                const SizedBox(height: 21),

                // Button Save & Cancel
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Tombol Cancel (Menutup BottomSheet)
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 120,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xff5371FF),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // Tombol Save (Menyimpan Waktu)
                   GestureDetector(
                      onTap: () {
                        final taskProvider = Provider.of<TaskProvider>(context, listen: false);

                        if (taskProvider.selectedTime == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Silakan pilih waktu!"),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }

                        // Simpan waktu yang dipilih
                        taskProvider.setSelectedTime(taskProvider.selectedTime!);

                        Navigator.pop(context);
                      },

                      child: Container(
                        width: 120,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xffFF7C54),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
