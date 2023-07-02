import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hafleh/core/models/user_model.dart';

class FirebaseUsers {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<List<UserModel>> getUsers() async {
    List<UserModel> users = [];

    QuerySnapshot snapshot = await usersCollection.get();

    for (var doc in snapshot.docs) {
      users.add(UserModel.fromJson(doc.data() as Map<String, dynamic>));
    }

    return users;
  }

  Future<UserModel> getUser(String uid) async {
    final user = await usersCollection.doc(uid).get();
    return UserModel.fromJson(user as Map<String, dynamic>);
  }

  Future<void> addUser(UserModel user) async {
    await usersCollection.add(user.toJson());
  }

  Future<void> updateUser(UserModel user) async {
    await usersCollection.doc(user.uid).update(user.toJson());
  }

  Future<void> deleteUser(String uid) async {
    await usersCollection.doc(uid).delete();
  }
}
