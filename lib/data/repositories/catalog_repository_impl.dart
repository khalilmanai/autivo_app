import '../../core/network/api_client.dart';
import '../../domain/repositories/catalog_repository.dart';
import '../datasources/remote/catalog_api.dart';
import '../models/catalog.dart';

class CatalogRepository implements ICatalogRepository {
  final CatalogApi _api;

  CatalogRepository(this._api);

  @override
  Future<Result<List<String>>> getMakes() => _api.getMakes();

  @override
  Future<Result<List<String>>> getModels(String make) => _api.getModels(make);

  @override
  Future<Result<List<VehicleConfiguration>>> getConfigurations({
    required String make,
    required String model,
    required int year,
  }) => _api.getConfigurations(make: make, model: model, year: year);

  @override
  Future<Result<List<EngineConfig>>> getEngines({
    required String make,
    required String model,
    required int year,
  }) => _api.getEngines(make: make, model: model, year: year);

  @override
  Future<Result<List<TransmissionConfig>>> getTransmissions({
    required String make,
    required String model,
    required int year,
  }) => _api.getTransmissions(make: make, model: model, year: year);

  @override
  Future<Result<List<VehicleSpec>>> getSpecs({
    required String make,
    String? model,
    int? year,
  }) => _api.getSpecs(make: make, model: model, year: year);

  @override
  Future<Result<List<int>>> getYears({
    required String make,
    required String model,
  }) => _api.getYears(make: make, model: model);
}
