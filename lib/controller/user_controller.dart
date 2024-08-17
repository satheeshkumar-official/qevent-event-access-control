import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:verification/model/user_model.dart';
import 'package:verification/utils/session_manager.dart';

String collectionName = 'Users';

class UserController {
  final _db = FirebaseFirestore.instance.collection(collectionName);

  addUser(UserModel userModel) async {
    userModel.userId = _db.id;
    await _db.add(userModel.toJson());
  }

  Future<List<UserModel>> retrieveUsers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db.get();
    return snapshot.docs
        .map((docSnapshot) => UserModel.fromJson(docSnapshot))
        .toList();
  }

  updateUser(UserModel updatedUser) async {
    String? userId = await SessionManager().getUserId();
    if (userId != null) {
      await _db.doc(userId).update(updatedUser.toJson());
    }
  }

  updateFCMToken(String fcmToken) async {
    String? id = await SessionManager().getUserId();
    await _db.doc(id).update({"fcmToken": fcmToken});
  }
}
