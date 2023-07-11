import 'package:flutter/material.dart';
import 'package:task_manager/pages/edit.dart';
import 'package:task_manager/pages/pushnotifications.dart';
import 'package:task_manager/pages/taskcreation.dart';
import 'package:task_manager/pages/imagepicker.dart';


class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  Map<String, dynamic> data = {
    'task': '',
    'date':'',
    'taskId':'',

  };
  List<Map<String, dynamic>> tasks = [];
  List<Map<String, dynamic>> completedTasks = [];
  @override
  Widget build(BuildContext context) {
     data= data.isNotEmpty ? data :ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print(data);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Task Manager",style: const TextStyle(
              fontSize: 21.0,
              color: Colors.white,
              fontFamily: 'Lato'
          )),
          elevation: 0.0,
          backgroundColor: Colors.indigoAccent,
        ),
        body: Column(
          children: [
          Container(
          color: Colors.indigoAccent,
          child: TabBar(
              indicatorColor: Colors.white,
              tabs: [
              Tab(icon: Icon(Icons.list,color: Colors.white,)),
              Tab(icon: Icon(Icons.playlist_add_check_outlined,color: Colors.white,)),
                Tab(icon: Icon(Icons.camera,color: Colors.white,)),
                Tab(icon: Icon(Icons.notifications,color: Colors.white,))
            ])
          ),
        Expanded(
            child:TabBarView(children: [
              Container(
                child: Center(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> taskData = tasks[index];
                      return Card(
                        elevation: 4,
                        child: ListTile(
                          title: Text(
                            taskData['task'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lato-Regular'
                            ),
                          ),
                          subtitle: Text(
                            taskData['date'],
                            style: TextStyle(
                              fontSize: 14,
                                fontFamily: 'Lato-Regular'
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () async{
                              dynamic result = await Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => EditTaskPage(taskData: taskData)),
                              );
                              print(result);
                              // Check if a result was received

                              if (result != null) {
                                setState(() {
                                  int taskIndex = tasks.indexWhere((task) => task['id'] == taskData['id']);

                                  if (taskIndex != -1) {
                                    if (result['_isComplete'] == true) {
                                      tasks.removeAt(taskIndex);
                                      completedTasks.add(result);
                                    } else {
                                      tasks[taskIndex] = result;
                                    }
                                  }
                                });
                              }

                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: ListView.builder(
                    itemCount: completedTasks.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> taskData = completedTasks[index];
                      return Card(
                        elevation: 4,
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                taskData['task'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Lato-Regular',
                                ),
                              ),
                              SizedBox(height: 3,),
                              Text(
                                taskData['date'],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Lato-Regular',
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 2),
                            ],

                          ),

                          subtitle: Text(
                            'task completed',
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Lato-Italic',
                                color: Colors.indigoAccent

                            ),
                          ),

                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                            setState(() {
                              completedTasks.removeAt(index);
                            });
                          },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Imagepicker(),
              PushNoitifications(),
            ])
        ),
          ],
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(right: 16.0),
         child: FloatingActionButton(
            onPressed: () async {
              // Add your desired functionality when the FAB is pressed
              dynamic result = await Navigator.push(context, MaterialPageRoute(builder: (context) => taskcreation()));
              if(result != null){
                setState(() {
                  data = {
                     'id':result['id'],
                    'task': result['task'],
                    'date': result['date'],
                  };
                  print(data);
                  tasks.add(data);
                });
              }
            },
            backgroundColor: Colors.indigoAccent, // Set the background color of the FAB
            foregroundColor: Colors.white, // Set the color of the FAB icon
            elevation: 4.0, // Set the elevation of the FAB

            child: Icon(Icons.add),
          ),
        )

      ),

    );
  }
}
