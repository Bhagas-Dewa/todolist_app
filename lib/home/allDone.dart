import 'package:flutter/material.dart';
import 'package:flutter_application_todolist/home/appBar.dart';
import 'package:flutter_application_todolist/home/home.dart';
import 'package:flutter_application_todolist/home/task/addTask.dart';
import 'package:flutter_svg/svg.dart';

class AllDone extends StatefulWidget {
  const AllDone({super.key});

  @override
  State<AllDone> createState() => _AllDoneState();
}

class _AllDoneState extends State<AllDone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xff4864EC),
        ),


        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            SvgPicture.asset(
              'assets/icon_alldone.svg',
               width: 200,
               height: 200,
            ), SizedBox(height: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  Text(
                'Youre All Done For Today',
                style: 
                  TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ), SizedBox(height: 10),
                Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer at turpis eu enim rhoncus sagittis. Suspendisse ligula ex, ornare sit amet erat in, mattis fermentum risus',
                textAlign: TextAlign.center,
                style: 
                  TextStyle(
                    color: Color.fromARGB(255, 121, 139, 231),
                    fontSize: 14,
                  ),
                ), SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                  child: Container(
                    width: 170,
                    height: 55,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Color(0xffFF7C54),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )

              ],
            ),
            
          ],
        ),

        ),
        
      ),
    );
  }
}
