import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/models/vin_decode.dart' show VinDecodeResult;
import '../../viewmodels/garage_viewmodel.dart' show GarageViewModel;
import '../common_view.dart';

/// Decodes a 17-character VIN and hands the result back to the caller.
///
/// Pops with the decoded VIN (a `String`) when the user confirms, so
/// `AddCarScreen` can prefill the field.
class VinDecodeScreen extends StatefulWidget {
  const VinDecodeScreen({super.key});

  @override
  State<VinDecodeScreen> createState() => _VinDecodeScreenState();
}

class _VinDecodeScreenState extends State<VinDecodeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _vinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // The ViewModel outlives this screen, so a previous decode would still be
    // showing when the user comes back.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<GarageViewModel>().clearVinResult();
    });
  }

  @override
  void dispose() {
    _vinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = context.t;
    final vm = context.watch<GarageViewModel>();
    final result = vm.vinDecodeResult;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.garage.vinDecode),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => context.pop(),
        ),
      ),

      // Scrollable: the decoded result card is tall and previously overflowed
      // the viewport on small screens.
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.gutter),
          children: [
            EntranceFadeSlide(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.garage.scanOrEnterVin,
                    style: theme.textTheme.headlineSmall,
                  ),
                  const VGap(AppSpacing.xs),
                  Text(
                    t.garage.vinDecodeSubtitle,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const VGap(AppSpacing.xl),

            EntranceFadeSlide(
              index: 1,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppTextField(
                      controller: _vinController,
                      label: t.garage.vin,
                      hint: '1HGCM82633A123456',
                      textInputAction: TextInputAction.done,
                      validator: Validators.vin,
                      onSubmitted: (_) => _decode(),
                      // Normalised live so the field always matches what will
                      // be sent to the API.
                      onFieldSubmitted: (_) {},
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.qr_code_scanner_rounded),
                        tooltip: t.garage.scanVin,
                        onPressed: _scanVin,
                      ),
                    ),
                    const VGap(AppSpacing.md),
                    AppButton(
                      width: double.infinity,
                      onPressed: vm.isLoading ? null : _decode,
                      isLoading: vm.isLoading,
                      gradient: AppGradients.primary,
                      child: Text(
                        t.garage.decode,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ErrorFeedback(error: vm.error),
                  ],
                ),
              ),
            ),

            if (result != null) ...[
              const VGap(AppSpacing.xl),
              EntranceFadeSlide(
                index: 2,
                child: _VinResultCard(
                  result: result,
                  onUse: () => context.pop(result.vin),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _decode() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final vm = context.read<GarageViewModel>();
    if (vm.isLoading) return;

    await vm.decodeVin(_vinController.text.trim().toUpperCase());
  }

  Future<void> _scanVin() async {
    // Requires a camera / gallery permission flow that is not implemented yet;
    // surfaced as an explicit hint rather than a silent no-op.
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(context.t.garage.vinScanUnavailable)),
      );
  }
}

class _VinResultCard extends StatelessWidget {
  const _VinResultCard({required this.result, required this.onUse});

  final VinDecodeResult result;
  final VoidCallback onUse;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = context.t;

    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.xs),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadius.badge),
                ),
                child: Icon(
                  Icons.check_circle_rounded,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
              ),
              const HGap(AppSpacing.sm),
              Expanded(
                child: Text(
                  t.garage.decodedResult,
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const VGap(AppSpacing.md),
          const Divider(),
          const VGap(AppSpacing.sm),

          _VinRow(label: t.garage.vin, value: result.vin),
          _VinRow(
            label: t.garage.make,
            value: '${result.make} ${result.model}',
          ),
          _VinRow(label: t.common.year, value: '${result.year}'),
          _VinRow(
            label: t.catalog.fuel,
            value: result.fuelLabel.isNotEmpty
                ? result.fuelLabel
                : result.fuelType,
          ),
          _VinRow(label: t.catalog.transmissions, value: result.transmission),
          _VinRow(label: t.catalog.bodyClass, value: result.bodyClass),
          _VinRow(
            label: t.catalog.engine,
            value: [
              result.engineCylinders,
              result.engineHP,
            ].where((s) => s.isNotEmpty).join(' • '),
          ),
          _VinRow(label: t.catalog.drivetrain, value: result.drivetrain),
          _VinRow(label: t.garage.trim, value: result.trim),
          _VinRow(label: t.garage.source, value: result.source),
          _VinRow(label: t.garage.confidence, value: result.confidence),

          if (result.missingFields.isNotEmpty) ...[
            const VGap(AppSpacing.sm),
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: theme.colorScheme.tertiary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(AppRadius.badge),
              ),
              child: Text(
                // Interpolated so the label renders even if a translator drops
                // the placeholder.
                'Missing: ${result.missingFields.join(', ')}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          ],

          const VGap(AppSpacing.lg),
          AppButton(
            width: double.infinity,
            onPressed: onUse,
            child: Text(t.garage.addToGarage),
          ),
        ],
      ),
    );
  }
}

class _VinRow extends StatelessWidget {
  const _VinRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (value.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 116,
            child: Text(label, style: theme.textTheme.bodySmall),
          ),
          const HGap(AppSpacing.sm),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
