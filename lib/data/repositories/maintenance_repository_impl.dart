import '../../core/network/api_client.dart';
import '../../domain/repositories/maintenance_repository.dart';
import '../datasources/remote/maintenance_api.dart';
import '../models/maintenance.dart';

class MaintenanceRepository implements IMaintenanceRepository {
  final MaintenanceApi _api;

  MaintenanceRepository(this._api);

  @override
  Future<Result<List<Maintenance>>> listMaintenance(String carId) =>
      _api.listMaintenance(carId);

  @override
  Future<Result<Maintenance>> getMaintenance(String carId, String id) =>
      _api.getMaintenance(carId, id);

  @override
  Future<Result<Maintenance>> createMaintenance(
    String carId,
    CreateMaintenanceRequest request,
  ) => _api.createMaintenance(carId, request);

  @override
  Future<Result<Maintenance>> updateMaintenance(
    String carId,
    String id,
    UpdateMaintenanceRequest request,
  ) => _api.updateMaintenance(carId, id, request);

  @override
  Future<Result<void>> deleteMaintenance(String carId, String id) =>
      _api.deleteMaintenance(carId, id);
}
