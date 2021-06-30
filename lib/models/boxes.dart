import 'package:hive/hive.dart';
import 'package:vaisdsa/models/session.dart';
import 'package:vaisdsa/models/user.dart';

class Boxes {
  static Box<Session> getTransactions() => Hive.box<Session>('Session');
  static Box<User> getUsers() => Hive.box<User>('user');
}
