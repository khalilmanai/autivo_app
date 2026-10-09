import '../../core/network/api_client.dart';
import '../../data/models/catalog.dart';

abstract class ICatalogRepository {
  Future<Result<List<String>>> getMakes();
  Future<Result<List<String>>> getModels(String make);
  Future<Result<List<VehicleConfiguration>>> getConfigurations({
    required String make,
    required String model,
    required int year,
  });
  Future<Result<List<EngineConfig>>> getEngines({
    required String make,
    required String model,
    required int year,
  });
  Future<Result<List<TransmissionConfig>>> getTransmissions({
    required String make,
    required String model,
    required int year,
  });
  Future<Result<List<VehicleSpec>>> getSpecs({
    required String make,
    String? model,
    int? year,
  });
  Future<Result<List<int>>> getYears({
    required String make,
    required String model,
  });
}
