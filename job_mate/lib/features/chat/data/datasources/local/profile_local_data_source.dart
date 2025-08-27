import 'package:job_mate/features/chat/domain/entities/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileLocalDataSource {
  static const String _keyPrefix='profile';

  Future<void> saveProfile(Profile profile) async{
    final prefs=await SharedPreferences.getInstance();
    await prefs.setString('$_keyPrefix${profile.cvId}', profile.originalText);

  }
  Future<Profile?> getProfile(int cvId) async{
    final prefs=await SharedPreferences.getInstance();
    final text=prefs.getString('$_keyPrefix$cvId');

    return text != null ? Profile(cvId: cvId,userId:1,originalText:  text) : null;
  }
}