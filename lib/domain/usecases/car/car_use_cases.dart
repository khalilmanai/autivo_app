import '../../../core/network/api_client.dart';
import '../../../data/models/car.dart';
import '../../../data/models/vin_decode.dart';
import '../../repositories/car_repository.dart';
import '../use_case.dart';

class CreateCarUseCase extends UseCase<Car, CreateCarRequest> {
  final ICarRepository _repository;

  CreateCarUseCase(this._repository);

  @override
  Future<Result<Car>> call(CreateCarRequest request) =>
      _repository.createCar(request);
}

class ListCarsUseCase extends UseCase<List<Car>, void> {
  final ICarRepository _repository;

  ListCarsUseCase(this._repository);

  @override
  Future<Result<List<Car>>> call(void _) => _repository.listCars();
}

class GetCarUseCase extends UseCase<Car, String> {
  final ICarRepository _repository;

  GetCarUseCase(this._repository);

  @override
  Future<Result<Car>> call(String id) => _repository.getCar(id);
}

class UpdateCarUseCase extends UseCase<Car, UpdateCarParams> {
  final ICarRepository _repository;

  UpdateCarUseCase(this._repository);

  @override
  Future<Result<Car>> call(UpdateCarParams params) =>
      _repository.updateCar(params.id, params.request);
}

class UpdateCarParams {
  final String id;
  final UpdateCarRequest request;

  UpdateCarParams({required this.id, required this.request});
}

class DeleteCarUseCase extends UseCase<void, String> {
  final ICarRepository _repository;

  DeleteCarUseCase(this._repository);

  @override
  Future<Result<void>> call(String id) => _repository.deleteCar(id);
}

class DecodeVinUseCase extends UseCase<VinDecodeResult, String> {
  final ICarRepository _repository;

  DecodeVinUseCase(this._repository);

  @override
  Future<Result<VinDecodeResult>> call(String vin) =>
      _repository.decodeVin(vin);
}
