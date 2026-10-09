import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../data/models/car.dart' show CreateCarRequest;
import '../../viewmodels/garage_viewmodel.dart';
import '../catalog/catalog_selection.dart';
import '../common_view.dart';
import 'catalog_prefill.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final _formKey = GlobalKey<FormState>();
  final _makeController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _mileageController = TextEditingController();
  final _colorController = TextEditingController();
  final _colorNameController = TextEditingController();
  final _vinController = TextEditingController();
  final _licensePlateController = TextEditingController();
  final _engineController = TextEditingController();
  final _serviceIntervalController = TextEditingController();

  String _selectedFuelType = 'gasoline';
  String _selectedTransmission = 'manual';

  // Set once the user picks from a dropdown, so a catalog prefill cannot
  // override a deliberate choice.
  bool _fuelTypeTouched = false;
  bool _transmissionTouched = false;
  final String _selectedStatus = 'active';
  String? _imagePath;

  @override
  void dispose() {
    _makeController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _mileageController.dispose();
    _colorController.dispose();
    _colorNameController.dispose();
    _vinController.dispose();
    _licensePlateController.dispose();
    _engineController.dispose();
    _serviceIntervalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = context.t;
    final garageVM = context.watch<GarageViewModel>();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(t.garage.addCar),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: EntranceFadeSlide(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildImagePicker(context),
                const Gap(32),
                Text(
                  'Basic Information',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Gap(16),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: _makeController,
                        label: t.garage.make,
                        hint: 'Toyota',
                        textInputAction: TextInputAction.next,
                        validator: (v) =>
                            Validators.required(v, fieldName: t.garage.make),
                      ),
                    ),
                    const Gap(16),
                    Expanded(
                      child: AppTextField(
                        controller: _modelController,
                        label: t.garage.model,
                        hint: 'Camry',
                        textInputAction: TextInputAction.next,
                        validator: (v) =>
                            Validators.required(v, fieldName: t.garage.model),
                      ),
                    ),
                  ],
                ),
                const Gap(12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _browseCatalog,
                    icon: const Icon(Icons.travel_explore_rounded, size: 20),
                    label: Text(t.garage.browseCatalog),
                  ),
                ),
                const Gap(20),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: _yearController,
                        label: t.common.year,
                        hint: '2024',
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: Validators.year,
                      ),
                    ),
                    const Gap(16),
                    Expanded(
                      child: _buildSelectField(
                        label: t.garage.fuelType,
                        value: _selectedFuelType,
                        items: FuelTypes.values
                            .map(
                              (f) => DropdownMenuItem(
                                value: f,
                                child: Text(getFuelTypeLabel(f)),
                              ),
                            )
                            .toList(),
                        onChanged: (v) => setState(() {
                          _selectedFuelType = v!;
                          _fuelTypeTouched = true;
                        }),
                      ),
                    ),
                  ],
                ),
                const Gap(32),
                Text(
                  'Technical Details',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Gap(16),
                Row(
                  children: [
                    Expanded(
                      child: _buildSelectField(
                        label: t.common.transmission,
                        value: _selectedTransmission,
                        items: ['manual', 'automatic', 'cvt', 'dct']
                            .map(
                              (t) => DropdownMenuItem(
                                value: t,
                                child: Text(t.capitalize()),
                              ),
                            )
                            .toList(),
                        onChanged: (v) => setState(() {
                          _selectedTransmission = v!;
                          _transmissionTouched = true;
                        }),
                      ),
                    ),
                    const Gap(16),
                    Expanded(
                      child: AppTextField(
                        controller: _mileageController,
                        label: t.common.mileage,
                        hint: '0',
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: Validators.mileage,
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                AppTextField(
                  controller: _vinController,
                  label: t.garage.vin,
                  hint: '17-digit VIN',
                  textInputAction: TextInputAction.next,
                  validator: Validators.vin,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.qr_code_scanner_rounded, size: 20),
                    onPressed: _scanVin,
                  ),
                ),
                const Gap(20),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: _licensePlateController,
                        label: t.garage.licensePlate,
                        hint: 'ABC-123',
                        textInputAction: TextInputAction.next,
                        validator: (v) => Validators.required(
                          v,
                          fieldName: t.garage.licensePlate,
                        ),
                      ),
                    ),
                    const Gap(16),
                    Expanded(
                      child: AppTextField(
                        controller: _serviceIntervalController,
                        label: 'Interval (km)',
                        hint: '10000',
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        validator: (v) => Validators.positiveNumber(
                          v,
                          fieldName: t.garage.serviceInterval,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(40),
                SizedBox(
                  height: 58,
                  child: AppButton(
                    onPressed: garageVM.isLoading ? null : _submit,
                    isLoading: garageVM.isLoading,
                    child: Text(
                      t.common.save,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                ErrorFeedback(error: garageVM.error),
                const Gap(40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withValues(
            alpha: 0.5,
          ),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: theme.colorScheme.outline, width: 1.5),
        ),
        child: _imagePath != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Image.file(
                  File(_imagePath!),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.add_a_photo_rounded,
                      size: 32,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const Gap(12),
                  Text(
                    'Add Vehicle Photo',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildSelectField({
    required String label,
    required String value,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DropdownButtonFormField<String>(
          initialValue: value,
          items: items,
          onChanged: onChanged,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      setState(() => _imagePath = image.path);
    }
  }

  Future<void> _scanVin() async {
    final vin = await context.push<String>('/garage/vin-decode');
    // The decode screen returns the resolved VIN; prefill it if the user
    // navigated back without having typed it.
    if (!mounted || vin == null || vin.isEmpty) return;
    if (_vinController.text.trim().isEmpty) {
      _vinController.text = vin;
    }
  }

  Future<void> _browseCatalog() async {
    final selection = await context.push<CatalogVehicleSelection>(
      '/catalog/picker',
    );
    if (!mounted || selection == null) return;

    final prefill = computeCarPrefill(
      selection: selection,
      currentMake: _makeController.text,
      currentModel: _modelController.text,
      currentYear: _yearController.text,
      currentEngine: _engineController.text,
      currentFuelType: _selectedFuelType,
      currentTransmission: _selectedTransmission,
      fuelTypeLocked: _fuelTypeTouched,
      transmissionLocked: _transmissionTouched,
    );

    setState(() {
      void fill(TextEditingController controller, String? value) {
        if (value != null) controller.text = value;
      }

      fill(_makeController, prefill.make);
      fill(_modelController, prefill.model);
      fill(_yearController, prefill.year);
      fill(_engineController, prefill.engine);

      if (prefill.fuelType != null) {
        _selectedFuelType = prefill.fuelType!;
      }
      if (prefill.transmission != null) {
        _selectedTransmission = prefill.transmission!;
      }
    });
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final vm = context.read<GarageViewModel>();
    if (vm.isLoading) return;

    final request = CreateCarRequest(
      make: _makeController.text.trim(),
      model: _modelController.text.trim(),
      // `tryParse` + fallback: `int.parse` threw an uncaught FormatException
      // on an empty or non-numeric year field.
      year: int.tryParse(_yearController.text.trim()) ?? DateTime.now().year,
      fuelType: _selectedFuelType,
      transmission: _selectedTransmission,
      mileage: int.tryParse(_mileageController.text.trim()) ?? 0,
      // These fields are non-nullable on the request, so an empty field is
      // sent as an empty string rather than dropped.
      color: _colorController.text.trim(),
      colorName: _colorNameController.text.trim(),
      vin: _vinController.text.trim().toUpperCase(),
      licensePlate: _licensePlateController.text.trim(),
      engine: _engineController.text.trim(),
      status: _selectedStatus,
      image: _imagePath,
      serviceInterval:
          int.tryParse(_serviceIntervalController.text.trim()) ?? 10000,
    );

    final success = await vm.createCar(request);

    if (!mounted) return;

    if (success) {
      context.pop();
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(vm.error?.message ?? context.t.common.error)),
        );
    }
  }
}
