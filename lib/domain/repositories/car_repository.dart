import '../../core/network/api_client.dart';
import '../../data/models/car.dart';
import '../../data/models/vin_decode.dart';

abstract class ICarRepository {
  Future<Result<Car>> createCar(CreateCarRequest request);
  Future<Result<List<Car>>> listCars();
  Future<Result<Car>> getCar(String id);
  Future<Result<Car>> updateCar(String id, UpdateCarRequest request);
  Future<Result<void>> deleteCar(String id);
  Future<Result<VinDecodeResult>> decodeVin(String vin);
}
