import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:util/database/task_box.dart';
import 'package:util/models/task/task.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:util/screens/task/widgets/task_input_dialog.dart';
import 'package:util/service_widgets/datetime_to_date.dart';
import 'package:util/utility/changable.dart';

import 'colors/task_colors.dart';

class CalenderTask extends StatefulWidget {
  const CalenderTask({Key? key}) : super(key: key);

  @override
  _CalenderTaskState createState() => _CalenderTaskState();
}

class _CalenderTaskState extends State<CalenderTask> {

  CalendarFormat cformat = CalendarFormat.week;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[100],
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        title: Text(
          "Calender Task",
          style: TextStyle(
              color: Colors.black
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          _showCalendar(),

          Expanded(
              child: _showList()
          )

        ],
      )
    );
  }

  _showCalendar(){
    return Container(

      decoration: BoxDecoration(


      ),
      child: TableCalendar(

        focusedDay: focusedDay,
        firstDay: DateTime.utc(2010, 10, 6),
        lastDay: DateTime.utc(2050, 10, 6),
        calendarFormat: cformat,
        onFormatChanged: (_format){
          setState(() {
            cformat=_format;
          });
        },
        selectedDayPredicate: (day){
          return isSameDay(selectedDay, day);
        },

        onDaySelected: (sd, fd){
          setState(() {
            selectedDay=sd;

            focusedDay=fd;

            theDate=selectedDay;
            print(toDate(theDate));

          });
        },

      ),
    );
  }

  _showList(){
    return ValueListenableBuilder<Box<Task>>(

      builder: (context, box, _) {

        final tasks = box.values.where((element) => element.date==toDate(selectedDay)).toList().cast<Task>().reversed.toList();

        return ListView.builder(

            itemCount: tasks.length,
            itemBuilder: (context, index){
              final item = tasks[index];
              return item.description!.length !=0? GestureDetector(

                child: Dismissible(
                  background: Container(
                    color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        !item.completed ? Icon(Icons.check, color: Colors.white,):Icon(Icons.radio_button_unchecked, color: Colors.white,),
                        SizedBox(width: 5,),
                        Text(!item.completed?"Completed":"Not completed?", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),


                      ],
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Delete", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        SizedBox(width: 5,),
                        Icon(Icons.delete_forever, color: Colors.white,)
                      ],
                    ),
                  ),
                  onDismissed: (DismissDirection direction){
                    if(direction==DismissDirection.startToEnd){
                      completeTaskorNot(item);
                    }else{
                      deleteTask(item);
                    }

                  },
                  key: UniqueKey(),

                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width*.9,
                      margin: EdgeInsets.symmetric(vertical:5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20)

                      ),
                      child: ExpansionTile(

                        leading: Icon(
                          !item.completed ? Icons.circle:Icons.check_circle_outline,
                          color: item.importance==0?t_noimp:item.importance==1?t_imp:Colors.blueAccent,

                        ),
                        title: Text(item.task, style: TextStyle(fontWeight: FontWeight.bold),),
                        children: [
                          ListTile(
                            subtitle: Center(child: Text(item.description!)),

                          )
                        ],

                      ),
                    ),
                  ),
                ),
                onLongPress: (){
                  _EditDialog(item, context);
                },
              ): Dismissible(
                background: Container(color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      !item.completed ? Icon(Icons.check, color: Colors.white,):Icon(Icons.radio_button_unchecked, color: Colors.white,),
                      SizedBox(width: 5,),
                      Text(!item.completed?"Completed":"Not completed?", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),


                    ],
                  ),
                ),
                secondaryBackground: Container(color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Delete", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      SizedBox(width: 5,),
                      Icon(Icons.delete_forever, color: Colors.white,)
                    ],
                  ),
                ),
                onDismissed: (direction){
                  if(direction==DismissDirection.startToEnd){
                    completeTaskorNot(item);
                  }else{
                    deleteTask(item);
                  }
                },

                key: UniqueKey(),
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width*.9,
                    margin: EdgeInsets.symmetric(vertical:5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20)

                    ),
                    child: ListTile(

                      leading: Icon(
                        !item.completed ? Icons.circle:Icons.check_circle_outline,
                        color: item.importance==0?t_noimp:item.importance==1?t_imp:Colors.blueAccent,

                      ),
                      title: Text(item.task, style: TextStyle(fontWeight: FontWeight.bold),),
                      onLongPress: (){
                        _EditDialog(item, context);
                      },
                    ),
                  ),
                ),
              );
            }
        );
      },
      valueListenable: TaskBox.getTasks().listenable(),

    );
  }

  _EditDialog(Task tk, BuildContext ctx) {
    TextEditingController taskController = TextEditingController();
    TextEditingController descController = TextEditingController();
    taskController.text = tk.task;
    descController.text = tk.description!;
    bool vis = tk.description!.length==0?false:true;
    int selected=tk.importance;


    showTaskDialog(ctx, vis, selected, taskController, descController, tk: tk);


  }
}
