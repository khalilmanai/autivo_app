///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	dynamic operator[](String key) => _meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$auth$en auth = Translations$auth$en._(_root);
	late final Translations$catalog$en catalog = Translations$catalog$en._(_root);
	late final Translations$common$en common = Translations$common$en._(_root);
	late final Translations$errors$en errors = Translations$errors$en._(_root);
	late final Translations$garage$en garage = Translations$garage$en._(_root);
	late final Translations$parts$en parts = Translations$parts$en._(_root);
	late final Translations$profile$en profile = Translations$profile$en._(_root);
	late final Translations$services$en services = Translations$services$en._(_root);
}

// Path: auth
class Translations$auth$en {
	Translations$auth$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Login'
	String get login => 'Login';

	/// en: 'Register'
	String get register => 'Register';

	/// en: 'Email'
	String get email => 'Email';

	/// en: 'Password'
	String get password => 'Password';

	/// en: 'Confirm Password'
	String get confirmPassword => 'Confirm Password';

	/// en: 'First Name'
	String get firstName => 'First Name';

	/// en: 'Last Name'
	String get lastName => 'Last Name';

	/// en: 'Forgot Password?'
	String get forgotPassword => 'Forgot Password?';

	/// en: 'Reset Password'
	String get resetPassword => 'Reset Password';

	/// en: 'New Password'
	String get newPassword => 'New Password';

	/// en: 'Current Password'
	String get currentPassword => 'Current Password';

	/// en: 'Don't have an account?'
	String get dontHaveAccount => 'Don\'t have an account?';

	/// en: 'Already have an account?'
	String get alreadyHaveAccount => 'Already have an account?';

	/// en: 'Sign Up'
	String get signUp => 'Sign Up';

	/// en: 'Sign In'
	String get signIn => 'Sign In';

	/// en: 'Welcome back'
	String get welcomeBack => 'Welcome back';

	/// en: 'Send Reset Link'
	String get sendResetLink => 'Send Reset Link';

	/// en: 'Reset Your Password'
	String get resetPasswordTitle => 'Reset Your Password';

	/// en: 'Enter your new password below'
	String get resetPasswordSubtitle => 'Enter your new password below';

	/// en: 'Enter your email and we'll send you a reset link'
	String get forgotPasswordSubtitle => 'Enter your email and we\'ll send you a reset link';

	/// en: 'Or continue with'
	String get orContinueWith => 'Or continue with';

	/// en: 'Google'
	String get google => 'Google';

	/// en: 'Google sign-in is not configured'
	String get googleSignInDisabled => 'Google sign-in is not configured';
}

// Path: catalog
class Translations$catalog$en {
	Translations$catalog$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Catalog'
	String get catalog => 'Catalog';

	/// en: 'Vehicle Catalog'
	String get vehicleCatalog => 'Vehicle Catalog';

	/// en: 'Makes'
	String get makes => 'Makes';

	/// en: 'Models'
	String get models => 'Models';

	/// en: 'Specifications'
	String get specifications => 'Specifications';

	/// en: 'Engines'
	String get engines => 'Engines';

	/// en: 'Transmissions'
	String get transmissions => 'Transmissions';

	/// en: 'Search makes...'
	String get searchMakes => 'Search makes...';

	/// en: 'Search models...'
	String get searchModels => 'Search models...';

	/// en: 'Select a make'
	String get selectMake => 'Select a make';

	/// en: 'Select a model'
	String get selectModel => 'Select a model';

	/// en: 'Select a year'
	String get selectYear => 'Select a year';

	/// en: 'Fuel'
	String get fuel => 'Fuel';

	/// en: 'Body Class'
	String get bodyClass => 'Body Class';

	/// en: 'Engine'
	String get engine => 'Engine';

	/// en: 'Drivetrain'
	String get drivetrain => 'Drivetrain';

	/// en: 'No brands found'
	String get noMakesFound => 'No brands found';

	/// en: 'No models found'
	String get noModelsFound => 'No models found';

	/// en: 'No results'
	String get noResults => 'No results';

	/// en: 'Nothing matches your search.'
	String get nothingMatches => 'Nothing matches your search.';

	/// en: 'Clear search'
	String get clearSearch => 'Clear search';

