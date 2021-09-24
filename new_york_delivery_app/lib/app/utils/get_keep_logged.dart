import 'package:shared_preferences/shared_preferences.dart';

Future<bool> getKeepLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? keep = prefs.getBool('keepLogged');
    return keep ?? false;
}