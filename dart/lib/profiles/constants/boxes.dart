import 'package:dart/profiles/constants/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Boxes {
  static Box<UserData> getUserData() => Hive.box<UserData>('loggedUser');
}
