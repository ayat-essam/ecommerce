
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/error/exceptions.dart';
import 'auth_local_data_source.dart';

class AuthSharedPrefLocalDataSource extends AuthLocalDataSource {
  @Singleton(as: AuthLocalDataSource)
final SharedPreferences sharedpref;
AuthSharedPrefLocalDataSource(this.sharedpref);

  @override
  Future<void> saveToken(String token) async {
    try {
      await sharedpref.setString(CacheConstants.tokenKey, token);
    }catch(exception){
      throw const LocalException('failed to save token');
    }
  }

  @override
  Future<String> getToken() async {
    try{
      return sharedpref.getString(CacheConstants.tokenKey)!;
    }catch(exception){
      throw const LocalException('failed to get token');
    }
  }
}
