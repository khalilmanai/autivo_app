import '../../../core/constants/endpoints/catalog_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../models/catalog.dart';

class CatalogApi extends BaseApi {
  CatalogApi(super.dio);

  Future<Result<List<String>>> getMakes() => apiGet<List<String>>(
    CatalogEndpoints.makes,
    fromJson: (json) => (json as List).map((e) => e as String).toList(),
    dataKey: 'makes',
  );

  Future<Result<List<String>>> getModels(String make) => apiGet<List<String>>(
    CatalogEndpoints.models,
    queryParameters: {'make': make},
    fromJson: (json) => (json as List).map((e) => e as String).toList(),
    dataKey: 'models',
  );

  Future<Result<List<VehicleConfiguration>>> getConfigurations({
    required String make,
    required String model,
    required int year,
  }) => apiGet<List<VehicleConfiguration>>(
    CatalogEndpoints.configurations,
    queryParameters: {'make': make, 'model': model, 'year': year},
    fromJson: (json) => (json as List)
        .map((e) => VehicleConfiguration.fromJson(e as Map<String, dynamic>))
        .toList(),
    dataKey: 'configurations',
  );

  Future<Result<List<EngineConfig>>> getEngines({
    required String make,
    required String model,
    required int year,
  }) => apiGet<List<EngineConfig>>(
    CatalogEndpoints.engines,
    queryParameters: {'make': make, 'model': model, 'year': year},
    fromJson: (json) => (json as List)
        .map((e) => EngineConfig.fromJson(e as Map<String, dynamic>))
        .toList(),
    dataKey: 'engines',
  );

  Future<Result<List<TransmissionConfig>>> getTransmissions({
    required String make,
    required String model,
    required int year,
  }) => apiGet<List<TransmissionConfig>>(
    CatalogEndpoints.transmissions,
    queryParameters: {'make': make, 'model': model, 'year': year},
    fromJson: (json) => (json as List)
        .map((e) => TransmissionConfig.fromJson(e as Map<String, dynamic>))
        .toList(),
    dataKey: 'transmissions',
  );

  Future<Result<List<VehicleSpec>>> getSpecs({
    required String make,
    String? model,
    int? year,
  }) async {
    final queryParams = <String, dynamic>{'make': make};
    if (model != null) queryParams['model'] = model;
    if (year != null) queryParams['year'] = year;
    return apiGet<List<VehicleSpec>>(
      CatalogEndpoints.specs,
      queryParameters: queryParams,
      fromJson: (json) => (json as List)
          .map((e) => VehicleSpec.fromJson(e as Map<String, dynamic>))
          .toList(),
      dataKey: 'specs',
    );
  }

  /// Years for which the backend actually holds data for this model, newest
  /// first. The year picker is driven from this instead of guessing a range.
  Future<Result<List<int>>> getYears({
    required String make,
    required String model,
  }) => apiGet<List<int>>(
    CatalogEndpoints.years,
    queryParameters: {'make': make, 'model': model},
    fromJson: (json) => (json as List)
        .map((e) => (e as num).toInt())
        .toList()
      ..sort((a, b) => b.compareTo(a)),
    dataKey: 'years',
  );
}
