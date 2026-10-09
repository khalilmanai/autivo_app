import '../catalog/catalog_selection.dart';

/// Which Add Car form fields a catalog selection should write.
///
/// A `null` field means "leave whatever is already there alone". Nulls are
/// therefore how "do not touch" is expressed, which is why the dropdowns also
/// return `null` when the catalog value could not be normalized to one of the
/// form's options.
class CarFormPrefill {
  final String? make;
  final String? model;
  final String? year;
  final String? engine;
  final String? fuelType;
  final String? transmission;

  const CarFormPrefill({
    this.make,
    this.model,
    this.year,
    this.engine,
    this.fuelType,
    this.transmission,
  });
}

/// Works out what a catalog selection should write into the Add Car form.
///
/// Pure so it can be unit-tested without a widget tree, and so the
/// "never clobber what the user typed" rule lives in one place rather than
/// being spread across field handlers.
///
/// Free-text fields are only filled while blank, matching how the VIN decode
/// flow already behaves. The dropdowns are only replaced while the user has
/// not touched them, and only when the catalog value actually mapped onto one
/// of the form's options.
CarFormPrefill computeCarPrefill({
  required CatalogVehicleSelection selection,
  required String currentMake,
  required String currentModel,
  required String currentYear,
  required String currentEngine,
  required String currentFuelType,
  required String currentTransmission,
  required bool fuelTypeLocked,
  required bool transmissionLocked,
}) {
  bool isBlank(String value) => value.trim().isEmpty;

  return CarFormPrefill(
    make: isBlank(currentMake) ? selection.make : null,
    model: isBlank(currentModel) ? selection.model : null,
    year: isBlank(currentYear) ? selection.year.toString() : null,
    engine: isBlank(currentEngine) ? selection.engine : null,
    fuelType: (!fuelTypeLocked && selection.fuelType != null)
        ? selection.fuelType
        : null,
    transmission: (!transmissionLocked && selection.transmission != null)
        ? selection.transmission
        : null,
  );
}
