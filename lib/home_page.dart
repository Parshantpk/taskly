import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskly/models/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double _deviceHeigth;
  String? _newTaskContent;
  Box? _box;


  @override
  Widget build(BuildContext context) {

    _deviceHeigth = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Taskly',
          style: TextStyle(fontSize: 25),
        ),
        toolbarHeight: _deviceHeigth * 0.15,
      ),
      body: _tasksView(),
      floatingActionButton: _addTaskButton(),
    );
  }

  Widget _tasksView() {
    Hive.openBox('tasks');
    return FutureBuilder(
        future: Hive.openBox('tasks'),
        builder: (BuildContext _context, AsyncSnapshot _snapshot) {
          // if (_snapshot.connectionState == ConnectionState.done) {
          //   if (_snapshot.hasError) {
          //     return Text(_snapshot.error.toString());
          //   } else {
          //     return Text('doesnot have errr');
          //     Hive.openBox('tasks');}
          // }
          if (_snapshot.hasData) {
            _box = _snapshot.data;
            print("the data in hive ${_box?.length}");
            return _taskList();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _taskList() {
    // Task _newTask =
    //     Task(content: 'Do Gym!', timeStamp: DateTime.now(), done: false);
    // _box?.add(_newTask.toMap());
    List tasks = _box!.values.toList();
    return ListView.builder(
      itemCount: tasks?.length,
      itemBuilder: (BuildContext _context, int _index) {
        var task = Task.fromMap(tasks[_index]);
        return ListTile(
          title: Text(
            task.content,
            style: TextStyle(
              decoration: task.done ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(
            task.timeStamp.toString(),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                task.done
                    ? Icons.check_box_outlined
                    : Icons.check_box_outline_blank_outlined,
                color: Colors.red,
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _box!.deleteAt(_index);
                  });
                },
                icon: Icon(Icons.delete),
              )
            ],
          ),
          onTap: () {
            task.done = !task.done;
            _box!.putAt(
              _index,
              task.toMap(),
            );
            setState(() {});
          },
          onLongPress: () {
            setState(() {
              _box!.deleteAt(_index);
            });
          },
        );
      },
    );
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      onPressed: () {
        //_displayTaskPopup();
        Navigator.pushNamed(context, '/second');
      },
      child: const Icon(Icons.add),
    );
  }

  // void _displayTaskPopup() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext _context) {
  //       return AlertDialog(
  //         title: Text('Add New Task!'),
  //         content: TextField(
  //           onSubmitted: (_) {
  //             if (_newTaskContent != null) {
  //               var _task = Task(
  //                   content: _newTaskContent!,
  //                   timeStamp: DateTime.now(),
  //                   done: false);
  //               _box!.add(_task.toMap());
  //               setState(() {
  //                 _newTaskContent = null;
  //                 Navigator.pop(context);
  //               });
  //             }
  //           },
  //           onChanged: (_value) {
  //             setState(() {
  //               _newTaskContent = _value;
  //             });
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }
}
