class CarEndpoints {
  static const String cars = '/cars';
  static const String decodeVin = '/cars/decode-vin';
  static String byId(String id) => '/cars/$id';
  static String parts(String carId) => '/cars/$carId/parts';
  static String partById(String carId, String partId) =>
      '/cars/$carId/parts/$partId';
  static String maintenance(String carId) => '/cars/$carId/maintenance';
  static String maintenanceById(String carId, String id) =>
      '/cars/$carId/maintenance/$id';
}
