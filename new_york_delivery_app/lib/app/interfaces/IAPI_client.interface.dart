abstract class IApiClient{
  Future findOrCreateUser(String email, String provideID, String provide);
  Future getUser(String email, String password);
  Future updateUser(String name, String phoneNumber, String postcode, String address, String receiveNotifications, String provider);
  Future deleteUser();
}