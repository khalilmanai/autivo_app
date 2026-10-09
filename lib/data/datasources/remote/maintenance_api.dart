import '../../../core/constants/endpoints/car_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../models/maintenance.dart';

class MaintenanceApi extends BaseApi {
  MaintenanceApi(super.dio);

  Future<Result<List<Maintenance>>> listMaintenance(String carId) =>
      apiGet<List<Maintenance>>(
        CarEndpoints.maintenance(carId),
        fromJson: (json) => (json as List)
            .map((e) => Maintenance.fromJson(e as Map<String, dynamic>))
            .toList(),
        dataKey: 'records',
      );

  Future<Result<Maintenance>> getMaintenance(String carId, String id) =>
      apiGet<Maintenance>(
        CarEndpoints.maintenanceById(carId, id),
        fromJson: (json) => Maintenance.fromJson(json as Map<String, dynamic>),
        dataKey: 'record',
      );

  Future<Result<Maintenance>> createMaintenance(
    String carId,
    CreateMaintenanceRequest request,
  ) => apiPost<Maintenance>(
    CarEndpoints.maintenance(carId),
    data: request.toJson(),
    fromJson: (json) => Maintenance.fromJson(json as Map<String, dynamic>),
    dataKey: 'record',
  );

  Future<Result<Maintenance>> updateMaintenance(
    String carId,
    String id,
    UpdateMaintenanceRequest request,
  ) => apiPatch<Maintenance>(
    CarEndpoints.maintenanceById(carId, id),
    data: request.toJson(),
    fromJson: (json) => Maintenance.fromJson(json as Map<String, dynamic>),
    dataKey: 'record',
  );

  Future<Result<void>> deleteMaintenance(String carId, String id) =>
      apiDelete(CarEndpoints.maintenanceById(carId, id));
}
