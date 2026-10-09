import '../../core/network/api_client.dart';
import '../../domain/repositories/car_part_repository.dart';
import '../datasources/remote/car_part_api.dart';
import '../models/car_part.dart';

class CarPartRepository implements ICarPartRepository {
  final CarPartApi _api;

  CarPartRepository(this._api);

  @override
  Future<Result<List<CarPart>>> listParts(String carId) =>
      _api.listParts(carId);

  @override
  Future<Result<CarPart?>> getPart(String carId, String partId) =>
      _api.getPart(carId, partId);

  @override
  Future<Result<CarPart>> upsertPart(
    String carId,
    String partId,
    UpsertCarPartRequest request,
  ) => _api.upsertPart(carId, partId, request);

  @override
  Future<Result<void>> deletePart(String carId, String partId) =>
      _api.deletePart(carId, partId);
}
