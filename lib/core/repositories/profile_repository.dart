import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hafleh/core/models/profile_model.dart';

class ProfileRepository {
  final profileModel = ProfileModel();
  final CollectionReference profileCollection =
      FirebaseFirestore.instance.collection('profiles');

  Future<ProfileModel?> getProfileById(String uid) async {
    try {
      DocumentSnapshot snapshot = await profileCollection.doc(uid).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        return ProfileModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ProfileModel> createProfile(ProfileModel profile) async {
    // insert new profile into firebase database;
    return profileModel;
  }

  Future<void> updateProfile(ProfileModel profile) async {
    // update profile
  }

  Future<void> deleteProfile(String uid) async {
    // delete profile
  }
}
