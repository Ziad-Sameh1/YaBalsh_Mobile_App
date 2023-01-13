const String loginEndpoint = '/api/v1/auth/login';
const String registerEndPoint = '/api/v1/auth/register';
const String getCurrentUserEndpoint = '/api/v1/auth/me';
const String zonesEndPoint = '/api/v1/main-zones';
const String addressEndPoint = '/api/v1/addresses';
const String storesEndpoint = '/api/v1/stores';
const String ordersEndpoint = '/api/v1/orders';
const String productSearchEndpoint = '/api/v1/products/search';
const String storesSearchEndpoint = '/api/v1/stores/search';
String getAddressEndPointById(int id) => '/api/v1/addresses/$id';
String getStoreEndPointById(int id) => '/api/v1/stores/$id';
String getProductEndPointById(int id) => '/api/v1/products/$id';
String getSubZonesEndPointById(int id) => '$zonesEndPoint/$id/sub-zones';
