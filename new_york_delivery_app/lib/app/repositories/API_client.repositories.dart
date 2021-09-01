import 'package:dio/dio.dart';
import 'package:new_york_delivery_app/app/interfaces/IAPI_client.interface.dart';
import 'package:new_york_delivery_app/app/interfaces/IClientHttp.interface.dart';
import 'package:new_york_delivery_app/app/services/ClientHttp.Service.dart';

class ApiClientRepository implements IApiClient{
  final IHttp client;
  static String mainURL = 'http://www.ftcdevsolutions.com/newyorkdelidelivery/api/';

  ApiClientRepository({required this.client});

  @override
  Future deleteUser() async{
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future findOrCreateUser(String email, String provideID, String provide) async{
    // TODO: implement findOrCreateUser
    throw UnimplementedError();
  }

  @override
  Future getUser(String email, String password) async{
    Response result = await client.get(mainURL+'user/get', {"email":email,"password":password});
    print("Passei 2");
    return result;
  }

  @override
  Future updateUser(String name, String phoneNumber, String postcode, String address, String receiveNotifications, String provider) async{
    // TODO: implement updateUser
    throw UnimplementedError();
  }

}