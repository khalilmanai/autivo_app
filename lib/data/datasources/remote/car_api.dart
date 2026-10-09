import '../../../core/constants/endpoints/car_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../models/car.dart';
import '../../models/vin_decode.dart';

class CarApi extends BaseApi {
  CarApi(super.dio);

  Future<Result<Car>> createCar(CreateCarRequest request) => apiPost<Car>(
    CarEndpoints.cars,
    data: request.toJson(),
    fromJson: (json) => Car.fromJson(json as Map<String, dynamic>),
    dataKey: 'car',
  );

  Future<Result<List<Car>>> listCars() => apiGet<List<Car>>(
    CarEndpoints.cars,
    fromJson: (json) => (json as List)
        .map((e) => Car.fromJson(e as Map<String, dynamic>))
        .toList(),
    dataKey: 'cars',
  );

  Future<Result<Car>> getCar(String id) => apiGet<Car>(
    CarEndpoints.byId(id),
    fromJson: (json) => Car.fromJson(json as Map<String, dynamic>),
    dataKey: 'car',
  );

  Future<Result<Car>> updateCar(String id, UpdateCarRequest request) =>
      apiPatch<Car>(
        CarEndpoints.byId(id),
        data: request.toJson(),
        fromJson: (json) => Car.fromJson(json as Map<String, dynamic>),
        dataKey: 'car',
      );

  Future<Result<void>> deleteCar(String id) => apiDelete(CarEndpoints.byId(id));

  Future<Result<VinDecodeResult>> decodeVin(String vin) =>
      apiPost<VinDecodeResult>(
        CarEndpoints.decodeVin,
        data: {'vin': vin},
        fromJson: (json) {
          final map = json as Map<String, dynamic>;
          final decoded = map['decoded'];
          if (decoded is Map) {
            return VinDecodeResult.fromJson({...map, ...decoded});
          }
          return VinDecodeResult.fromJson(map);
        },
      );
}
