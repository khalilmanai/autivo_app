import '../../../core/network/api_client.dart';
import '../../../data/models/maintenance.dart';
import '../../repositories/maintenance_repository.dart';
import '../use_case.dart';

class ListMaintenanceUseCase extends UseCase<List<Maintenance>, String> {
  final IMaintenanceRepository _repository;

  ListMaintenanceUseCase(this._repository);

  @override
  Future<Result<List<Maintenance>>> call(String carId) =>
      _repository.listMaintenance(carId);
}

class GetMaintenanceUseCase extends UseCase<Maintenance, GetMaintenanceParams> {
  final IMaintenanceRepository _repository;

  GetMaintenanceUseCase(this._repository);

  @override
  Future<Result<Maintenance>> call(GetMaintenanceParams params) =>
      _repository.getMaintenance(params.carId, params.id);
}

class GetMaintenanceParams {
  final String carId;
  final String id;

  GetMaintenanceParams({required this.carId, required this.id});
}

class CreateMaintenanceUseCase
    extends UseCase<Maintenance, CreateMaintenanceParams> {
  final IMaintenanceRepository _repository;

  CreateMaintenanceUseCase(this._repository);

  @override
  Future<Result<Maintenance>> call(CreateMaintenanceParams params) =>
      _repository.createMaintenance(params.carId, params.request);
}

class CreateMaintenanceParams {
  final String carId;
  final CreateMaintenanceRequest request;

  CreateMaintenanceParams({required this.carId, required this.request});
}

class UpdateMaintenanceUseCase
    extends UseCase<Maintenance, UpdateMaintenanceParams> {
  final IMaintenanceRepository _repository;

  UpdateMaintenanceUseCase(this._repository);

  @override
  Future<Result<Maintenance>> call(UpdateMaintenanceParams params) =>
      _repository.updateMaintenance(params.carId, params.id, params.request);
}

class UpdateMaintenanceParams {
  final String carId;
  final String id;
  final UpdateMaintenanceRequest request;

  UpdateMaintenanceParams({
    required this.carId,
    required this.id,
    required this.request,
  });
}

class DeleteMaintenanceUseCase extends UseCase<void, DeleteMaintenanceParams> {
  final IMaintenanceRepository _repository;

  DeleteMaintenanceUseCase(this._repository);

  @override
  Future<Result<void>> call(DeleteMaintenanceParams params) =>
      _repository.deleteMaintenance(params.carId, params.id);
}

class DeleteMaintenanceParams {
  final String carId;
  final String id;

  DeleteMaintenanceParams({required this.carId, required this.id});
}
