import '../../../core/constants/endpoints/car_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../models/car_part.dart';

class CarPartApi extends BaseApi {
  CarPartApi(super.dio);

  Future<Result<List<CarPart>>> listParts(String carId) =>
      apiGet<List<CarPart>>(
        CarEndpoints.parts(carId),
        fromJson: (json) => (json as List)
            .map((e) => CarPart.fromJson(e as Map<String, dynamic>))
            .toList(),
        dataKey: 'parts',
      );

  Future<Result<CarPart?>> getPart(String carId, String partId) =>
      apiGet<CarPart?>(
        CarEndpoints.partById(carId, partId),
        fromJson: (json) => CarPart.fromJson(json as Map<String, dynamic>),
        allowNull: true,
        dataKey: 'part',
      );

  Future<Result<CarPart>> upsertPart(
    String carId,
    String partId,
    UpsertCarPartRequest request,
  ) => apiPut<CarPart>(
    CarEndpoints.partById(carId, partId),
    data: request.toJson(),
    fromJson: (json) => CarPart.fromJson(json as Map<String, dynamic>),
    dataKey: 'part',
  );

  Future<Result<void>> deletePart(String carId, String partId) =>
      apiDelete(CarEndpoints.partById(carId, partId));
}
