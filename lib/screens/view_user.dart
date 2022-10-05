import 'package:flutter/material.dart';

import '../model/user.dart';

class ViewUser extends StatefulWidget {
  final User user;
  ViewUser(this.user);

  @override
  State<ViewUser> createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sqlite Flutter CRUD'),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Full Details',
              style: TextStyle(fontSize: 17, color: Colors.teal),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Name: ${widget.user.name}',
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Mobile: ${widget.user.mobile}',
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Description: ${widget.user.description}',
            ),
          ],
        ),
      ),
    );
  }
}
