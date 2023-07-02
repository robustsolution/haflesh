import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:the_hafleh/core/models/profile_model.dart';

class ProfileRepository {
  final supabase = Supabase.instance.client;

  Future<List<ProfileModel>> getProfiles() async {
    final response = await supabase.from('profiles').select();
    if (response == null) {
      throw Exception('supabase connection problem');
    }
    return response.data!
        .map((profile) => ProfileModel.fromJson(profile))
        .toList();
  }

  Future<ProfileModel?> getProfileById(String uid) async {
    try {
      final response = await supabase
          .from('profiles')
          .select<Map<String, dynamic>>()
          .eq('uid', uid)
          .single();

      if (response.isNotEmpty) {
        return ProfileModel.fromJson(response);
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<ProfileModel> createProfile(ProfileModel profile) async {
    final response =
        await supabase.from('profiles').insert(profile.toJson()).select();
    if (response == null || response.length < 1) {
      throw Exception('supabase connection problem');
    }
    return ProfileModel.fromJson(response[0]);
  }

  Future<void> updateProfile(ProfileModel profile) async {
    final response = await supabase
        .from('profiles')
        .update(profile.toJson())
        .eq('uid', profile.uid);

    if (response == null) {
      throw Exception('supabase connection problem');
    }
  }

  Future<void> deleteProfile(String uid) async {
    final response = await supabase.from('profiles').delete().eq('uid', uid);

    if (response == null) {
      throw Exception('supabase connection problem');
    }
  }
}