	/// en: 'Configurations'
	String get configurations => 'Configurations';

	/// en: 'Select a vehicle'
	String get selectVehicle => 'Select a vehicle';

	/// en: 'Select a model first'
	String get selectModelFirst => 'Select a model first';

	/// en: 'Use this vehicle'
	String get useThisVehicle => 'Use this vehicle';

	/// en: 'Start over'
	String get startOver => 'Start over';

	/// en: 'Year:'
	String get yearLabel => 'Year:';

	/// en: 'gears'
	String get gearsUnit => 'gears';

	/// en: 'No data for this model yet'
	String get noYearsForModel => 'No data for this model yet';

	/// en: 'No configurations found'
	String get noConfigurations => 'No configurations found';

	/// en: 'No engines found'
	String get noEngines => 'No engines found';

	/// en: 'No transmissions found'
	String get noTransmissions => 'No transmissions found';
}

// Path: common
class Translations$common$en {
	Translations$common$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Autivo'
	String get appTitle => 'Autivo';

	/// en: 'Loading...'
	String get loading => 'Loading...';

	/// en: 'Error'
	String get error => 'Error';

	/// en: 'Success'
	String get success => 'Success';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'Close'
	String get close => 'Close';

	/// en: 'Confirm'
	String get confirm => 'Confirm';

	/// en: 'Back'
	String get back => 'Back';

	/// en: 'Next'
	String get next => 'Next';

	/// en: 'Done'
	String get done => 'Done';

	/// en: 'Skip'
	String get skip => 'Skip';

	/// en: 'Search'
	String get search => 'Search';

	/// en: 'Filter'
	String get filter => 'Filter';

	/// en: 'Sort'
	String get sort => 'Sort';

	/// en: 'All'
	String get all => 'All';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'Update'
	String get update => 'Update';

	/// en: 'Create'
	String get create => 'Create';

	/// en: 'Status'
	String get status => 'Status';

	/// en: 'Active'
	String get active => 'Active';

	/// en: 'Maintenance Due'
	String get maintenance => 'Maintenance Due';

	/// en: 'Inactive'
	String get inactive => 'Inactive';

	/// en: 'Notes'
	String get notes => 'Notes';

	/// en: 'Date'
	String get date => 'Date';

	/// en: 'Title'
	String get title => 'Title';

	/// en: 'Cost'
	String get cost => 'Cost';

	/// en: 'Category'
	String get category => 'Category';

	/// en: 'Engine'
	String get engine => 'Engine';

	/// en: 'Transmission'
	String get transmission => 'Transmission';

	/// en: 'Mileage'
	String get mileage => 'Mileage';

	/// en: 'Color'
	String get color => 'Color';

	/// en: 'Color Name'
	String get colorName => 'Color Name';

	/// en: 'Year'
	String get year => 'Year';

	/// en: 'Overview'
	String get overview => 'Overview';

	/// en: 'Details'
	String get details => 'Details';

	/// en: 'Add'
	String get add => 'Add';

	/// en: 'Summary'
	String get summary => 'Summary';

	/// en: 'Schedule'
	String get schedule => 'Schedule';

	/// en: 'Something went wrong'
	String get somethingWentWrong => 'Something went wrong';

	/// en: 'We couldn't load this record. Check your connection and try again.'
	String get couldNotLoadRecord => 'We couldn\'t load this record. Check your connection and try again.';

	/// en: 'Select date'
	String get selectDate => 'Select date';

	/// en: 'This field is required'
	String get required => 'This field is required';

	/// en: 'Enter a valid number'
	String get invalidNumber => 'Enter a valid number';

	/// en: 'Must be greater than zero'
	String get mustBePositive => 'Must be greater than zero';

	/// en: 'Updated'
	String get updated => 'Updated';
}

// Path: errors
class Translations$errors$en {
	Translations$errors$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Invalid credentials'
	String get invalidCredentials => 'Invalid credentials';

	/// en: 'An account with this email already exists'
	String get emailAlreadyExists => 'An account with this email already exists';

	/// en: 'User not found'
	String get userNotFound => 'User not found';

	/// en: 'Account is inactive'
	String get accountInactive => 'Account is inactive';

