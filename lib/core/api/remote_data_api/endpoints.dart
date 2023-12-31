const String loginEndpoint = '/api/v1/auth/login';
const String registerEndPoint = '/api/v1/auth/register';
const String checkUserRegisteredEndpoint = '/api/v1/auth/status';
const String getCurrentUserEndpoint = '/api/v1/auth/me';
const String zonesEndPoint = '/api/v1/main-zones';
const String addressEndPoint = '/api/v1/addresses';
const String storesEndpoint = '/api/v1/stores';
const String nearStoresEndpoint = '/api/v1/stores/near-stores';
const String sectionsEndpoint = '/api/v1/sections';
const String ordersEndpoint = '/api/v1/orders';
const String productSearchEndpoint = '/api/v1/products/search';
const String mainCategoriesEndpoint = '/api/v1/main-categories';
const String bannersEndpoint = '/api/v1/banners';
const String recipiesEndpoint = '/api/v1/recipes';
const String brandsEndpoint = '/api/v1/brands';
const String notificationsEndpoint = '/api/v1/notifications';
const String storesSearchEndpoint = '/api/v1/stores/search';
const String devicesEndpoint = '/api/v1/devices';
const String productBarcodeEndpoint = '/api/v1/products/barcode';
const String productRelevantsEndpoint = '/api/v1/products/relevant';
const String flyersEndpoint = '/api/v1/flyers';
String getAddressEndPointById(int id) => '/api/v1/addresses/$id';
String getRecipieDetailsEndPointById(int id) => '$recipiesEndpoint/$id';
String getStoreEndPointById(int id) => '/api/v1/stores/$id';
String getProductEndPointById(int id) => '/api/v1/products/$id';
String getSubZonesEndPointById(int id) => '$zonesEndPoint/$id/sub-zones';
String getSubCategoriesEndPointById(int id) =>
    '$mainCategoriesEndpoint/$id/sub-categories';
String getSectionProductsEndpoint(int id) => '$sectionsEndpoint/$id/products';
String getSubCategoryProductsEndpoint(int id) =>
    '/api/v1/sub-categories/$id/products';
String getMainCategoriesProductsEndpoint(int id) =>
    '$mainCategoriesEndpoint/$id/products';
String getBrandsRecipiesEndpoint(int id) => '$brandsEndpoint/$id/recipes';
String getProductEndPointByBarcode(String barcode) =>
    '$productBarcodeEndpoint/$barcode';
String getProductsRelevantsById(int id) => '$productRelevantsEndpoint/$id';
String getFlyersEndpoint() => flyersEndpoint;
String getFlyerEndpointById(int id) => '$flyersEndpoint/$id';
