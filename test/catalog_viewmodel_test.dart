import 'package:autivo/core/network/api_client.dart';
import 'package:autivo/data/models/catalog.dart';
import 'package:autivo/domain/repositories/catalog_repository.dart';
import 'package:autivo/domain/usecases/usecases.dart';
import 'package:autivo/presentation/viewmodels/catalog_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

/// Builds a ViewModel on top of a fake repository, so the search/filter
/// behaviour is exercised without any network access.
CatalogViewModel _buildViewModel({
  List<String> makes = const [],
  List<String> models = const [],
  List<int> years = const [],
  List<EngineConfig> engines = const [],
  List<TransmissionConfig> transmissions = const [],
}) {
  final repo = _FakeCatalogRepository(
    makes: makes,
    models: models,
    years: years,
    engines: engines,
    transmissions: transmissions,
  );
  return CatalogViewModel(
    GetMakesUseCase(repo),
    GetModelsUseCase(repo),
    GetConfigurationsUseCase(repo),
    GetEnginesUseCase(repo),
    GetTransmissionsUseCase(repo),
    GetSpecsUseCase(repo),
    GetYearsUseCase(repo),
  );
}

void main() {
  group('CatalogViewModel make search', () {
    test('returns every make when the query is empty or whitespace', () async {
      final vm = _buildViewModel(makes: ['Toyota', 'Ford']);
      await vm.loadMakes();

      expect(vm.filteredMakes, ['Toyota', 'Ford']);

      vm.setMakeQuery('   ');
      expect(vm.filteredMakes, ['Toyota', 'Ford']);
    });

    test('matches case-insensitively on a substring', () async {
      final vm = _buildViewModel(makes: ['Toyota', 'Ford', 'Ferrari']);
      await vm.loadMakes();

      vm.setMakeQuery('rr');
      expect(vm.filteredMakes, ['Ferrari']);

      vm.setMakeQuery('FORD');
      expect(vm.filteredMakes, ['Ford']);
    });

    test('ignores accents so unaccented queries still match', () async {
      final vm = _buildViewModel(makes: ['Renault', 'Citroën', 'Peugeot']);
      await vm.loadMakes();

      vm.setMakeQuery('renault');
      expect(vm.filteredMakes, contains('Renault'));

      vm.setMakeQuery('citroen');
      expect(vm.filteredMakes, contains('Citroën'));
    });

    test('ignores separators so punctuated names stay searchable', () async {
      final vm = _buildViewModel(
        makes: ['Mercedes-Benz', 'Land Rover', 'HR-V', 'Alfa Romeo'],
      );
      await vm.loadMakes();

      vm.setMakeQuery('mercedes');
      expect(vm.filteredMakes, ['Mercedes-Benz']);

      vm.setMakeQuery('landrover');
      expect(vm.filteredMakes, ['Land Rover']);

      vm.setMakeQuery('hrv');
      expect(vm.filteredMakes, ['HR-V']);

      vm.setMakeQuery('romeo');
      expect(vm.filteredMakes, ['Alfa Romeo']);
    });

    test('keeps non-Latin names searchable', () async {
      final vm = _buildViewModel(makes: ['بيجو', 'تويوتا', 'نيسان']);
      await vm.loadMakes();

      vm.setMakeQuery('تويوتا');
      expect(vm.filteredMakes, ['تويوتا']);
    });

    test(
      'returns empty when nothing matches but keeps the source list',
      () async {
        final vm = _buildViewModel(makes: ['Toyota', 'Ford']);
        await vm.loadMakes();

        vm.setMakeQuery('zzz');
        expect(vm.filteredMakes, isEmpty);
        // Unfiltered source is untouched, so clearing the query restores it.
        expect(vm.makes, ['Toyota', 'Ford']);
      },
    );

    test('filtered results are unmodifiable', () async {
      final vm = _buildViewModel(makes: ['Toyota']);
      await vm.loadMakes();

      expect(() => vm.filteredMakes.add('Hacked'), throwsUnsupportedError);
    });

    test('notifies only when the effective query changes', () async {
      final vm = _buildViewModel(makes: ['Toyota', 'Ford']);
      await vm.loadMakes();

      var notifications = 0;
      vm.addListener(() => notifications++);

      vm.setMakeQuery('to');
      expect(notifications, 1);

      // Same effective query: no rebuild storm on every keystroke.
      vm.setMakeQuery('to');
      expect(notifications, 1);
    });
  });

  group('CatalogViewModel model search', () {
    test('picking a new make clears the previous model query', () async {
      final vm = _buildViewModel(models: ['Corolla', 'Camry']);
      await vm.loadMakes();

      vm.setModelQuery('cor');
      expect(vm.modelQuery, 'cor');

      await vm.loadModels('Ford');
      expect(vm.modelQuery, isEmpty);
      expect(vm.filteredModels, ['Corolla', 'Camry']);
    });

    test('filters models and survives an accent-insensitive query', () async {
      final vm = _buildViewModel(models: ['Civic', 'Odyssey', 'HR-V']);
      await vm.loadModels('Honda');

      vm.setModelQuery('civ');
      expect(vm.filteredModels, ['Civic']);

      vm.setModelQuery('hrv');
      expect(vm.filteredModels, ['HR-V']);
    });

    test(
      'clearSelection resets the model query but keeps the make query',
      () async {
        final vm = _buildViewModel(makes: ['Toyota', 'Ford']);
        await vm.loadMakes();
        await vm.loadModels('Toyota');

        vm.setMakeQuery('ford');
        vm.setModelQuery('cor');

        vm.clearSelection();

        expect(vm.modelQuery, isEmpty);
        expect(vm.filteredModels, isEmpty);
        // Returning to the makes tab keeps the brand search the user typed.
        expect(vm.makeQuery, 'ford');
      },
    );
  });

  group('CatalogViewModel year list', () {
    test('loadYears returns the years the backend reported', () async {
      final vm = _buildViewModel(years: [2024, 2020, 2015]);

      final years = await vm.loadYears('Honda', 'Civic');

      expect(years, [2024, 2020, 2015]);
      expect(vm.years, [2024, 2020, 2015]);
    });

    test('years are unmodifiable', () async {
      final vm = _buildViewModel(years: [2024]);
      await vm.loadYears('Honda', 'Civic');

      expect(() => vm.years.add(1999), throwsUnsupportedError);
    });

    test('clearSelection drops the year list', () async {
      final vm = _buildViewModel(years: [2024]);
      await vm.loadYears('Honda', 'Civic');
      expect(vm.years, isNotEmpty);

      vm.clearSelection();

      expect(vm.years, isEmpty);
    });

    test('picking a new make drops the previous year list', () async {
      final vm = _buildViewModel(models: ['Civic'], years: [2024]);
      await vm.loadYears('Honda', 'Civic');
      expect(vm.years, [2024]);

      await vm.loadModels('Toyota');

      expect(vm.years, isEmpty);
    });

    test('a model with no data yields an empty list, not an error', () async {
      final vm = _buildViewModel(years: const []);

      final years = await vm.loadYears('Honda', 'NeverExisted');

      expect(years, isEmpty);
      expect(vm.error, isNull);
    });

    test(
      'loadYears does not flip the shared loading flag',
      () async {
        // The year bottom sheet renders its own progress indicator; flipping
        // the global flag would blank the whole catalog tab behind the sheet.
        final vm = _buildViewModel(years: [2024]);
        var sawLoading = false;
        vm.addListener(() {
          if (vm.isLoading) sawLoading = true;
        });

        await vm.loadYears('Honda', 'Civic');

        expect(sawLoading, isFalse);
      },
    );

    test('selecting a year loads engines and transmissions', () async {
      final vm = _buildViewModel(
        engines: const [
          EngineConfig(
            name: '1.5L Turbo',
            displacementCc: 1498,
            cylinders: 4,
            powerHp: 181,
            fuelType: 'Gasoline',
          ),
        ],
        transmissions: const [
          TransmissionConfig(name: 'CVT', type: 'CVT', gears: 7),
        ],
      );

      // Mirrors the three concurrent calls the year picker fires.
      await vm.loadConfigurations('Honda', 'Civic', 2020);
      await vm.loadEngines('Honda', 'Civic', 2020);
      await vm.loadTransmissions('Honda', 'Civic', 2020);

      expect(vm.engines, hasLength(1));
      expect(vm.transmissions, hasLength(1));
      expect(vm.selectedYear, 2020);
    });
  });
}

