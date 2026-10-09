import '../../../core/network/api_client.dart';
import '../../../data/models/car_part.dart';
import '../../repositories/car_part_repository.dart';
import '../use_case.dart';

class ListCarPartsUseCase extends UseCase<List<CarPart>, String> {
  final ICarPartRepository _repository;

  ListCarPartsUseCase(this._repository);

  @override
  Future<Result<List<CarPart>>> call(String carId) =>
      _repository.listParts(carId);
}

class GetCarPartUseCase extends UseCase<CarPart?, GetCarPartParams> {
  final ICarPartRepository _repository;

  GetCarPartUseCase(this._repository);

  @override
  Future<Result<CarPart?>> call(GetCarPartParams params) =>
      _repository.getPart(params.carId, params.partId);
}

class GetCarPartParams {
  final String carId;
  final String partId;

  GetCarPartParams({required this.carId, required this.partId});
}

class UpsertCarPartUseCase extends UseCase<CarPart, UpsertCarPartParams> {
  final ICarPartRepository _repository;

  UpsertCarPartUseCase(this._repository);

  @override
  Future<Result<CarPart>> call(UpsertCarPartParams params) =>
      _repository.upsertPart(params.carId, params.partId, params.request);
}

class UpsertCarPartParams {
  final String carId;
  final String partId;
  final UpsertCarPartRequest request;

  UpsertCarPartParams({
    required this.carId,
    required this.partId,
    required this.request,
  });
}

class DeleteCarPartUseCase extends UseCase<void, DeleteCarPartParams> {
  final ICarPartRepository _repository;

  DeleteCarPartUseCase(this._repository);

  @override
  Future<Result<void>> call(DeleteCarPartParams params) =>
      _repository.deletePart(params.carId, params.partId);
}

class DeleteCarPartParams {
  final String carId;
  final String partId;

  DeleteCarPartParams({required this.carId, required this.partId});
}
