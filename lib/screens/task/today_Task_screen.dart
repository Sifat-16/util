
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:lottie/lottie.dart';

import 'package:util/database/task_box.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:util/models/task/task.dart';
import 'package:util/screens/task/colors/task_colors.dart';
import 'package:util/screens/task/widgets/task_input_dialog.dart';
import 'package:util/service_widgets/datetime_to_date.dart';
import 'package:util/utility/changable.dart';


class TodayTask extends StatefulWidget {

  TodayTask({Key? key}) : super(key: key);


  @override
  _TodayTaskState createState() => _TodayTaskState();
}

class _TodayTaskState extends State<TodayTask> {


  bool imp=true;
  bool notimp=false;

  @override
  void initState(){
    // TODO: implement initState

    theDate = DateTime.now();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    Color f_t_imp = t_imp;
    Color f_t_noimp = t_noimp;
    Color curColor = t_imp;
    bool visColor = true;
    bool visFonts = false;

    return Scaffold(

        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          title: Text(
            "Task",
            style: TextStyle(
                color: Colors.black
            ),
          ),
          backgroundColor: Colors.grey[100],
          actions: [
            IconButton(onPressed:(){

              AwesomeDialog(
                  context: context,
                  dialogType: DialogType.NO_HEADER,
                  onDissmissCallback: (type){
                    if(type==DismissType.OTHER){
                      setState(() {
                        imp=true;
                        notimp=false;
                        visColor=true;
                        visFonts=false;
                      });
                    }
                  },
                  body: StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        children: [
                          Text("Customizer", style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),),
                          SizedBox(
                            height: 10,
                          ),

                         /* Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap:(){
                              setState((){
                                visColor=true;
                                visFonts=false;
                              });
                      },
                                child: Container(
                                  decoration:BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                color: visColor?Colors.lightGreen[400]:Colors.white
                      ),
                                  child: Row(

                                    children: [
                                      Icon(visColor?Icons.check_circle_outline:Icons.circle_outlined),
                                      Text("Color")
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap:(){
                                  setState((){
                                    visColor=false;
                                    visFonts=true;
                                  });
                                },
                                child: Container(
                                  decoration:BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: visFonts?Colors.lightGreen[400]:Colors.white
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(visFonts?Icons.check_circle_outline:Icons.circle_outlined),
                                      Text("Fonts")
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),*/
                          SizedBox(
                            height: 20,
                          ),

                          Visibility(
                            visible:visColor,
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  curColor = f_t_imp;
                                  imp=true;
                                  notimp=false;
                                });
                              },
                              child: Container(
                                decoration:BoxDecoration(

                                color: imp?Colors.grey[100]:Colors.white
                      ),

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    imp?Icon(Icons.check_circle_outline):Icon(Icons.circle_outlined),
                                    Text("Important"),
                                    Container(
                                      height: 20,
                                      width: 20,
                                      color: t_imp,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible:visColor,
                            child: SizedBox(
                              height: 15,
                            ),
                          ),
                          Visibility(
                            visible:visColor,
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  curColor = f_t_noimp;
                                  imp=false;
                                  notimp=true;
                                });
                              },
                              child: Container(
                                decoration:BoxDecoration(
                                color:notimp?Colors.grey[100]:Colors.white
                      ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    notimp?Icon(Icons.check_circle_outline):Icon(Icons.circle_outlined),
                                    Text("Not Important"),
                                    Container(
                                      height: 20,
                                      width: 20,
                                      color: t_noimp,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible:visColor,
                            child: SizedBox(
                              height: 10,
                            ),
                          ),
                          Visibility(
                            visible:visColor,
                            child: ColorPicker(
                              paletteType: PaletteType.hsvWithHue,
                                enableAlpha: false,
                                showLabel: false,
                                pickerColor: curColor,
                                onColorChanged: (c){
                                    if(imp){
                                      f_t_imp=c;

                                    }else{
                                      f_t_noimp=c;
                                    }
                                }
                            ),
                          ),
                          Visibility(
                            visible:visColor,
                            child: ElevatedButton(onPressed: (){
                                setState((){
                                  t_imp = f_t_imp;
                                  t_noimp = f_t_noimp;
                                });
                                Navigator.of(context).pop();
                            }, child: Text("Update")),
                          )
                        ],
                      );
                    }
                  )

              ).show();
            },icon: Icon(Icons.settings)),
          ],
        ),
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            ValueListenableBuilder<Box<Task>>(

                builder: (context, box, _) {
                    final tasks = box.values.where((element) => element.date==toDate(DateTime.now())).toList().cast<Task>().reversed.toList();

                    return Expanded(

                      child: ListView.builder(
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
                                    width: MediaQuery.of(context).size.width*.95,
                                    margin: EdgeInsets.symmetric(vertical:5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(20)

                                    ),
                                    child: ExpansionTile(

                                      leading: CircleAvatar(
                                        backgroundColor: Colors.grey[100],
                                        child: Icon(
                                          !item.completed ? Icons.circle:Icons.check_circle_outline,
                                          color: item.importance==0?t_noimp:item.importance==1?t_imp:Colors.blueAccent,

                                        ),
                                      ),
                                        title: Text(item.task,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold
                                        ),
                                        ),
                                      trailing: item.completed?Lottie.asset("assets/time_done.json", fit: BoxFit.cover, height: MediaQuery.of(context).size.height*.04, width: MediaQuery.of(context).size.height*.04):item.time!=null?Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Lottie.asset(!_checkTimeOver(item.time!)?"assets/time_green.json":"assets/time_red.json", fit: BoxFit.cover, height: MediaQuery.of(context).size.height*.04, width: MediaQuery.of(context).size.height*.04),
                                          Text(item.time!=null?"${item.time!.substring(0,item.time!.length-2)}":"", style: TextStyle(
                                            fontStyle: FontStyle.italic
                                          ),),
                                        ],
                                      ):SizedBox.shrink(),

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
                                  width: MediaQuery.of(context).size.width*.95,
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(20)

                                  ),
                                  child: ListTile(

                                    leading: CircleAvatar(

                                      backgroundColor: Colors.grey[100],
                                      child: Icon(
                                        !item.completed ? Icons.circle:Icons.check_circle_outline,
                                        color: item.importance==0?t_noimp:item.importance==1?t_imp:Colors.blueAccent,

                                      ),
                                    ),
                                    title: Text(item.task, style: TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),),

                                    trailing: item.completed?Lottie.asset("assets/time_done.json", fit: BoxFit.cover, height: MediaQuery.of(context).size.height*.04, width: MediaQuery.of(context).size.height*.04):item.time!=null? Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Lottie.asset(!_checkTimeOver(item.time!)?"assets/time_green.json":"assets/time_red.json", fit: BoxFit.cover, height: MediaQuery.of(context).size.height*.04, width: MediaQuery.of(context).size.height*.04),
                                        Text(item.time!=null?"${item.time!.substring(0,item.time!.length-2)}":"", style: TextStyle(
                                          fontStyle: FontStyle.italic
                                        ),),

                                      ],
                                    ):SizedBox.shrink(),
                                    onLongPress: (){
                                        _EditDialog(item, context);
                                    },
                                  ),
                                ),
                              ),
                            );
                          }
                      ),
                    );
                },
                valueListenable: TaskBox.getTasks().listenable(),

              ),



          ],
        ),
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

  bool _checkTimeOver(String time){

    var tm = TimeOfDay.now();
    var lst = time.split(":");
    var hr = int.parse(lst[0]);
    var mn = int.parse(lst[1]);

    if(hr<tm.hour){
      return true;
    }else if(hr==tm.hour&&mn<tm.minute){
      return true;
    }else{
      return false;
    }

  }




}
