abstract class IHttp {
  Future get(String url, Map<String, dynamic> query);
  Future post(String url, Object data);
  Future delete(String url, Object data);
}
