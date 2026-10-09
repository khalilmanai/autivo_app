import '../../../core/network/api_client.dart';
import '../../../data/models/catalog.dart';
import '../../repositories/catalog_repository.dart';
import '../use_case.dart';

class GetMakesUseCase extends UseCase<List<String>, void> {
  final ICatalogRepository _repository;

  GetMakesUseCase(this._repository);

  @override
  Future<Result<List<String>>> call(void _) => _repository.getMakes();
}

class GetModelsUseCase extends UseCase<List<String>, String> {
  final ICatalogRepository _repository;

  GetModelsUseCase(this._repository);

  @override
  Future<Result<List<String>>> call(String make) => _repository.getModels(make);
}

class GetConfigurationsUseCase
    extends UseCase<List<VehicleConfiguration>, GetConfigurationsParams> {
  final ICatalogRepository _repository;

  GetConfigurationsUseCase(this._repository);

  @override
  Future<Result<List<VehicleConfiguration>>> call(
    GetConfigurationsParams params,
  ) => _repository.getConfigurations(
    make: params.make,
    model: params.model,
    year: params.year,
  );
}

class GetConfigurationsParams {
  final String make;
  final String model;
  final int year;

  GetConfigurationsParams({
    required this.make,
    required this.model,
    required this.year,
  });
}

class GetEnginesUseCase
    extends UseCase<List<EngineConfig>, GetConfigurationsParams> {
  final ICatalogRepository _repository;

  GetEnginesUseCase(this._repository);

  @override
  Future<Result<List<EngineConfig>>> call(GetConfigurationsParams params) =>
      _repository.getEngines(
        make: params.make,
        model: params.model,
        year: params.year,
      );
}

class GetTransmissionsUseCase
    extends UseCase<List<TransmissionConfig>, GetConfigurationsParams> {
  final ICatalogRepository _repository;

  GetTransmissionsUseCase(this._repository);

  @override
  Future<Result<List<TransmissionConfig>>> call(
    GetConfigurationsParams params,
  ) => _repository.getTransmissions(
    make: params.make,
    model: params.model,
    year: params.year,
  );
}

class GetSpecsUseCase extends UseCase<List<VehicleSpec>, GetSpecsParams> {
  final ICatalogRepository _repository;

  GetSpecsUseCase(this._repository);

  @override
  Future<Result<List<VehicleSpec>>> call(GetSpecsParams params) => _repository
      .getSpecs(make: params.make, model: params.model, year: params.year);
}

class GetSpecsParams {
  final String make;
  final String? model;
  final int? year;

  GetSpecsParams({required this.make, this.model, this.year});
}

class GetYearsUseCase extends UseCase<List<int>, GetYearsParams> {
  final ICatalogRepository _repository;

  GetYearsUseCase(this._repository);

  @override
  Future<Result<List<int>>> call(GetYearsParams params) =>
      _repository.getYears(make: params.make, model: params.model);
}

class GetYearsParams {
  final String make;
  final String model;

  GetYearsParams({required this.make, required this.model});
}
