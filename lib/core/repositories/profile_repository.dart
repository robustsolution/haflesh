import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hafleh/core/models/profile_model.dart';

class ProfileRepository {
  final profileModel = ProfileModel();
  final CollectionReference profileCollection =
      FirebaseFirestore.instance.collection('profiles');

  Future<ProfileModel?> getProfileById(String uid) async {
    try {
      final profile = await profileCollection.doc("iryClcHOtYrIpWmB7AlH").get();
      return ProfileModel.fromJson(profile as Map<String, dynamic>);
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
