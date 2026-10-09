import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/catalog_viewmodel.dart';
import '../common_view.dart';
import 'catalog_selection.dart';

export 'catalog_selection.dart';

class CatalogScreen extends StatefulWidget {
  /// When true the screen is opened to choose a vehicle rather than to browse
  /// one: the previous selection is discarded on entry and a "use this
  /// vehicle" action appears that pops a [CatalogVehicleSelection] back to the
  /// caller.
  final bool pickerMode;

  const CatalogScreen({super.key, this.pickerMode = false});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final catalogVM = context.read<CatalogViewModel>();
      // A picker is a fresh decision, so a selection left over from browsing
      // the catalog tab would otherwise silently pre-select a vehicle.
      if (widget.pickerMode) catalogVM.clearSelection();
      catalogVM.loadMakes();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = context.t;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          widget.pickerMode
              ? t.catalog.selectVehicle
              : t.catalog.vehicleCatalog,
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorWeight: 3,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Tab(text: t.catalog.makes),
            Tab(text: t.catalog.models),
            Tab(text: t.catalog.specifications),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _MakesTab(tabController: _tabController),
          _ModelsTab(tabController: _tabController),
          _SpecsTab(
            tabController: _tabController,
            pickerMode: widget.pickerMode,
          ),
        ],
      ),
    );
  }
}

class _MakesTab extends StatefulWidget {
  final TabController tabController;
  const _MakesTab({required this.tabController});

  @override
  State<_MakesTab> createState() => _MakesTabState();
}

