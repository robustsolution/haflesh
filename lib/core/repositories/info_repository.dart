import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hafleh/core/models/info_model.dart';

class InfoRepository {
  final infoModel = InfoModel();
  final CollectionReference infoCollection =
      FirebaseFirestore.instance.collection('infos');

  Future<InfoModel?> getInfoById(String uid) async {
    try {
      DocumentSnapshot snapshot = await infoCollection.doc(uid).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        return InfoModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<InfoModel> createInfo(InfoModel info) async {
    // insert new info into firebase database;
    return infoModel;
  }

  Future<void> updateInfo(InfoModel info) async {
    // update info
  }

  Future<void> deleteInfo(String uid) async {
    // delete info
  }
}
