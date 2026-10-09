import 'package:flutter/material.dart';

import '../../core/network/api_exception.dart';
import '../../data/models/car.dart';
import '../../data/models/vin_decode.dart';
import '../../domain/usecases/usecases.dart';

class GarageViewModel extends ChangeNotifier {
  final CreateCarUseCase _createCarUseCase;
  final ListCarsUseCase _listCarsUseCase;
  final GetCarUseCase _getCarUseCase;
  final UpdateCarUseCase _updateCarUseCase;
  final DeleteCarUseCase _deleteCarUseCase;
  final DecodeVinUseCase _decodeVinUseCase;

  GarageViewModel(
    this._createCarUseCase,
    this._listCarsUseCase,
    this._getCarUseCase,
    this._updateCarUseCase,
    this._deleteCarUseCase,
    this._decodeVinUseCase,
  );

  bool _isLoading = false;
  ApiException? _error;
  List<Car> _cars = [];
  Car? _selectedCar;
  VinDecodeResult? _vinDecodeResult;

  bool get isLoading => _isLoading;
  ApiException? get error => _error;
  List<Car> get cars => List.unmodifiable(_cars);
  Car? get selectedCar => _selectedCar;
  VinDecodeResult? get vinDecodeResult => _vinDecodeResult;

  bool get hasCars => _cars.isNotEmpty;

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

  Future<void> loadCars() async {
    _setLoading(true);
    _setError(null);

    final result = await _listCarsUseCase(null);
    _setLoading(false);

    if (result.isSuccess) {
      _cars = result.data!;
      notifyListeners();
    } else {
      _setError(result.error!);
    }
  }

  Future<bool> createCar(CreateCarRequest request) async {
    _setLoading(true);
    _setError(null);

    final result = await _createCarUseCase(request);
    _setLoading(false);

    if (result.isSuccess) {
      _cars.insert(0, result.data!);
      notifyListeners();
      return true;
    } else {
      _setError(result.error!);
      return false;
    }
  }

  Future<bool> getCar(String id) async {
    _setLoading(true);
    _setError(null);

    final result = await _getCarUseCase(id);
    _setLoading(false);

    if (result.isSuccess) {
      _selectedCar = result.data;
      notifyListeners();
      return true;
    } else {
      _setError(result.error!);
      return false;
    }
  }

  Future<bool> updateCar(String id, UpdateCarRequest request) async {
    _setLoading(true);
    _setError(null);

    final result = await _updateCarUseCase(
      UpdateCarParams(id: id, request: request),
    );
    _setLoading(false);

    if (result.isSuccess) {
      final index = _cars.indexWhere((c) => c.id == id);
      if (index != -1) _cars[index] = result.data!;
      if (_selectedCar?.id == id) _selectedCar = result.data;
      notifyListeners();
      return true;
    } else {
      _setError(result.error!);
      return false;
    }
  }

  Future<bool> deleteCar(String id) async {
    _setLoading(true);
    _setError(null);

    final result = await _deleteCarUseCase(id);
    _setLoading(false);

    if (result.isSuccess) {
      _cars.removeWhere((c) => c.id == id);
      if (_selectedCar?.id == id) _selectedCar = null;
      notifyListeners();
      return true;
    } else {
      _setError(result.error!);
      return false;
    }
  }

  Future<bool> decodeVin(String vin) async {
    _setLoading(true);
    _setError(null);

    final result = await _decodeVinUseCase(vin);
    _setLoading(false);

    if (result.isSuccess) {
      _vinDecodeResult = result.data;
      notifyListeners();
      return true;
    } else {
      _setError(result.error!);
      return false;
    }
  }

  void clearVinResult() {
    _vinDecodeResult = null;
    notifyListeners();
  }

  void selectCar(Car car) {
    _selectedCar = car;
    notifyListeners();
  }

  void clearError() => _setError(null);
}