	/// en: 'Too many requests. Please try again later.'
	String get rateLimitExceeded => 'Too many requests. Please try again later.';

	/// en: 'Please check your input'
	String get validationError => 'Please check your input';

	/// en: 'Network error. Please check your connection.'
	String get networkError => 'Network error. Please check your connection.';

	/// en: 'An unknown error occurred'
	String get unknownError => 'An unknown error occurred';

	/// en: 'Your session has expired. Please sign in again.'
	String get sessionExpired => 'Your session has expired. Please sign in again.';

	/// en: 'Vehicle not found'
	String get carNotFound => 'Vehicle not found';

	/// en: 'Maintenance record not found'
	String get maintenanceNotFound => 'Maintenance record not found';

	/// en: 'A vehicle with this VIN already exists in your garage'
	String get vinAlreadyExistsInGarage => 'A vehicle with this VIN already exists in your garage';

	/// en: 'Invalid VIN format'
	String get invalidVinFormat => 'Invalid VIN format';

	/// en: 'Failed to decode VIN. Please check the number and try again.'
	String get vinDecodeFailed => 'Failed to decode VIN. Please check the number and try again.';

	/// en: 'You do not have permission to perform this action'
	String get accessDenied => 'You do not have permission to perform this action';

	/// en: 'Resource not found'
	String get notFound => 'Resource not found';

	/// en: 'A conflict occurred with your request'
	String get conflict => 'A conflict occurred with your request';

	/// en: 'A required parameter is missing'
	String get missingParameter => 'A required parameter is missing';

	/// en: 'The request data is invalid'
	String get malformedJson => 'The request data is invalid';

	/// en: 'An internal error occurred. Please try again later.'
	String get internalServerError => 'An internal error occurred. Please try again later.';
}

// Path: garage
class Translations$garage$en {
	Translations$garage$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Garage'
	String get garage => 'Garage';

	/// en: 'Add Vehicle'
	String get addVehicle => 'Add Vehicle';

	/// en: 'Add Car'
	String get addCar => 'Add Car';

	/// en: 'No vehicles yet'
	String get noVehicles => 'No vehicles yet';

	/// en: 'Add your first car to get started'
	String get noVehiclesSubtitle => 'Add your first car to get started';

	/// en: 'Scan VIN'
	String get scanVin => 'Scan VIN';

	/// en: 'Manual Entry'
	String get manualEntry => 'Manual Entry';

	/// en: 'VIN Decode'
	String get vinDecode => 'VIN Decode';

	/// en: 'Decode'
	String get decode => 'Decode';

	/// en: 'Make'
	String get make => 'Make';

	/// en: 'Model'
	String get model => 'Model';

	/// en: 'Fuel Type'
	String get fuelType => 'Fuel Type';

	/// en: 'VIN'
	String get vin => 'VIN';

	/// en: 'License Plate'
	String get licensePlate => 'License Plate';

	/// en: 'Service Interval (km)'
	String get serviceInterval => 'Service Interval (km)';

	/// en: 'Health Score'
	String get healthScore => 'Health Score';

	/// en: 'Excellent'
	String get excellent => 'Excellent';

	/// en: 'Good'
	String get good => 'Good';

	/// en: 'Fair'
	String get fair => 'Fair';

	/// en: 'Poor'
	String get poor => 'Poor';

	/// en: 'Upcoming Maintenance'
	String get upcomingMaintenance => 'Upcoming Maintenance';

	/// en: 'Everything for your vehicles in one place'
	String get dashboardSubtitle => 'Everything for your vehicles in one place';

	/// en: 'My Vehicles'
	String get sectionVehicles => 'My Vehicles';

	/// en: 'Vehicles'
	String get vehicles => 'Vehicles';

	/// en: 'Active'
	String get active => 'Active';

	/// en: 'In maintenance'
	String get inMaintenance => 'In maintenance';

	/// en: 'Scan or enter VIN'
	String get scanOrEnterVin => 'Scan or enter VIN';

	/// en: 'Enter a 17-character VIN to decode vehicle information'
	String get vinDecodeSubtitle => 'Enter a 17-character VIN to decode vehicle information';

	/// en: 'Camera scanning is not available yet. Enter the VIN manually.'
	String get vinScanUnavailable => 'Camera scanning is not available yet. Enter the VIN manually.';

