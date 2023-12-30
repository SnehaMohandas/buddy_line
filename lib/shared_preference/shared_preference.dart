import 'package:shared_preferences/shared_preferences.dart';

class CommonFunction{

  static addDataToSharedPreferences(String key,dynamic value) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(key == 'username'){
      await prefs.setString(key, value);
    }
    else if( key == 'token'){
      await prefs.setString(key, value);
    }
    else if( key == 'userId'){
      await prefs.setString(key, value);
    }
    else{
      prefs.clear();
    }


  }

  static getSavedKey(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? values = prefs.getString(key);
    return values;
  }

}