class _MakesTabState extends State<_MakesTab> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    context.read<CatalogViewModel>().setMakeQuery(query);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = context.t;
    final catalogVM = context.watch<CatalogViewModel>();
    final makes = catalogVM.filteredMakes;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.gutter,
            AppSpacing.md,
            AppSpacing.gutter,
            AppSpacing.sm,
          ),
          child: AppSearchField(
            controller: _searchController,
            hint: t.catalog.searchMakes,
            clearTooltip: t.catalog.clearSearch,
            onChanged: _onSearchChanged,
            onSubmitted: (_) => FocusScope.of(context).unfocus(),
          ),
        ),
        Expanded(
          child: catalogVM.isLoading
              ? const Center(child: AppLoader())
              : catalogVM.makes.isEmpty
              ? catalogVM.error != null
                    ? ErrorState(
                        title: t.common.error,
                        message: localizeApiError(
                          catalogVM.error!.code,
                          t,
                          fallback: catalogVM.error!.message,
                        ),
                        onRetry: () => catalogVM.loadMakes(),
                      )
                    : EmptyState(
                        title: t.catalog.noMakesFound,
                        icon: Icons.search_off_rounded,
                      )
              : makes.isEmpty
              ? EmptyState(
                  title: t.catalog.noResults,
                  subtitle: t.catalog.nothingMatches,
                  icon: Icons.search_off_rounded,
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.gutter,
                    AppSpacing.sm,
                    AppSpacing.gutter,
                    AppSpacing.huge,
                  ),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: makes.length,
                  itemBuilder: (context, index) {
                    final make = makes[index];
                    return EntranceFadeSlide(
                      index: index,
                      child: AppCard(
                        margin: const EdgeInsets.only(bottom: AppSpacing.md),
                        padding: EdgeInsets.zero,
                        onTap: () {
                          // Dismiss the keyboard so the tab change is not
                          // fought by the on-screen keyboard.
                          FocusScope.of(context).unfocus();
                          catalogVM.loadModels(make);
                          widget.tabController.animateTo(1);
                        },
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: 10,
                          ),
                          leading: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(
                                AppRadius.card,
                              ),
                            ),
                            child: Icon(
                              Icons.directions_car_filled_rounded,
                              color: theme.colorScheme.primary,
                              size: 24,
                            ),
                          ),
                          title: Text(
                            make,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                            color: theme.colorScheme.onSurfaceVariant
                                .withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _ModelsTab extends StatefulWidget {
  final TabController tabController;
  const _ModelsTab({required this.tabController});

  @override
  State<_ModelsTab> createState() => _ModelsTabState();
}

class _ModelsTabState extends State<_ModelsTab> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    context.read<CatalogViewModel>().setModelQuery(query);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = context.t;
    final catalogVM = context.watch<CatalogViewModel>();
    final selectedMake = catalogVM.selectedMake;

    if (selectedMake == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.west_rounded,
                size: 32,
                color: theme.colorScheme.primary,
              ),
            ),
            const Gap(20),
            Text(
              t.catalog.selectMake,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );
    }

    final models = catalogVM.filteredModels;

    // The ViewModel clears the query when a different brand is picked; mirror
    // that into the field so the text cannot drift from the filtered list.
    if (_searchController.text != catalogVM.modelQuery) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final value = context.read<CatalogViewModel>().modelQuery;
        if (_searchController.text == value) return;
        _searchController.value = TextEditingValue(
          text: value,
          selection: TextSelection.collapsed(offset: value.length),
        );
      });
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.gutter,
            AppSpacing.md,
            AppSpacing.sm,
            AppSpacing.sm,
          ),
          color: theme.colorScheme.surface,
          child: Row(
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppRadius.badge),
                  ),
                  // Flexible + ellipsis: long brand names used to overflow the
                  // header row next to the "Models" label.
                  child: Text(
                    selectedMake,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const Gap(12),
              Text(t.catalog.models, style: theme.textTheme.titleMedium),
              const Spacer(),
              IconButton(
                onPressed: () {
                  catalogVM.clearSelection();
                  widget.tabController.animateTo(0);
                },
                icon: const Icon(Icons.refresh_rounded, size: 20),
                tooltip: t.catalog.clearSearch,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.gutter,
            AppSpacing.xs,
            AppSpacing.gutter,
            AppSpacing.xs,
          ),
          child: AppSearchField(
            controller: _searchController,
            hint: t.catalog.searchModels,
            clearTooltip: t.catalog.clearSearch,
            onChanged: _onSearchChanged,
            onSubmitted: (_) => FocusScope.of(context).unfocus(),
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: catalogVM.isLoading
              ? const Center(child: AppLoader())
              : catalogVM.models.isEmpty
              ? catalogVM.error != null
                    ? ErrorState(
                        title: t.common.error,
                        message: localizeApiError(
                          catalogVM.error!.code,
                          t,
                          fallback: catalogVM.error!.message,
                        ),
                        onRetry: () => catalogVM.loadModels(selectedMake),
                      )
                    : EmptyState(
                        title: t.catalog.noModelsFound,
                        icon: Icons.search_off_rounded,
                      )
              : models.isEmpty
              ? EmptyState(
                  title: t.catalog.noResults,
                  subtitle: t.catalog.nothingMatches,
                  icon: Icons.search_off_rounded,
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.gutter,
                    AppSpacing.md,
                    AppSpacing.gutter,
                    AppSpacing.huge,
                  ),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: models.length,
                  itemBuilder: (context, index) {
                    final model = models[index];
                    return EntranceFadeSlide(
                      index: index,
                      child: AppCard(
                        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                        padding: EdgeInsets.zero,
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          _showYearSelector(context, model);
                        },
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: 6,
                          ),
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.secondary.withValues(
                                alpha: 0.1,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.model_training_rounded,
                              color: theme.colorScheme.secondary,
                              size: 22,
                            ),
                          ),
                          title: Text(
                            model,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                            color: theme.colorScheme.onSurfaceVariant
                                .withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  void _showYearSelector(BuildContext context, String model) {
    final catalogVM = context.read<CatalogViewModel>();
    final theme = Theme.of(context);
    final t = context.t;
    // The `itemBuilder` below shadows `context` with the bottom sheet's own
    // (soon-to-be-popped) context, so keep a reference to the page's.
    final pageContext = context;
    // Capture the brand before the sheet opens: the previous code read it from
    // inside the tap, where it could already have been reset.
    final make = catalogVM.selectedMake;
    if (make == null) return;

    // Only offer years the backend actually has data for. The old picker
    // rendered a hardcoded 30-year grid (currentYear - index), so selecting a
    // year the model never existed in led to a dead end.
    final yearsFuture = catalogVM.loadYears(make, model);

    AppBottomSheet.show(
      context: context,
      title: Text('${t.catalog.selectYear} - $model'),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
        child: FutureBuilder<List<int>>(
          future: yearsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: AppLoader());
            }

            final years = snapshot.data ?? const <int>[];
            if (years.isEmpty) {
              return EmptyState(
                title: t.catalog.noYearsForModel,
                icon: Icons.event_busy_rounded,
              );
            }

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2.2,
              ),
              itemCount: years.length,
              itemBuilder: (context, index) {
                final year = years[index];
                return InkWell(
                  onTap: () async {
                    Navigator.pop(context);

                    // Previously fired 4 un-awaited requests, which raced on
                    // the shared `_isLoading` / `_error` fields and could
                    // leave a stale error on screen.
                    await Future.wait([
                      catalogVM.loadConfigurations(make, model, year),
                      catalogVM.loadEngines(make, model, year),
                      catalogVM.loadTransmissions(make, model, year),
                    ]);

                    if (!pageContext.mounted) return;
                    widget.tabController.animateTo(2);
                  },

                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest
                          .withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: theme.colorScheme.outline),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      year.toString(),
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _SpecsTab extends StatelessWidget {
  final TabController tabController;
  final bool pickerMode;
  const _SpecsTab({required this.tabController, this.pickerMode = false});

  /// Pops the chosen vehicle to the caller. Only reachable once a year has
  /// been picked, which is the point at which the catalog knows enough to
  /// prefill the Add Car form.
  void _useThisVehicle(BuildContext context, CatalogViewModel catalogVM) {
    final make = catalogVM.selectedMake;
    final model = catalogVM.selectedModel;
    final year = catalogVM.selectedYear;
    if (make == null || model == null || year == null) return;

    Navigator.of(context).pop(
      buildCatalogSelection(
        make: make,
        model: model,
        year: year,
        engines: catalogVM.engines,
        transmissions: catalogVM.transmissions,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = context.t;
    final catalogVM = context.watch<CatalogViewModel>();

    if (catalogVM.selectedMake == null || catalogVM.selectedModel == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.settings_suggest_rounded,
                size: 32,
                color: theme.colorScheme.primary,
              ),
            ),
            const Gap(20),
            Text(
              t.catalog.selectModelFirst,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );
    }

    final canUseVehicle = pickerMode && catalogVM.selectedYear != null;

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            color: theme.colorScheme.surface,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${catalogVM.selectedMake} ${catalogVM.selectedModel}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Text(
                        '${t.catalog.yearLabel} ${catalogVM.selectedYear ?? '--'}',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: t.catalog.startOver,
                  onPressed: () {
                    catalogVM.clearSelection();
                    tabController.animateTo(0);
                  },
                  icon: const Icon(Icons.refresh_rounded, size: 20),
                ),
              ],
            ),
          ),
          if (pickerMode)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: canUseVehicle
                      ? () => _useThisVehicle(context, catalogVM)
                      : null,
                  icon: const Icon(Icons.check_rounded, size: 20),
                  label: Text(t.catalog.useThisVehicle),
                ),
              ),
            ),
          TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelStyle: const TextStyle(fontWeight: FontWeight.w800),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            tabs: [
              Tab(text: t.catalog.configurations),
              Tab(text: t.catalog.engines),
              Tab(text: t.catalog.transmissions),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _ConfigurationsList(),
                _EnginesList(),
                _TransmissionsList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ConfigurationsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final catalogVM = context.watch<CatalogViewModel>();

    return catalogVM.isLoading
        ? const Center(child: AppLoader())
        : catalogVM.configurations.isEmpty
        ? EmptyState(
            title: t.catalog.noConfigurations,
            icon: Icons.settings_rounded,
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            itemCount: catalogVM.configurations.length,
            itemBuilder: (context, index) {
              final config = catalogVM.configurations[index];
              return EntranceFadeSlide(
                index: index,
                child: AppCard(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${config.yearFrom} - ${config.yearTo}',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          StatusBadge(status: config.market),
                        ],
                      ),
                      const Gap(20),
                      _ConfigSection(
                        icon: Icons.bolt_rounded,
                        title: t.catalog.engines,
                        items: config.engines
                            .map(
                              (e) =>
                                  '${e.name} (${e.displacementCc}cc, ${e.powerHp} HP)',
                            )
                            .toList(),
                      ),
                      const Gap(16),
                      _ConfigSection(
                        icon: Icons.settings_input_component_rounded,
                        title: t.catalog.transmissions,
                        items: config.transmissions
                            .map(
                              // Not `t`: that would shadow the translation
                              // object this scope is reading from.
                              (trans) =>
                                  '${trans.name} (${trans.type}, ${trans.gears} ${t.catalog.gearsUnit})',
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}

class _ConfigSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<String> items;

  const _ConfigSection({
    required this.icon,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: theme.colorScheme.primary),
            const Gap(8),
            Text(
              title,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const Gap(8),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(left: 24, bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'â€¢ ',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Text(
                    item,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _EnginesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final catalogVM = context.watch<CatalogViewModel>();

    return catalogVM.isLoading
        ? const Center(child: AppLoader())
        : catalogVM.engines.isEmpty
        ? EmptyState(title: t.catalog.noEngines, icon: Icons.memory_rounded)
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            itemCount: catalogVM.engines.length,
            itemBuilder: (context, index) {
              final engine = catalogVM.engines[index];
              return EntranceFadeSlide(
                index: index,
                child: AppCard(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.bolt_rounded,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    title: Text(
                      engine.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        '${engine.displacementCc}cc \u2022 ${engine.cylinders} Cyl \u2022 ${engine.powerHp} HP \u2022 ${engine.fuelType}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}

class _TransmissionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final catalogVM = context.watch<CatalogViewModel>();

    return catalogVM.isLoading
        ? const Center(child: AppLoader())
        : catalogVM.transmissions.isEmpty
        ? EmptyState(
            title: t.catalog.noTransmissions,
            icon: Icons.settings_rounded,
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            itemCount: catalogVM.transmissions.length,
            itemBuilder: (context, index) {
              final trans = catalogVM.transmissions[index];
              return EntranceFadeSlide(
                index: index,
                child: AppCard(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondary.withValues(
                          alpha: 0.1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.settings_input_component_rounded,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    title: Text(
                      trans.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        '${trans.type} • ${trans.gears} ${t.catalog.gearsUnit}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}
