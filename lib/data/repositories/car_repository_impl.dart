import '../../core/network/api_client.dart';
import '../../domain/repositories/car_repository.dart';
import '../datasources/remote/car_api.dart';
import '../models/car.dart';
import '../models/vin_decode.dart';

class CarRepository implements ICarRepository {
  final CarApi _api;

  CarRepository(this._api);

  @override
  Future<Result<Car>> createCar(CreateCarRequest request) =>
      _api.createCar(request);

  @override
  Future<Result<List<Car>>> listCars() => _api.listCars();

  @override
  Future<Result<Car>> getCar(String id) => _api.getCar(id);

  @override
  Future<Result<Car>> updateCar(String id, UpdateCarRequest request) =>
      _api.updateCar(id, request);

  @override
  Future<Result<void>> deleteCar(String id) => _api.deleteCar(id);

  @override
  Future<Result<VinDecodeResult>> decodeVin(String vin) => _api.decodeVin(vin);
}
