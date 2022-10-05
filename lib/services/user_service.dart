import 'package:todo_sqlite_flutter/DBHelper/repository.dart';

import '../model/user.dart';

class UserService {
  late Repository _repository;
  UserService() {
    _repository = Repository();
  }
  //save user
  saveUser(User user) async {
    return await _repository.insertData('user', user.userMap());
  }

  //get all user
  readAllUser() async {
    return await _repository.readAllData('user');
  }

  updateUser(User user) async {
    return await _repository.updateData('user', user.userMap());
  }

  deleteUser(userId) async {
    return await _repository.deleteDataById('user', userId);
  }
}
