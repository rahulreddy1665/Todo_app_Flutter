import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

class EditTaskPage extends StatefulWidget {
  final Map<String, dynamic>? taskData;

  const EditTaskPage({Key? key, this.taskData}) : super(key: key);

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late TextEditingController _taskController;
  bool _isComplete = false;
  String _selectedDateTime = '';

  @override
  void initState() {
    super.initState();
    _taskController = TextEditingController(text: widget.taskData?['task'] ?? '');
    _selectedDateTime = widget.taskData?['date'] ?? '';
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Task"),
        backgroundColor: Colors.indigoAccent,
      ),
      body:  Padding(
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
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            TextFormField(
              controller: _taskController,
              decoration: InputDecoration(labelText: 'Task'),
            ),
            SizedBox(height: 16),
            DateTimePicker(
              initialValue: _selectedDateTime,
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
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _isComplete,
                  onChanged: (value) {
                    setState(() {
                      _isComplete = value!;
                    });
                  },
                ),
                Text(
                  'Mark it as Complete',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato-Regular',
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String updatedTask = _taskController.text;
                String updatedDate = _selectedDateTime;
                // Create an updatedTaskData map with the updated values
                Map<String, dynamic> updatedTaskData = {
                  'task': updatedTask,
                  'date': updatedDate,
                  '_isComplete':_isComplete
                };

                // Perform update logic using the updated values

                Navigator.pop(context, updatedTaskData);
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), // Set the border radius value
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.indigoAccent),
              ),
              child: Text(
                'Update',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato-Regular',
                ),
              ),
            ),
            SizedBox(height: 8),

          ],
        ),
      ),
    )
    );
  }
}
