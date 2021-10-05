// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:new_york_delivery_app/app/interfaces/IAPI_client.interface.dart';
import 'package:new_york_delivery_app/app/interfaces/IClientHttp.interface.dart';

class ApiClientRepository implements IApiClient {
  final IHttp client;
  static String mainURL =
      'http://www.ftcdevsolutions.com/newyorkdelidelivery/api/';

  ApiClientRepository({required this.client});

  @override
  Future findOrCreateUser(
      String email, String provider_id, String provider) async {
    Response result = await client.get(mainURL + 'customer/find',
        {"email": email, "provider_id": provider_id, "provider": provider});
    return result;
  }

  @override
  Future getUser(String provider, String provider_id) async {
    Response result = await client.get(mainURL + 'customer/find',
        {"provider": provider, "provider_id": provider_id});
    return result;
  }

  @override
  Future updateUser(
      String userid,
      String name,
      String phoneNumber,
      String postcode,
      String address,
      String receiveNotifications,
      String provider) async {
    Response result = await client.get(mainURL + 'customer/update/$userid', {
      "name": name,
      "phoneNumber": phoneNumber,
      "postcode": postcode,
      "address": address,
      "receiveNotifications": receiveNotifications,
      "provider": provider
    });

    return result;
  }

  @override
  Future getMenuTypes(String shopID) async {
    Response result = await client.get(mainURL + 'menutype/all/$shopID', {});
    return result;
  }

  @override
  Future getMenuItens(String menuTypeID) async {
    Response result = await client.get(mainURL + 'menuitem/all/$menuTypeID', {});
    return result;
  }

  @override
  Future getMenuExtras(String menuItemID) async {
    Response result = await client.get(mainURL + 'menuextra/all/$menuItemID', {});
    return result;
  }

  @override
  Future getMenuChoices(String menuItemID) async {
    Response result = await client.get(mainURL + 'menuchoice/all/$menuItemID', {});
    return result;
  }

  @override
  Future listShops(bool openedShops) async {
    Response result = await client.get(mainURL + 'shop/all/$openedShops', {});
    return result;
  }

  @override
  Future sendMessage(String name, String reply, String message) async {
    Response result = await client.get(mainURL + 'contactus/send', {
      "name":name, 
      "reply":reply,
      "message":message
    });
    return result;
  }

  @override
  Future getImages(String menuTypeID) async{
   Response result = await client.get('http://www.ftcdevsolutions.com/newyorkdelidelivery/api/menuitem/image/103',{});
   return result;
  }

  @override
  Future addMenuItem(String userID, String shopID, String menuItemID, List<int> menuExtras, int menuChoice) async{
    // http://www.ftcdevsolutions.com/newyorkdelidelivery/api/
    // http://www.ftcdevsolutions.com/newyorkdelidelivery/api/checkout/additem/ONZHER7tLmd5wgkgqEWhQZOqfuX2/4?menuitem_id=16&menuExtras=26&menuChoices=1
    Response result = await client.get(mainURL + 'checkout/additem/$userID/$shopID',{
      "menuitem_id":menuItemID,
      "menuExtras":menuExtras,
      "menuChoices":menuChoice
    });

    return result;
    
  }

 
}
