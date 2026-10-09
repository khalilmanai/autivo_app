import 'package:flutter/material.dart';

import '../../core/network/api_exception.dart';
import '../../data/models/catalog.dart';
import '../../domain/usecases/usecases.dart';

class CatalogViewModel extends ChangeNotifier {
  final GetMakesUseCase _getMakesUseCase;
  final GetModelsUseCase _getModelsUseCase;
  final GetConfigurationsUseCase _getConfigurationsUseCase;
  final GetEnginesUseCase _getEnginesUseCase;
  final GetTransmissionsUseCase _getTransmissionsUseCase;
  final GetSpecsUseCase _getSpecsUseCase;
  final GetYearsUseCase _getYearsUseCase;

  CatalogViewModel(
    this._getMakesUseCase,
    this._getModelsUseCase,
    this._getConfigurationsUseCase,
    this._getEnginesUseCase,
    this._getTransmissionsUseCase,
    this._getSpecsUseCase,
    this._getYearsUseCase,
  );

  bool _isLoading = false;
  ApiException? _error;
  List<String> _makes = [];
  List<String> _models = [];
  List<VehicleConfiguration> _configurations = [];
  List<EngineConfig> _engines = [];
  List<TransmissionConfig> _transmissions = [];
  List<VehicleSpec> _specs = [];
  List<int> _years = [];
  String? _selectedMake;
  String? _selectedModel;
  int? _selectedYear;
  String _makeQuery = '';
  String _modelQuery = '';

  bool get isLoading => _isLoading;
  ApiException? get error => _error;
  // Unmodifiable so views cannot mutate ViewModel-owned state.
  List<String> get makes => List.unmodifiable(_makes);
  List<String> get models => List.unmodifiable(_models);
  List<VehicleConfiguration> get configurations =>
      List.unmodifiable(_configurations);
  List<EngineConfig> get engines => List.unmodifiable(_engines);
  List<TransmissionConfig> get transmissions =>
      List.unmodifiable(_transmissions);
  List<VehicleSpec> get specs => List.unmodifiable(_specs);
  /// Years the backend has data for, newest first.
  List<int> get years => List.unmodifiable(_years);
  String? get selectedMake => _selectedMake;
  String? get selectedModel => _selectedModel;
  int? get selectedYear => _selectedYear;

  String get makeQuery => _makeQuery;
  String get modelQuery => _modelQuery;

  /// Makes matching the current search query, or every make when it is empty.
  List<String> get filteredMakes => _filter(_makes, _makeQuery);

  /// Models matching the current search query, or every model when it is empty.
  List<String> get filteredModels => _filter(_models, _modelQuery);

  void setMakeQuery(String query) {
    final value = query.trimLeft();
    if (value == _makeQuery) return;
    _makeQuery = value;
    notifyListeners();
  }

  void setModelQuery(String query) {
    final value = query.trimLeft();
    if (value == _modelQuery) return;
    _modelQuery = value;
    notifyListeners();
  }

  /// Case-, accent- and separator-insensitive `contains` filter, so
  /// "mercedes" matches "Mercedes-Benz", "hrv" matches "HR-V" and "landrover"
  /// matches "Land Rover".
  static List<String> _filter(List<String> source, String query) {
    if (query.trim().isEmpty) return List.unmodifiable(source);

    final needle = _normalize(query);
    return List.unmodifiable(
      source.where((item) => _normalize(item).contains(needle)),
    );
  }

  /// Lowercases, folds diacritics onto their base letter and drops the
  /// separators that vehicle names are full of.
  ///
  /// Only known separators are removed rather than whitelisting `[a-z0-9]`,
  /// so non-Latin names (the app is Arabic and French) survive intact.
  static String _normalize(String input) {
    final buffer = StringBuffer();
    for (final rune in input.toLowerCase().runes) {
      final char = String.fromCharCode(rune);
      if (_separators.contains(char)) continue;
      buffer.write(_foldings[char] ?? char);
    }
    return buffer.toString();
  }

  /// Punctuation and whitespace that should not affect a match.
  static const Set<String> _separators = <String>{
    ' ',
    '-',
    '_',
    '/',
    '\\',
    '.',
    ',',
    "'",
    '"',
    '(',
    ')',
    '[',
    ']',
    '&',
    '+',
    '|',
    ':',
    ';',
    '!',
    '?',
    '#',
    '@',
    '*',
  };

