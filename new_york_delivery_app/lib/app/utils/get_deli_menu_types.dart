import 'package:shared_preferences/shared_preferences.dart';

Future<int?> getMenuTypesDeliObject() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? menuTypes = prefs.getInt('menuTypes');
    return menuTypes;
}