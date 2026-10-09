import 'package:flutter/material.dart';

import '../../core/network/api_exception.dart';
import '../../core/utils/formatters.dart' show getPartGroup;
import '../../data/models/car_part.dart';
import '../../domain/usecases/usecases.dart';

class CarPartViewModel extends ChangeNotifier {
  final ListCarPartsUseCase _listPartsUseCase;
  final GetCarPartUseCase _getPartUseCase;
  final UpsertCarPartUseCase _upsertPartUseCase;
  final DeleteCarPartUseCase _deletePartUseCase;

  CarPartViewModel(
    this._listPartsUseCase,
    this._getPartUseCase,
    this._upsertPartUseCase,
    this._deletePartUseCase,
  );

  bool _isLoading = false;
  ApiException? _error;
  List<CarPart> _parts = [];
  String _carId = '';

  bool get isLoading => _isLoading;
  ApiException? get error => _error;
  List<CarPart> get parts => List.unmodifiable(_parts);

  /// The car this ViewModel is scoped to. Set by any call that establishes the
  /// scope, so mutating use cases never run with an empty `carId`.
  String get carId => _carId;

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

  /// Scopes this ViewModel to [carId] without fetching. Must be called before
  /// [getPart]/[upsertPart]/[deletePart] when the list was never loaded.
  void bindCar(String carId) => _carId = carId;

  Future<void> loadParts(String carId) async {
    _carId = carId;
    _setLoading(true);
    _setError(null);

    final result = await _listPartsUseCase(carId);
    _setLoading(false);

    if (result.isSuccess) {
      _parts = result.data!;
      notifyListeners();
    } else {
      _setError(result.error!);
    }
  }

  Future<CarPart?> getPart(String carId, String partId) async {
    _carId = carId;
    _setLoading(true);
    _setError(null);

    final result = await _getPartUseCase(
      GetCarPartParams(carId: carId, partId: partId),
    );
    _setLoading(false);

    if (result.isSuccess) {
      return result.data;
    } else {
      _setError(result.error!);
      return null;
    }
  }

  Future<bool> upsertPart(String partId, UpsertCarPartRequest request) async {
    _setLoading(true);
    _setError(null);

    final result = await _upsertPartUseCase(
      UpsertCarPartParams(carId: _carId, partId: partId, request: request),
    );

    _setLoading(false);

    if (result.isSuccess) {
      final index = _parts.indexWhere((p) => p.partId == partId);
      if (index != -1) {
        _parts[index] = result.data!;
      } else {
        _parts.add(result.data!);
      }
      notifyListeners();
      return true;
    } else {
      _setError(result.error!);
      return false;
    }
  }

  Future<bool> deletePart(String partId) async {
    _setLoading(true);
    _setError(null);

    final result = await _deletePartUseCase(
      DeleteCarPartParams(carId: _carId, partId: partId),
    );
    _setLoading(false);

    if (result.isSuccess) {
      _parts.removeWhere((p) => p.partId == partId);
      notifyListeners();
      return true;
    } else {
      _setError(result.error!);
      return false;
    }
  }

  void clearError() => _setError(null);

  List<CarPart> getPartsByGroup(String group) {
    return _parts.where((p) => getPartGroup(p.partId) == group).toList();
  }
}
