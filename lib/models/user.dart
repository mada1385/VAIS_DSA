import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 3)
class User extends HiveObject {
  @HiveField(1)
  final String username;
  @HiveField(2)
  final String password;
  @HiveField(3)
  final bool superuser;

  User(this.username, this.password, this.superuser);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['super'] = this.superuser;
    return data;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['username'],
      json['password'],
      json['super'],
    );
  }
}