  static const Map<String, String> _foldings = <String, String>{
    'à': 'a',
    'á': 'a',
    'â': 'a',
    'ã': 'a',
    'ä': 'a',
    'å': 'a',
    'ā': 'a',
    'ă': 'a',
    'ą': 'a',
    'ç': 'c',
    'ć': 'c',
    'č': 'c',
    'ĉ': 'c',
    'ċ': 'c',
    'ď': 'd',
    'đ': 'd',
    'è': 'e',
    'é': 'e',
    'ê': 'e',
    'ë': 'e',
    'ē': 'e',
    'ĕ': 'e',
    'ė': 'e',
    'ę': 'e',
    'ě': 'e',
    'ğ': 'g',
    'ĝ': 'g',
    'ġ': 'g',
    'ģ': 'g',
    'ĥ': 'h',
    'ì': 'i',
    'í': 'i',
    'î': 'i',
    'ï': 'i',
    'ī': 'i',
    'į': 'i',
    'ı': 'i',
    'ĵ': 'j',
    'ķ': 'k',
    'ĺ': 'l',
    'ļ': 'l',
    'ľ': 'l',
    'ł': 'l',
    'ñ': 'n',
    'ń': 'n',
    'ň': 'n',
    'ò': 'o',
    'ó': 'o',
    'ô': 'o',
    'õ': 'o',
    'ö': 'o',
    'ø': 'o',
    'ō': 'o',
    'ŏ': 'o',
    'ő': 'o',
    'ŕ': 'r',
    'ř': 'r',
    'ŗ': 'r',
    'ś': 's',
    'ŝ': 's',
    'ş': 's',
    'š': 's',
    'ș': 's',
    'ţ': 't',
    'ť': 't',
    'ŧ': 't',
    'ț': 't',
    'ù': 'u',
    'ú': 'u',
    'û': 'u',
    'ü': 'u',
    'ū': 'u',
    'ŭ': 'u',
    'ů': 'u',
    'ű': 'u',
    'ų': 'u',
    'ŵ': 'w',
    'ý': 'y',
    'ÿ': 'y',
    'ź': 'z',
    'ż': 'z',
    'ž': 'z',
  };

  Map<String, String> get fieldErrors {
    if (_error?.details == null) return {};
    return {for (final d in _error!.details!) d.field: d.message};
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(ApiException? error) {
    _error = error;
    notifyListeners();
  }

  Future<void> loadMakes() async {
    _setLoading(true);
    _setError(null);

    final result = await _getMakesUseCase(null);
    _setLoading(false);

    if (result.isSuccess) {
      _makes = result.data!;
      notifyListeners();
    } else {
      _setError(result.error!);
    }
  }

  Future<void> loadModels(String make) async {
    _selectedMake = make;
    _models = [];
    _configurations = [];
    _engines = [];
    _transmissions = [];
    _specs = [];
    _years = [];
    _selectedModel = null;
    _selectedYear = null;
    // A new brand means a new model list, so a stale query would hide
    // everything or match nothing.
    _modelQuery = '';
    notifyListeners();

    _setLoading(true);
    _setError(null);

    final result = await _getModelsUseCase(make);
    _setLoading(false);

    if (result.isSuccess) {
      _models = result.data!;
      notifyListeners();
    } else {
      _setError(result.error!);
    }
  }

  Future<void> loadConfigurations(String make, String model, int year) async {
    _selectedModel = model;
    _selectedYear = year;
    _configurations = [];
    _engines = [];
    _transmissions = [];
    _specs = [];
    notifyListeners();

    _setLoading(true);
    _setError(null);

    final result = await _getConfigurationsUseCase(
      GetConfigurationsParams(make: make, model: model, year: year),
    );

    _setLoading(false);

    if (result.isSuccess) {
      _configurations = result.data!;
      notifyListeners();
    } else {
      _setError(result.error!);
    }
  }

  Future<void> loadEngines(String make, String model, int year) async {
    _setLoading(true);
    _setError(null);

    final result = await _getEnginesUseCase(
      GetConfigurationsParams(make: make, model: model, year: year),
    );

    _setLoading(false);

    if (result.isSuccess) {
      _engines = result.data!;
      notifyListeners();
    } else {
      _setError(result.error!);
    }
  }

  Future<void> loadTransmissions(String make, String model, int year) async {
    _setLoading(true);
    _setError(null);

    final result = await _getTransmissionsUseCase(
      GetConfigurationsParams(make: make, model: model, year: year),
    );

    _setLoading(false);

    if (result.isSuccess) {
      _transmissions = result.data!;
      notifyListeners();
    } else {
      _setError(result.error!);
    }
  }

  Future<void> loadSpecs({
    required String make,
    String? model,
    int? year,
  }) async {
    _setLoading(true);
    _setError(null);

    final result = await _getSpecsUseCase(
      GetSpecsParams(make: make, model: model, year: year),
    );

    _setLoading(false);

    if (result.isSuccess) {
      _specs = result.data!;
      notifyListeners();
    } else {
      _setError(result.error!);
    }
  }

  /// Years the backend holds data for, newest first.
  ///
  /// Deliberately does not touch the shared `_isLoading` flag: the year
  /// bottom sheet renders its own progress indicator, and flipping the global
  /// flag here would replace the whole catalog tab with a loader while the
  /// sheet is open.
  Future<List<int>> loadYears(String make, String model) async {
    _years = [];
    _setError(null);
    notifyListeners();

    final result = await _getYearsUseCase(
      GetYearsParams(make: make, model: model),
    );

    if (result.isSuccess) {
      _years = result.data!;
      notifyListeners();
      return _years;
    }

    _setError(result.error!);
    return const [];
  }

  void clearSelection() {
    _selectedMake = null;
    _selectedModel = null;
    _selectedYear = null;
    _models = [];
    _configurations = [];
    _engines = [];
    _transmissions = [];
    _specs = [];
    _years = [];
    _modelQuery = '';
    notifyListeners();
  }

  void clearError() => _setError(null);
}
