import '../../core/network/api_client.dart';
import '../../data/models/car_part.dart';

abstract class ICarPartRepository {
  Future<Result<List<CarPart>>> listParts(String carId);
  Future<Result<CarPart?>> getPart(String carId, String partId);
  Future<Result<CarPart>> upsertPart(
    String carId,
    String partId,
    UpsertCarPartRequest request,
  );
  Future<Result<void>> deletePart(String carId, String partId);
}