class _FakeCatalogRepository implements ICatalogRepository {
  _FakeCatalogRepository({
    required this.makes,
    required this.models,
    this.years = const [],
    this.engines = const [],
    this.transmissions = const [],
  });

  final List<String> makes;
  final List<String> models;
  final List<int> years;
  final List<EngineConfig> engines;
  final List<TransmissionConfig> transmissions;

  @override
  Future<Result<List<String>>> getMakes() async => Result.success(makes);

  @override
  Future<Result<List<String>>> getModels(String make) async =>
      Result.success(models);

  @override
  Future<Result<List<VehicleConfiguration>>> getConfigurations({
    required String make,
    required String model,
    required int year,
  }) async => Result.success(const []);

  @override
  Future<Result<List<EngineConfig>>> getEngines({
    required String make,
    required String model,
    required int year,
  }) async => Result.success(engines);

  @override
  Future<Result<List<TransmissionConfig>>> getTransmissions({
    required String make,
    required String model,
    required int year,
  }) async => Result.success(transmissions);

  @override
  Future<Result<List<VehicleSpec>>> getSpecs({
    required String make,
    String? model,
    int? year,
  }) async => Result.success(const []);

  @override
  Future<Result<List<int>>> getYears({
    required String make,
    required String model,
  }) async => Result.success(years);
}
