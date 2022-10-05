import 'package:flutter/material.dart';
import 'package:todo_sqlite_flutter/screens/add_user.dart';
import 'package:todo_sqlite_flutter/screens/edit_user.dart';
import 'package:todo_sqlite_flutter/screens/view_user.dart';
import 'package:todo_sqlite_flutter/services/user_service.dart';

import 'model/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<User> _userList = [];
  final _userService = UserService();
  getAllUser() async {
    var _users = await _userService
        .readAllUser(); //get all data from database and put to _users
    _userList = <User>[];
    _users.forEach((user) {
      setState(() {
        var userModel = User();
        userModel.id = user['id'];
        userModel.name = user['name'];
        userModel.mobile = user['mobile'];
        userModel.description = user['description'];
        _userList.add(userModel);
      });
    });
  }

  showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void initState() {
    getAllUser();
    super.initState();
  }

  _deleteUserData(BuildContext context, userId) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Are You Sure to Delete'),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    var result = await _userService.deleteUser(userId);
                    if (result != null) {
                      getAllUser();
                      showSnackBar('User Detail Deleted Success');
                    }
                    Navigator.pop(context);
                  },
                  child: Text('Delete'),
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close')),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sqlite Flutter CRUD'),
      ),
      body: ListView.builder(
          itemCount: _userList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewUser(_userList[index])));
                },
                leading: Icon(Icons.person),
                title: Text(_userList[index].name),
                subtitle: Text(_userList[index].mobile),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditUser(_userList[index])))
                              .then((value) {
                            if (value != null) {
                              getAllUser();
                              showSnackBar('User Detail Updated Success');
                            }
                          });
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.teal,
                        )),
                    IconButton(
                        onPressed: () {
                          _deleteUserData(context, _userList[index].id);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddUser(),
            ),
          ).then((value) {
            if (value != null) {
              getAllUser();
              showSnackBar('User Detail Added Success');
            }
          });
        },
      ),
    );
  }
}
