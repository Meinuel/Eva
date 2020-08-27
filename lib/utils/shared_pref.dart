import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs{

  getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //final String user = prefs.getString('user');
    final List<String> user = prefs.getStringList('user');
    return user;
  }

  setUser(String user, String pass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.setString('user', user);
    prefs.setStringList('user', [user,pass]);
    return true;
  }
  }