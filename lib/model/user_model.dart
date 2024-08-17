import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:verification/utils/const.dart';

class UserModel {
  String? userId;
  String emailId;
  String password;
  String userType;
  String name;
  String number;
  String profile;

  UserModel(
      {required this.emailId,
      this.userId,
      required this.password,
      required this.userType,
      required this.name,
      required this.number,
      required this.profile});

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'emailId': emailId,
        'password': password,
        'userType': userType,
        'name': name,
        'number': number,
        'profile': profile,
      };

  factory UserModel.fromJson(DocumentSnapshot<Map<String, dynamic>> json) {
    return UserModel(
      userId: json.id,
      emailId: json['emailId'] ?? '',
      password: json['password'] ?? '',
      userType: json['userType'] ?? '',
      name: json['name'] ?? '',
      number: json['number'] ?? '',
      profile: json['profile'] ?? '',
    );
  }

  static List<UserModel> allUsers = List<UserModel>.empty(growable: true);

  static UserModel userModelDetails = UserModel(
      userId: '',
      profile: '',
      name: '',
      password: '',
      emailId: '',
      userType: USER_TYPE,
      number: '');
}
