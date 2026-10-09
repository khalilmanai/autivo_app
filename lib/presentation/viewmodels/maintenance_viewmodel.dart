import 'package:flutter/material.dart';

import '../../core/network/api_client.dart';
import '../../data/models/maintenance.dart';
import '../../domain/usecases/usecases.dart';

class MaintenanceViewModel extends ChangeNotifier {
  final ListMaintenanceUseCase _listMaintenanceUseCase;
  final GetMaintenanceUseCase _getMaintenanceUseCase;
  final CreateMaintenanceUseCase _createMaintenanceUseCase;
  final UpdateMaintenanceUseCase _updateMaintenanceUseCase;
  final DeleteMaintenanceUseCase _deleteMaintenanceUseCase;

  MaintenanceViewModel(
    this._listMaintenanceUseCase,
    this._getMaintenanceUseCase,
    this._createMaintenanceUseCase,
    this._updateMaintenanceUseCase,
    this._deleteMaintenanceUseCase,
  );

  bool _isLoading = false;
  ApiException? _error;
  List<Maintenance> _records = [];
  String _carId = '';

  bool get isLoading => _isLoading;
  ApiException? get error => _error;
  List<Maintenance> get records => List.unmodifiable(_records);

  /// The car this ViewModel is currently scoped to.
  ///
  /// Every mutating use case needs it, so it is set by *any* call that
  /// establishes the scope — not just [loadRecords]. Previously only
  /// [loadRecords] set it, so opening a record directly from a deep link and
  /// then editing it sent an empty `carId` to the API.
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

  Future<void> loadRecords(String carId) async {
    _carId = carId;
    _setLoading(true);
    _setError(null);

    final result = await _listMaintenanceUseCase(carId);
    _setLoading(false);

    if (result.isSuccess) {
      _records = result.data!;
      _records.sort((a, b) => b.date.compareTo(a.date));
      notifyListeners();
    } else {
      _setError(result.error!);
    }
  }

  /// Scopes the ViewModel to [carId] without fetching. Call this before
  /// [createRecord]/[updateRecord]/[deleteRecord] when the list was never
  /// loaded (e.g. deep-linking straight into a detail screen).
  void bindCar(String carId) => _carId = carId;

  Future<Result<Maintenance>> getMaintenance(String carId, String id) async {
    _carId = carId;
    _setLoading(true);
    _setError(null);

    final result = await _getMaintenanceUseCase(
      GetMaintenanceParams(carId: carId, id: id),
    );

    _setLoading(false);

    if (result.isFailure) {
      _setError(result.error!);
    }

    return result;
  }

  Future<bool> createRecord(CreateMaintenanceRequest request) async {
    _setLoading(true);
    _setError(null);

    final result = await _createMaintenanceUseCase(
      CreateMaintenanceParams(carId: _carId, request: request),
    );

    _setLoading(false);

    if (result.isSuccess) {
      _records.insert(0, result.data!);
      notifyListeners();
      return true;
    } else {
      _setError(result.error!);
      return false;
    }
  }

  Future<bool> updateRecord(String id, UpdateMaintenanceRequest request) async {
    _setLoading(true);
    _setError(null);

    final result = await _updateMaintenanceUseCase(
      UpdateMaintenanceParams(carId: _carId, id: id, request: request),
    );

    _setLoading(false);

    if (result.isSuccess) {
      final index = _records.indexWhere((r) => r.id == id);
      if (index != -1) _records[index] = result.data!;
      notifyListeners();
      return true;
    } else {
      _setError(result.error!);
      return false;
    }
  }

  Future<bool> deleteRecord(String id) async {
    _setLoading(true);
    _setError(null);

    final result = await _deleteMaintenanceUseCase(
      DeleteMaintenanceParams(carId: _carId, id: id),
    );

    _setLoading(false);

    if (result.isSuccess) {
      _records.removeWhere((r) => r.id == id);
      notifyListeners();
      return true;
    } else {
      _setError(result.error!);
      return false;
    }
  }

  void clearError() => _setError(null);
}
