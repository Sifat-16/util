
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:util/main.dart';


import 'package:util/screens/task/calender_task_screen.dart';
import 'package:util/screens/task/today_Task_screen.dart';
import 'package:util/screens/task/widgets/task_input_dialog.dart';


class TaskScreen extends StatefulWidget {
   TaskScreen({Key? key}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  int current_index=0;
  PageController _pageController = PageController(initialPage: 0);
  var currentSelectedValue;
  int current_selected=0;
  TextEditingController taskController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {


    return isVtask!=0?Scaffold(

        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(child: Lottie.asset("assets/swipe.json", height: MediaQuery.of(context).size.height*.2)),
            Text("Slide right the to complete the Task", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),),
            Center(child: Lottie.asset("assets/slf.json", height: MediaQuery.of(context).size.height*.2)),
            Text("Slide left to delete the Task",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
            )),
            Center(child: Lottie.asset("assets/press.json", height: MediaQuery.of(context).size.height*.2)),
            Text("Press and hold to Edit the Task",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
            )),
            ElevatedButton(onPressed: () async{
              setState(() {
                isVtask=0;
              });
              SharedPreferences preferences = await SharedPreferences.getInstance();

              await preferences.setInt("isVtask", isVtask!);

            }, child: Text("Ready"))

          ],
        ),

    ): Scaffold(




        body: PageView(
          controller: _pageController,
          onPageChanged: (index){
            setState(() {
              current_index=index;
            });
          },
          scrollDirection: Axis.horizontal,
            children: [
              TodayTask(),
              CalenderTask()
            ],
        ),


        bottomNavigationBar: BottomNavigationBar(
          currentIndex: current_index,
          selectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          onTap: (index){
            _pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
          },
          backgroundColor: Colors.grey[200],
            elevation: 0,
            items: [
          BottomNavigationBarItem(

              icon: Icon(Icons.today),
            label: "Today's Tasks"
          ),

              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: "Calender Tasks"
              ),
        ]),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[100],

        elevation: 2,
        onPressed: () {
          current_index==0 ? showTaskDialog(context, false, 0, taskController, descController):showTaskDialog(context, false, 0, taskController, descController);
      },
        child: Icon(Icons.add, color: Colors.black,),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }






}