	/// en: 'Decoded Result'
	String get decodedResult => 'Decoded Result';

	/// en: 'Add to Garage'
	String get addToGarage => 'Add to Garage';

	/// en: 'Trim'
	String get trim => 'Trim';

	/// en: 'Source'
	String get source => 'Source';

	/// en: 'Confidence'
	String get confidence => 'Confidence';

	/// en: 'Body Class'
	String get bodyClass => 'Body Class';

	/// en: 'Drivetrain'
	String get drivetrain => 'Drivetrain';

	/// en: 'Missing: {fields}'
	String get missingFields => 'Missing: {fields}';

	/// en: 'Browse catalog'
	String get browseCatalog => 'Browse catalog';

	/// en: 'From catalog'
	String get fromCatalog => 'From catalog';
}

// Path: parts
class Translations$parts$en {
	Translations$parts$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Parts'
	String get parts => 'Parts';

	/// en: 'Part Status'
	String get partStatus => 'Part Status';

	/// en: 'Original'
	String get original => 'Original';

	/// en: 'Replaced'
	String get replaced => 'Replaced';

	/// en: 'Serviced'
	String get serviced => 'Serviced';

	/// en: 'Worn'
	String get worn => 'Worn';

	/// en: 'Damaged'
	String get damaged => 'Damaged';

	/// en: 'Replaced At'
	String get replacedAt => 'Replaced At';

	/// en: 'Mileage at Replacement'
	String get mileageAtReplacement => 'Mileage at Replacement';

	/// en: 'Part Status Legend'
	String get partStatusLegend => 'Part Status Legend';

	/// en: 'Engine & Drivetrain'
	String get engineParts => 'Engine & Drivetrain';

	/// en: 'Brakes'
	String get brakeParts => 'Brakes';

	/// en: 'Suspension'
	String get suspensionParts => 'Suspension';

	/// en: 'Tires'
	String get tireParts => 'Tires';

	/// en: 'Body & Exterior'
	String get bodyParts => 'Body & Exterior';

	/// en: 'Electrical'
	String get electricalParts => 'Electrical';

	/// en: 'Vehicle Health Map'
	String get vehicleHealthMap => 'Vehicle Health Map';

	/// en: 'Tap a zone to update its status'
	String get tapZonesHint => 'Tap a zone to update its status';

	/// en: 'Part Categories'
	String get partCategories => 'Part Categories';

	/// en: 'No parts tracked'
	String get noPartsTracked => 'No parts tracked';

	/// en: 'Parts you add will appear here grouped by system.'
	String get noPartsTrackedSubtitle => 'Parts you add will appear here grouped by system.';

	/// en: 'Mileage at maintenance'
	String get mileageAtMaintenance => 'Mileage at maintenance';

	/// en: 'Add any condition details...'
	String get conditionDetailsHint => 'Add any condition details...';
}

// Path: profile
class Translations$profile$en {
	Translations$profile$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Profile'
	String get profile => 'Profile';

	/// en: 'Settings'
	String get settings => 'Settings';

	/// en: 'Security'
	String get security => 'Security';

	/// en: 'Change Email'
	String get changeEmail => 'Change Email';

	/// en: 'Change Password'
	String get changePassword => 'Change Password';

	/// en: 'Logout'
	String get logout => 'Logout';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'Distance Unit'
	String get distanceUnit => 'Distance Unit';

	/// en: 'Currency'
	String get currency => 'Currency';

	/// en: 'Preferences'
	String get preferences => 'Preferences';

	/// en: 'Avatar'
	String get avatar => 'Avatar';

	/// en: 'Remove Avatar'
	String get removeAvatar => 'Remove Avatar';

	/// en: 'Select Image'
	String get selectImage => 'Select Image';

	/// en: 'Camera'
	String get camera => 'Camera';

	/// en: 'Gallery'
	String get gallery => 'Gallery';

	/// en: 'Change Email Address'
	String get changeEmailTitle => 'Change Email Address';

	/// en: 'Change Password'
	String get changePasswordTitle => 'Change Password';

	/// en: 'New Email'
	String get newEmail => 'New Email';

	/// en: 'Email changed successfully'
	String get emailChanged => 'Email changed successfully';

