class Api {
  /// Base API Endpoint
  static const _baseServer = "http://103.226.139.188";

  /// * -------------------
  ///  * Restaurants Endpoint
  ///  * ------------------
  ///  * In this field will exists
  ///  * some route about restaurants
  /// */
  String getCategory = "$_baseServer/api/v1/category";
  String getCategoryProduct = "$_baseServer/api/v1/showCategoryWithProduct";
  String getTagProduct = "$_baseServer/api/v1/tagProducts";

  String getVoucher = "$_baseServer/api/v1/getAvailableVoucher";
  String claimVoucher = "$_baseServer/api/v1/claim-voucher";
  String myVoucher = "$_baseServer/api/v1/my-voucher";
  
  String products = "$_baseServer/api/v1/productCity";
  String productSearch = "$_baseServer/api/v1/products/search";


  //Address
    String address = "$_baseServer/api/v1/address";
    String selectedAddress = "$_baseServer/api/v1/mainAddress";
  String checkCity = "$_baseServer/api/v1/checkCity";
}
