import 'package:flutter/material.dart';
import 'package:todo_sqlite_flutter/model/user.dart';

import '../services/user_service.dart';

class EditUser extends StatefulWidget {
  final User user;
  EditUser(this.user);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  var userName = TextEditingController();
  var userMobile = TextEditingController();
  var userDescription = TextEditingController();
  var key = GlobalKey<FormState>();
  @override
  void initState() {
    this.setState(() {
      userName.text = widget.user.name;
      userMobile.text = widget.user.mobile;
      userDescription.text = widget.user.description;
    });
    super.initState();
  }

  var userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sqlite Flutter CRUD'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add New User',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: userName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Name',
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This field can\'t be empty';
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: userMobile,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Mobile',
                    labelText: 'Mobile',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This field can\'t be empty';
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: userDescription,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Description',
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This field can\'t be empty';
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          if (key.currentState!.validate()) {
                            print('validated');
                            var _user = User();
                            _user.id = widget.user.id;
                            _user.name = userName.text;
                            _user.mobile = userMobile.text;
                            _user.description = userDescription.text;
                            var result = await userService.updateUser(_user);
                            print(result);
                            Navigator.pop(context, result);
                          }
                        },
                        child: const Text('Update Details')),
                    ElevatedButton(
                      onPressed: () {
                        userName.text = '';
                        userMobile.text = '';
                        userDescription.text = '';
                      },
                      child: const Text('Clear Details'),
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