	/// en: 'Password changed successfully. Please sign in again.'
	String get passwordChanged => 'Password changed successfully. Please sign in again.';

	/// en: 'Select Language'
	String get selectLanguage => 'Select Language';

	/// en: 'Select Distance Unit'
	String get selectDistanceUnit => 'Select Distance Unit';

	/// en: 'Select Currency'
	String get selectCurrency => 'Select Currency';

	/// en: 'Kilometers (km)'
	String get kilometers => 'Kilometers (km)';

	/// en: 'Miles (mi)'
	String get miles => 'Miles (mi)';

	/// en: 'Tunisian Dinar (TND)'
	String get tunisianDinar => 'Tunisian Dinar (TND)';

	/// en: 'Euro (EUR)'
	String get euro => 'Euro (EUR)';

	/// en: 'US Dollar (USD)'
	String get usDollar => 'US Dollar (USD)';

	/// en: 'English'
	String get english => 'English';

	/// en: 'Français'
	String get french => 'Français';

	/// en: 'العربية'
	String get arabic => 'العربية';

	/// en: 'Dark Mode'
	String get darkMode => 'Dark Mode';

	/// en: 'Light Mode'
	String get lightMode => 'Light Mode';

	/// en: 'Theme'
	String get theme => 'Theme';

	/// en: 'Appearance'
	String get appearance => 'Appearance';

	/// en: 'White'
	String get themeWhite => 'White';

	/// en: 'Black'
	String get themeBlack => 'Black';

	/// en: 'Night Owl'
	String get themeNightOwl => 'Night Owl';

	/// en: 'About'
	String get about => 'About';

	/// en: 'Version'
	String get version => 'Version';

	/// en: 'Build'
	String get buildNumber => 'Build';

	/// en: 'Privacy Policy'
	String get privacyPolicy => 'Privacy Policy';

	/// en: 'Terms of Service'
	String get termsOfService => 'Terms of Service';

	/// en: 'Contact Support'
	String get contactSupport => 'Contact Support';

	/// en: 'Smart vehicle management and maintenance tracking'
	String get appDescription => 'Smart vehicle management and maintenance tracking';

	/// en: 'Welcome to Autivo'
	String get welcome => 'Welcome to Autivo';

	/// en: 'Your smart vehicle companion'
	String get welcomeSubtitle => 'Your smart vehicle companion';

	/// en: 'Get Started'
	String get getStarted => 'Get Started';
}

// Path: services
class Translations$services$en {
	Translations$services$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Services'
	String get services => 'Services';

	/// en: 'Maintenance Records'
	String get maintenanceRecords => 'Maintenance Records';

	/// en: 'Add Maintenance'
	String get addMaintenance => 'Add Maintenance';

	/// en: 'Type'
	String get maintenanceType => 'Type';

	/// en: 'Next Service Mileage'
	String get nextServiceMileage => 'Next Service Mileage';

	/// en: 'Next Service Due'
	String get nextServiceDue => 'Next Service Due';

	/// en: 'Next Service (km)'
	String get nextServiceKm => 'Next Service (km)';

	/// en: 'Schedule'
	String get schedule => 'Schedule';

	/// en: 'Parts Replaced'
	String get partsReplaced => 'Parts Replaced';

	/// en: 'All parts added'
	String get allPartsAdded => 'All parts added';

	/// en: 'Add parts replaced'
	String get addPartsReplaced => 'Add parts replaced';

	/// en: 'Record not found'
	String get recordNotFound => 'Record not found';

	/// en: 'Overdue'
	String get overdue => 'Overdue';

	/// en: 'All caught up!'
	String get allCaughtUp => 'All caught up!';

	/// en: 'No upcoming maintenance scheduled for this vehicle.'
	String get noUpcomingMaintenance => 'No upcoming maintenance scheduled for this vehicle.';

