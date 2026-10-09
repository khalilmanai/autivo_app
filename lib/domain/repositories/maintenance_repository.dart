import '../../core/network/api_client.dart';
import '../../data/models/maintenance.dart';

abstract class IMaintenanceRepository {
  Future<Result<List<Maintenance>>> listMaintenance(String carId);
  Future<Result<Maintenance>> getMaintenance(String carId, String id);
  Future<Result<Maintenance>> createMaintenance(
    String carId,
    CreateMaintenanceRequest request,
  );
  Future<Result<Maintenance>> updateMaintenance(
    String carId,
    String id,
    UpdateMaintenanceRequest request,
  );
  Future<Result<void>> deleteMaintenance(String carId, String id);
}
