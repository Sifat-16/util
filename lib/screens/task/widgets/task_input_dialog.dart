import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:util/database/task_box.dart';
import 'package:util/models/task/task.dart';
import 'package:util/service_widgets/datetime_to_date.dart';
import 'package:util/utility/changable.dart';

showTaskDialog(BuildContext context, bool vis, int selected, TextEditingController taskController, TextEditingController descController, {Task? tk}) {
  bool deletetask=taskController.text.length==0?false:true;
  bool deletedesk=descController.text.length==0?false:true;
  bool errortextenabled=false;

  TimeOfDay? tm;
  if(tk!=null&&tk.time!=null){
    var s = tk.time!.split(":");
    //print(s);
    tm = TimeOfDay(hour: int.parse(s[0]), minute: int.parse(s[1]));
    print(tm.period);
  }

  return AwesomeDialog(
      onDissmissCallback: (dismiss){
        taskController.clear();
        descController.clear();
      },
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.NO_HEADER,
      body: StatefulBuilder(

          builder: (context, setState) {
            return Column(
              children: [
                Text(tk==null?"Add Task":"Edit Task"),
                SizedBox(height: 10,),

                TextField(

                  controller: taskController,
                  onChanged: (value){
                    if(value.length>0){
                      setState((){
                        errortextenabled=false;
                        deletetask=true;
                      });
                    }else{
                      setState((){
                        deletetask=false;
                      });
                    }
                  },
                  decoration: InputDecoration(
                      errorText: errortextenabled?"Must input task":null,

                      labelText: "Task",
                      suffixIcon: !deletetask && taskController.text.length==0 ? Icon(Icons.edit, size: 15,):GestureDetector(
                        child: Icon(Icons.delete, size: 15,),
                        onTap: (){
                          setState((){
                            deletetask=false;
                            taskController.clear();
                          });

                        },
                      ),
                      border: OutlineInputBorder(

                      )

                  ),
                ),
                SizedBox(height: 10,),

                Visibility(
                    visible: !vis,
                    child: TextButton(onPressed: (){
                      print(vis);
                      setState(() {
                        vis = !vis;
                      });
                    }, child: Text("Add Description?", style: TextStyle(color: Colors.black54),))
                ),

                Visibility(
                  visible: vis,
                  child: TextField(
                    controller: descController,
                    onChanged: (value){
                      if(value.length>0){
                        setState((){
                          deletedesk=true;
                        });
                      }else{
                        setState((){
                          deletedesk=false;
                        });
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Description",
                        suffixIcon: !deletedesk ? Icon(Icons.edit, size: 15,):GestureDetector(
                          child: Icon(Icons.delete, size: 15,),
                          onTap: (){
                            setState((){
                              deletedesk=false;
                              descController.clear();
                            });

                          },
                        ),
                        border: OutlineInputBorder(

                        )

                    ),
                  ),
                ),

                SizedBox(height: 10,),

                Text("Priority"),
                Column(

                  children: [
                    Switch(
                        inactiveThumbColor: Colors.blue,
                        inactiveTrackColor: Colors.blueAccent[100],
                        activeColor: Colors.red,
                        activeTrackColor: Colors.redAccent[100],
                        value: selected==0?false:true,
                        onChanged: (std){
                          setState((){
                            if(selected==0){
                              selected=1;
                            }else{
                              selected=0;
                            }
                          });
                        }
                    ),
                    Visibility(
                        visible: selected==0?true:false,
                        child: Text("Low", style: TextStyle(fontWeight: FontWeight.bold),)
                    ),
                    Visibility(
                        visible: selected==1?true:false,
                        child: Text("High", style: TextStyle(fontWeight: FontWeight.bold),)
                    )
                  ],
                ),
                TextButton(onPressed: ()async{

                    tm = await showTimePicker(context: context, initialTime: tm==null?TimeOfDay.now():tm!,);

                    setState((){
                      tm;
                    });


                  print(tm);


                }, child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.watch_later_outlined, color: Colors.orange,),
                    Text(tm==null?"Select Time":"${tm!.hour}:${tm!.minute}", style: TextStyle(
                      color: Colors.blue
                    ),),
                    Icon(Icons.watch_later_outlined, color: Colors.orange,),
                  ],
                )),
                TextButton(
                  onPressed: (){
                    if(taskController.text.length==0){
                        setState((){
                          errortextenabled=true;
                        });
                    }else{

                      tk==null ? addTask(taskController.text, descController.text, selected, false, toDate(theDate), tm==null?null:"${tm!.hour}:${tm!.minute}:${tm!.period.index}"):editTask(tk, taskController.text, descController.text, selected, false, toDate(theDate), tm==null?null:"${tm!.hour}:${tm!.minute}:${tm!.period.index}");
                      Navigator.pop(context);
                    }

                  },
                  child: tk==null ? Text("Add"):Text("Edit"),

                ),


              ],
            );
          }
      ),


  )..show();

}