	/// en: 'km left'
	String get kmLeft => 'km left';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'auth.login' => 'Login',
			'auth.register' => 'Register',
			'auth.email' => 'Email',
			'auth.password' => 'Password',
			'auth.confirmPassword' => 'Confirm Password',
			'auth.firstName' => 'First Name',
			'auth.lastName' => 'Last Name',
			'auth.forgotPassword' => 'Forgot Password?',
			'auth.resetPassword' => 'Reset Password',
			'auth.newPassword' => 'New Password',
			'auth.currentPassword' => 'Current Password',
			'auth.dontHaveAccount' => 'Don\'t have an account?',
			'auth.alreadyHaveAccount' => 'Already have an account?',
			'auth.signUp' => 'Sign Up',
			'auth.signIn' => 'Sign In',
			'auth.welcomeBack' => 'Welcome back',
			'auth.sendResetLink' => 'Send Reset Link',
			'auth.resetPasswordTitle' => 'Reset Your Password',
			'auth.resetPasswordSubtitle' => 'Enter your new password below',
			'auth.forgotPasswordSubtitle' => 'Enter your email and we\'ll send you a reset link',
			'auth.orContinueWith' => 'Or continue with',
			'auth.google' => 'Google',
			'auth.googleSignInDisabled' => 'Google sign-in is not configured',
			'catalog.catalog' => 'Catalog',
			'catalog.vehicleCatalog' => 'Vehicle Catalog',
			'catalog.makes' => 'Makes',
			'catalog.models' => 'Models',
			'catalog.specifications' => 'Specifications',
			'catalog.engines' => 'Engines',
			'catalog.transmissions' => 'Transmissions',
			'catalog.searchMakes' => 'Search makes...',
			'catalog.searchModels' => 'Search models...',
			'catalog.selectMake' => 'Select a make',
			'catalog.selectModel' => 'Select a model',
			'catalog.selectYear' => 'Select a year',
			'catalog.fuel' => 'Fuel',
			'catalog.bodyClass' => 'Body Class',
			'catalog.engine' => 'Engine',
			'catalog.drivetrain' => 'Drivetrain',
			'catalog.noMakesFound' => 'No brands found',
			'catalog.noModelsFound' => 'No models found',
			'catalog.noResults' => 'No results',
			'catalog.nothingMatches' => 'Nothing matches your search.',
			'catalog.clearSearch' => 'Clear search',
			'catalog.configurations' => 'Configurations',
			'catalog.selectVehicle' => 'Select a vehicle',
			'catalog.selectModelFirst' => 'Select a model first',
			'catalog.useThisVehicle' => 'Use this vehicle',
			'catalog.startOver' => 'Start over',
			'catalog.yearLabel' => 'Year:',
			'catalog.gearsUnit' => 'gears',
			'catalog.noYearsForModel' => 'No data for this model yet',
			'catalog.noConfigurations' => 'No configurations found',
			'catalog.noEngines' => 'No engines found',
			'catalog.noTransmissions' => 'No transmissions found',
			'common.appTitle' => 'Autivo',
			'common.loading' => 'Loading...',
			'common.error' => 'Error',
			'common.success' => 'Success',
			'common.retry' => 'Retry',
			'common.close' => 'Close',
			'common.confirm' => 'Confirm',
			'common.back' => 'Back',
			'common.next' => 'Next',
			'common.done' => 'Done',
			'common.skip' => 'Skip',
			'common.search' => 'Search',
			'common.filter' => 'Filter',
			'common.sort' => 'Sort',
			'common.all' => 'All',
			'common.save' => 'Save',
			'common.cancel' => 'Cancel',
			'common.delete' => 'Delete',
			'common.edit' => 'Edit',
			'common.update' => 'Update',
			'common.create' => 'Create',
			'common.status' => 'Status',
			'common.active' => 'Active',
			'common.maintenance' => 'Maintenance Due',
			'common.inactive' => 'Inactive',
			'common.notes' => 'Notes',
			'common.date' => 'Date',
			'common.title' => 'Title',
			'common.cost' => 'Cost',
			'common.category' => 'Category',
			'common.engine' => 'Engine',
			'common.transmission' => 'Transmission',
			'common.mileage' => 'Mileage',
			'common.color' => 'Color',
			'common.colorName' => 'Color Name',
			'common.year' => 'Year',
			'common.overview' => 'Overview',
			'common.details' => 'Details',
			'common.add' => 'Add',
			'common.summary' => 'Summary',
			'common.schedule' => 'Schedule',
			'common.somethingWentWrong' => 'Something went wrong',
			'common.couldNotLoadRecord' => 'We couldn\'t load this record. Check your connection and try again.',
			'common.selectDate' => 'Select date',
			'common.required' => 'This field is required',
			'common.invalidNumber' => 'Enter a valid number',
			'common.mustBePositive' => 'Must be greater than zero',
			'common.updated' => 'Updated',
			'errors.invalidCredentials' => 'Invalid credentials',
			'errors.emailAlreadyExists' => 'An account with this email already exists',
			'errors.userNotFound' => 'User not found',
			'errors.accountInactive' => 'Account is inactive',
			'errors.rateLimitExceeded' => 'Too many requests. Please try again later.',
			'errors.validationError' => 'Please check your input',
			'errors.networkError' => 'Network error. Please check your connection.',
			'errors.unknownError' => 'An unknown error occurred',
			'errors.sessionExpired' => 'Your session has expired. Please sign in again.',
			'errors.carNotFound' => 'Vehicle not found',
			'errors.maintenanceNotFound' => 'Maintenance record not found',
			'errors.vinAlreadyExistsInGarage' => 'A vehicle with this VIN already exists in your garage',
			'errors.invalidVinFormat' => 'Invalid VIN format',
			'errors.vinDecodeFailed' => 'Failed to decode VIN. Please check the number and try again.',
			'errors.accessDenied' => 'You do not have permission to perform this action',
			'errors.notFound' => 'Resource not found',
			'errors.conflict' => 'A conflict occurred with your request',
			'errors.missingParameter' => 'A required parameter is missing',
			'errors.malformedJson' => 'The request data is invalid',
			'errors.internalServerError' => 'An internal error occurred. Please try again later.',
			'garage.garage' => 'Garage',
			'garage.addVehicle' => 'Add Vehicle',
			'garage.addCar' => 'Add Car',
			'garage.noVehicles' => 'No vehicles yet',
			'garage.noVehiclesSubtitle' => 'Add your first car to get started',
			'garage.scanVin' => 'Scan VIN',
			'garage.manualEntry' => 'Manual Entry',
			'garage.vinDecode' => 'VIN Decode',
			'garage.decode' => 'Decode',
			'garage.make' => 'Make',
			'garage.model' => 'Model',
			'garage.fuelType' => 'Fuel Type',
			'garage.vin' => 'VIN',
			'garage.licensePlate' => 'License Plate',
			'garage.serviceInterval' => 'Service Interval (km)',
			'garage.healthScore' => 'Health Score',
			'garage.excellent' => 'Excellent',
			'garage.good' => 'Good',
			'garage.fair' => 'Fair',
			'garage.poor' => 'Poor',
			'garage.upcomingMaintenance' => 'Upcoming Maintenance',
			'garage.dashboardSubtitle' => 'Everything for your vehicles in one place',
			'garage.sectionVehicles' => 'My Vehicles',
			'garage.vehicles' => 'Vehicles',
			'garage.active' => 'Active',
			'garage.inMaintenance' => 'In maintenance',
			'garage.scanOrEnterVin' => 'Scan or enter VIN',
			'garage.vinDecodeSubtitle' => 'Enter a 17-character VIN to decode vehicle information',
			'garage.vinScanUnavailable' => 'Camera scanning is not available yet. Enter the VIN manually.',
			'garage.decodedResult' => 'Decoded Result',
			'garage.addToGarage' => 'Add to Garage',
			'garage.trim' => 'Trim',
			'garage.source' => 'Source',
			'garage.confidence' => 'Confidence',
			'garage.bodyClass' => 'Body Class',
			'garage.drivetrain' => 'Drivetrain',
			'garage.missingFields' => 'Missing: {fields}',
			'garage.browseCatalog' => 'Browse catalog',
			'garage.fromCatalog' => 'From catalog',
			'parts.parts' => 'Parts',
			'parts.partStatus' => 'Part Status',
			'parts.original' => 'Original',
			'parts.replaced' => 'Replaced',
			'parts.serviced' => 'Serviced',
			'parts.worn' => 'Worn',
			'parts.damaged' => 'Damaged',
			'parts.replacedAt' => 'Replaced At',
			'parts.mileageAtReplacement' => 'Mileage at Replacement',
			'parts.partStatusLegend' => 'Part Status Legend',
			'parts.engineParts' => 'Engine & Drivetrain',
			'parts.brakeParts' => 'Brakes',
			'parts.suspensionParts' => 'Suspension',
			'parts.tireParts' => 'Tires',
			'parts.bodyParts' => 'Body & Exterior',
			'parts.electricalParts' => 'Electrical',
			'parts.vehicleHealthMap' => 'Vehicle Health Map',
			'parts.tapZonesHint' => 'Tap a zone to update its status',
			'parts.partCategories' => 'Part Categories',
			'parts.noPartsTracked' => 'No parts tracked',
			'parts.noPartsTrackedSubtitle' => 'Parts you add will appear here grouped by system.',
			'parts.mileageAtMaintenance' => 'Mileage at maintenance',
			'parts.conditionDetailsHint' => 'Add any condition details...',
			'profile.profile' => 'Profile',
			'profile.settings' => 'Settings',
			'profile.security' => 'Security',
			'profile.changeEmail' => 'Change Email',
			'profile.changePassword' => 'Change Password',
			'profile.logout' => 'Logout',
			'profile.language' => 'Language',
			'profile.distanceUnit' => 'Distance Unit',
			'profile.currency' => 'Currency',
			'profile.preferences' => 'Preferences',
			'profile.avatar' => 'Avatar',
			'profile.removeAvatar' => 'Remove Avatar',
			'profile.selectImage' => 'Select Image',
			'profile.camera' => 'Camera',
			'profile.gallery' => 'Gallery',
			'profile.changeEmailTitle' => 'Change Email Address',
			'profile.changePasswordTitle' => 'Change Password',
			'profile.newEmail' => 'New Email',
			'profile.emailChanged' => 'Email changed successfully',
			'profile.passwordChanged' => 'Password changed successfully. Please sign in again.',
			'profile.selectLanguage' => 'Select Language',
			'profile.selectDistanceUnit' => 'Select Distance Unit',
			'profile.selectCurrency' => 'Select Currency',
			'profile.kilometers' => 'Kilometers (km)',
			'profile.miles' => 'Miles (mi)',
			'profile.tunisianDinar' => 'Tunisian Dinar (TND)',
			'profile.euro' => 'Euro (EUR)',
			'profile.usDollar' => 'US Dollar (USD)',
			'profile.english' => 'English',
			'profile.french' => 'Français',
			'profile.arabic' => 'العربية',
			'profile.darkMode' => 'Dark Mode',
			'profile.lightMode' => 'Light Mode',
			'profile.theme' => 'Theme',
			'profile.appearance' => 'Appearance',
			'profile.themeWhite' => 'White',
			'profile.themeBlack' => 'Black',
			'profile.themeNightOwl' => 'Night Owl',
			'profile.about' => 'About',
			'profile.version' => 'Version',
			'profile.buildNumber' => 'Build',
			'profile.privacyPolicy' => 'Privacy Policy',
			'profile.termsOfService' => 'Terms of Service',
			'profile.contactSupport' => 'Contact Support',
			'profile.appDescription' => 'Smart vehicle management and maintenance tracking',
			'profile.welcome' => 'Welcome to Autivo',
			'profile.welcomeSubtitle' => 'Your smart vehicle companion',
			'profile.getStarted' => 'Get Started',
			'services.services' => 'Services',
			'services.maintenanceRecords' => 'Maintenance Records',
			'services.addMaintenance' => 'Add Maintenance',
			'services.maintenanceType' => 'Type',
			'services.nextServiceMileage' => 'Next Service Mileage',
			'services.nextServiceDue' => 'Next Service Due',
			'services.nextServiceKm' => 'Next Service (km)',
			'services.schedule' => 'Schedule',
			'services.partsReplaced' => 'Parts Replaced',
			'services.allPartsAdded' => 'All parts added',
			'services.addPartsReplaced' => 'Add parts replaced',
			'services.recordNotFound' => 'Record not found',
			'services.overdue' => 'Overdue',
			'services.allCaughtUp' => 'All caught up!',
			'services.noUpcomingMaintenance' => 'No upcoming maintenance scheduled for this vehicle.',
			'services.kmLeft' => 'km left',
			_ => null,
		};
	}
}
