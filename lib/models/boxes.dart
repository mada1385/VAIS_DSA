import 'package:hive/hive.dart';
import 'package:vaisdsa/models/session.dart';

class Boxes {
  static Box<Session> getTransactions() => Hive.box<Session>('Session');
}
