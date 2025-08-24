
import 'package:flutter/foundation.dart';
import 'package:flutter_ecommerce/model/User.dart';
import 'package:flutter_ecommerce/service/UserService.dart';

class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();
  List<User> _user = [];

  List<User> get user => _user;

  Future<void> fetchUsers() async {
    try {
      _user = await _userService.getUser();
      notifyListeners();
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  Future<void> addUser(User user) async {
    try {
      final newUser = await _userService.createUser(user);
      _user.add(newUser);
      notifyListeners();
    } catch (e) {
      print('Error adding user : $e');
    }
  }

  Future<void> updateUser(User user) async {
    try {
      final updateUser = await _userService.updateUser(user);
      final index = _user.indexWhere((t) => t.id == updateUser.id);
      if (index != -1) {
        _user[index] = updateUser;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      await _userService.deleteUser(id);
      _user.removeWhere((user) => user.id == id);
      notifyListeners();
    } catch (e) {
      print('Error deleting user: $e');
    }
  }
}
