import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:uuid/uuid.dart';

class taskcreation extends StatefulWidget {
  const taskcreation({Key? key}) : super(key: key);

  @override
  State<taskcreation> createState() => _taskcreationState();
}

class _taskcreationState extends State<taskcreation> {
  TextEditingController _taskController = TextEditingController();
  String _selectedDateTime = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.indigoAccent,
      ),
      body:Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Colors.indigoAccent, // Changes the text and cursor color
                ),
                inputDecorationTheme: InputDecorationTheme(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigoAccent), // Changes the border color
                  ),
                  labelStyle: TextStyle(color: Colors.indigoAccent), // Changes the label text color
                ),
              ),
              child: Column(
                children: [
                  TextFormField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      labelText: 'Enter your Task',
                    ),
                  ),
                  const SizedBox(height: 20),
                  DateTimePicker(
                    initialValue: '',
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    dateLabelText: 'Select the Date and Time',
                    onChanged: (val) => _selectedDateTime = val,
                    validator: (val) {
                      print(val);
                      return null;
                    },
                    onSaved: (val) => print(val),
                    type: DateTimePickerType.dateTime,
                  ),
                  const SizedBox(height: 30),
        Container(
          width: 600,
                  child:ElevatedButton(
                    onPressed: () {
                      // Button click event
                      print("hello");
                      // Retrieve the task and date values
                      String task = _taskController.text;
                      String date = _selectedDateTime;
                      String taskId = const Uuid().v4();
                      print(taskId);// Generate a UUID for the task
                      Navigator.pop(context, {
                        'task': task,
                        'date': date,
                        'id':taskId,
                      });
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0), // Set the border radius value
                        ),
                      ),
                    ),
                    child: Text('Save'),
                  ),
        ),
                ],
              )

            ),
          ),


        ],
      )
    );
  }
}
