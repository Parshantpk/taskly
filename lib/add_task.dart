import 'package:flutter/material.dart';
import './models/task.dart';
import 'package:taskly/main.dart' as main;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddTask extends StatefulWidget {
  AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  DateTime? _dateTime;
  String? _newTaskContent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Center(
              child: Text(
                'Add Task',
                style: TextStyle(fontSize: 24),
              ),
            ),
            TextField(
              onChanged: (_value) {
                setState(() {
                  _newTaskContent = _value;
                  print(_newTaskContent);
                });
              },
              decoration: const InputDecoration(
                hintText: 'Task Title',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                DatePicker.showDateTimePicker(context, showTitleActions: true,
                    onChanged: (date) {
                  print(
                      'change $date in time zone ${date.timeZoneOffset.inHours}');
                }, onConfirm: (date) {
                  _dateTime = date;
                  print('confirm $date');
                }, currentTime: DateTime.now());
              },
              child: const Text('Select Date/Time'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_newTaskContent != null && _dateTime != null) {
                  print('$_newTaskContent, $_dateTime');
                  var _task = Task(
                      content: _newTaskContent!,
                      timeStamp: _dateTime!,
                      done: false);
                  main.box.add(_task.toMap());
                  setState(() {
                    // _newTaskContent = null;
                    // _dateTime = null;
                    Navigator.pop(context);
                  });
                }
              },
              child: const Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
