abstract class IApiClient{
  // ignore: non_constant_identifier_names
  Future findOrCreateUser(String email, String provide_id, String provider);
  // ignore: non_constant_identifier_names
  Future getUser(String provider, String provider_id);
  Future updateUser(String userid,String name, String phoneNumber, String postcode, String address, String receiveNotifications, String provider);
  Future getMenuTypes(String shopID);
  Future getMenuItens(String menuTypeID);
  Future getMenuExtras(String menuItemID);
  Future getMenuChoices(String menuItemID);
  Future listShops(bool openedShops);
  Future sendMessage(String name, String reply, String message);
  Future getImages(String menuTypeID);
  Future addMenuItem(String userID, String shopID, String menuItemID, String menuExtras, int menuChoice);
  Future getCheckout(String userID,String shopID);
  Future confirmCheckout(String userID,String shopID, List<int> deliveryOrCollect);
  Future plusItemCheckout(String userID,String shopID, String checkoutItemID);
  Future minusItemCheckout(String userID,String shopID, String checkoutItemID);
  Future plusTipCheckout(String userID,String shopID);
  Future minusTipCheckout(String userID,String shopID);
  Future deleteItemCheckout(String userID,String shopID, String checkoutItemID);
}