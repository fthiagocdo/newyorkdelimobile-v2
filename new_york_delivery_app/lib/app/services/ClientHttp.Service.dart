import 'package:dio/dio.dart';
import 'package:new_york_delivery_app/app/interfaces/IClientHttp.interface.dart';

class HttpService implements IHttp {
  final Dio client = Dio();
  @override
  Future delete(String url, Object data, Map<String, dynamic> query) async {
    Response result;

    try {
      result = await client.post(
        url,
        data: data,
        queryParameters: query != {} ? query : <String, dynamic>{},
      );
    } catch (e) {
      print(e.toString());
      return throw "Can make a DELETE request";
    }

    if (result.statusCode == 200) {
      return result;
    } else {
      return throw "StatusCode different than 200";
    }
  }

  @override
  Future get(String url, Map<String, dynamic> query) async {
    Response result;

    try {
      result = await client.get(
        url,
        queryParameters: query != {} ? query : <String, dynamic>{},
      );
    } catch (e) {
      print(e.toString());
      return throw "Can make a GET request";
    }

    if (result.statusCode == 200) {
      return result;
    } else {
      return throw "StatusCode different than 200";
    }
  }

  @override
  Future post(String url, Object data, Map<String, dynamic> query) async {
    Response result;

    try {
      result = await client.post(
        url,
        data: data,
        queryParameters: query != {} ? query : <String, dynamic>{},
      );
    } catch (e) {
      print(e.toString());
      return throw "Can make a POST request";
    }

    if (result.statusCode == 200) {
      return result;
    } else {
      return throw "StatusCode different than 200";
    }
  }
}
