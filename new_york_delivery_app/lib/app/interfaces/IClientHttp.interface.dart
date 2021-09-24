abstract class IHttp {
  Future get(String url, Map<String, dynamic> query);
  Future put(String url, Object data, Map<String, dynamic> query);
  Future post(String url, Object data, Map<String, dynamic> query);
  Future delete(String url, Object data, Map<String, dynamic> query);
}
