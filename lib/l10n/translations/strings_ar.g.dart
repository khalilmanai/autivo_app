///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsAr with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsAr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ar,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ar>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key);

	late final TranslationsAr _root = this; // ignore: unused_field

	@override 
	TranslationsAr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsAr(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$auth$ar auth = _Translations$auth$ar._(_root);
	@override late final _Translations$catalog$ar catalog = _Translations$catalog$ar._(_root);
	@override late final _Translations$common$ar common = _Translations$common$ar._(_root);
	@override late final _Translations$errors$ar errors = _Translations$errors$ar._(_root);
	@override late final _Translations$garage$ar garage = _Translations$garage$ar._(_root);
	@override late final _Translations$parts$ar parts = _Translations$parts$ar._(_root);
	@override late final _Translations$profile$ar profile = _Translations$profile$ar._(_root);
	@override late final _Translations$services$ar services = _Translations$services$ar._(_root);
}

// Path: auth
class _Translations$auth$ar implements Translations$auth$en {
	_Translations$auth$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get login => 'تسجيل الدخول';
	@override String get register => 'تسجيل جديد';
	@override String get email => 'البريد الإلكتروني';
	@override String get password => 'كلمة المرور';
	@override String get confirmPassword => 'تأكيد كلمة المرور';
	@override String get firstName => 'الاسم الأول';
	@override String get lastName => 'الاسم الأخير';
	@override String get forgotPassword => 'نسيت كلمة المرور؟';
	@override String get resetPassword => 'إعادة تعيين كلمة المرور';
	@override String get newPassword => 'كلمة مرور جديدة';
	@override String get currentPassword => 'كلمة المرور الحالية';
	@override String get dontHaveAccount => 'ليس لديك حساب؟';
	@override String get alreadyHaveAccount => 'لديك حساب بالفعل؟';
	@override String get signUp => 'إنشاء حساب';
	@override String get signIn => 'تسجيل الدخول';
	@override String get welcomeBack => 'مرحباً بعودتك';
	@override String get sendResetLink => 'إرسال رابط إعادة التعيين';
	@override String get resetPasswordTitle => 'إعادة تعيين كلمة المرور';
	@override String get resetPasswordSubtitle => 'أدخل كلمة المرور الجديدة أدناه';
	@override String get forgotPasswordSubtitle => 'أدخل بريدك الإلكتروني وسنرسل لك رابط إعادة التعيين';
	@override String get orContinueWith => 'أو المتابعة مع';
	@override String get google => 'جوجل';
	@override String get googleSignInDisabled => 'تسجيل الدخول عبر جوجل غير مهيأ';
}

// Path: catalog
class _Translations$catalog$ar implements Translations$catalog$en {
	_Translations$catalog$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get catalog => 'الكتالوج';
	@override String get vehicleCatalog => 'كتالوج المركبات';
	@override String get makes => 'الماركات';
	@override String get models => 'الموديلات';
	@override String get specifications => 'المواصفات';
	@override String get engines => 'المحركات';
	@override String get transmissions => 'ناقلات الحركة';
	@override String get searchMakes => 'البحث عن الماركات...';
	@override String get searchModels => 'البحث عن الموديلات...';
	@override String get selectMake => 'اختر ماركة';
	@override String get selectModel => 'اختر موديل';
	@override String get selectYear => 'اختر سنة';
	@override String get fuel => 'الوقود';
	@override String get bodyClass => 'فئة الهيكل';
	@override String get engine => 'المحرك';
	@override String get drivetrain => 'نظام الدفع';
	@override String get noMakesFound => 'لم يتم العثور على علامات تجارية';
	@override String get noModelsFound => 'لم يتم العثور على موديلات';
	@override String get noResults => 'لا توجد نتائج';
	@override String get nothingMatches => 'لا توجد نتائج مطابقة لبحثك.';
	@override String get clearSearch => 'مسح البحث';
	@override String get configurations => 'التكوينات';
	@override String get selectVehicle => 'اختر مركبة';
	@override String get selectModelFirst => 'اختر موديلاً أولاً';
	@override String get useThisVehicle => 'استخدام هذه المركبة';
	@override String get startOver => 'البدء من جديد';
	@override String get yearLabel => 'السنة:';
	@override String get gearsUnit => 'سرعات';
	@override String get noYearsForModel => 'لا توجد بيانات لهذا الموديل بعد';
	@override String get noConfigurations => 'لم يتم العثور على تكوينات';
	@override String get noEngines => 'لم يتم العثور على محركات';
	@override String get noTransmissions => 'لم يتم العثور على ناقلات حركة';
}

// Path: common
class _Translations$common$ar implements Translations$common$en {
	_Translations$common$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get appTitle => 'أوتوفو';
	@override String get loading => 'جاري التحميل...';
	@override String get error => 'خطأ';
	@override String get success => 'نجاح';
	@override String get retry => 'إعادة المحاولة';
	@override String get close => 'إغلاق';
	@override String get confirm => 'تأكيد';
	@override String get back => 'رجوع';
	@override String get next => 'التالي';
	@override String get done => 'تم';
	@override String get skip => 'تخطي';
	@override String get search => 'بحث';
	@override String get filter => 'تصفية';
	@override String get sort => 'ترتيب';
	@override String get all => 'الكل';
	@override String get save => 'حفظ';
	@override String get cancel => 'إلغاء';
	@override String get delete => 'حذف';
	@override String get edit => 'تعديل';
	@override String get update => 'تحديث';
	@override String get create => 'إنشاء';
	@override String get status => 'الحالة';
	@override String get active => 'نشط';
	@override String get maintenance => 'صيانة مطلوبة';
	@override String get inactive => 'غير نشط';
	@override String get notes => 'ملاحظات';
	@override String get date => 'التاريخ';
	@override String get title => 'العنوان';
	@override String get cost => 'التكلفة';
	@override String get category => 'الفئة';
	@override String get engine => 'المحرك';
	@override String get transmission => 'ناقل الحركة';
	@override String get mileage => 'عداد الكيلومترات';
	@override String get color => 'اللون';
	@override String get colorName => 'اسم اللون';
	@override String get year => 'السنة';
	@override String get overview => 'نظرة عامة';
	@override String get details => 'التفاصيل';
	@override String get add => 'إضافة';
	@override String get summary => 'الملخص';
	@override String get schedule => 'الجدولة';
	@override String get somethingWentWrong => 'حدث خطأ ما';
	@override String get couldNotLoadRecord => 'تعذر تحميل هذا السجل. تحقق من اتصالك وحاول مرة أخرى.';
	@override String get selectDate => 'اختر التاريخ';
	@override String get required => 'هذا الحقل مطلوب';
	@override String get invalidNumber => 'أدخل رقماً صحيحاً';
	@override String get mustBePositive => 'يجب أن يكون أكبر من صفر';
	@override String get updated => 'آخر تحديث';
}

// Path: errors
class _Translations$errors$ar implements Translations$errors$en {
	_Translations$errors$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get invalidCredentials => 'بيانات اعتماد غير صالحة';
	@override String get emailAlreadyExists => 'يوجد حساب بهذا البريد الإلكتروني بالفعل';
	@override String get userNotFound => 'المستخدم غير موجود';
	@override String get accountInactive => 'الحساب غير نشط';
	@override String get rateLimitExceeded => 'عدد كبير من الطلبات. يرجى المحاولة لاحقاً.';
	@override String get validationError => 'يرجى التحقق من إدخالك';
	@override String get networkError => 'خطأ في الشبكة. تحقق من اتصالك.';
	@override String get unknownError => 'حدث خطأ غير معروف';
	@override String get sessionExpired => 'انتهت صلاحية جلستك. يرجى تسجيل الدخول مرة أخرى.';
	@override String get carNotFound => 'المركبة غير موجودة';
	@override String get maintenanceNotFound => 'سجل الصيانة غير موجود';
	@override String get vinAlreadyExistsInGarage => 'توجد مركبة بهذا الرقم في مرآبك بالفعل';
	@override String get invalidVinFormat => 'تنسيق رقم الشاصي غير صالح';
	@override String get vinDecodeFailed => 'فشل في فك تشفير رقم الشاصي. يرجى التحقق من الرقم والمحاولة مرة أخرى.';
	@override String get accessDenied => 'ليس لديك صلاحية لتنفيذ هذا الإجراء';
	@override String get notFound => 'المورد غير موجود';
	@override String get conflict => 'حدث تعارض مع طلبك';
	@override String get missingParameter => 'مطلوب مغلق مفقود';
	@override String get malformedJson => 'بيانات الطلب غير صالحة';
	@override String get internalServerError => 'حدث خطأ داخلي. يرجى المحاولة لاحقاً.';
}

// Path: garage
class _Translations$garage$ar implements Translations$garage$en {
	_Translations$garage$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get garage => 'المرآب';
	@override String get addVehicle => 'إضافة مركبة';
	@override String get addCar => 'إضافة سيارة';
	@override String get noVehicles => 'لا توجد مركبات بعد';
	@override String get noVehiclesSubtitle => 'أضف سيارتك الأولى للبدء';
	@override String get scanVin => 'مسح رقم الشاصي';
	@override String get manualEntry => 'إدخال يدوي';
	@override String get vinDecode => 'فك تشفير VIN';
	@override String get decode => 'فك التشفير';
	@override String get make => 'الماركة';
	@override String get model => 'الموديل';
	@override String get fuelType => 'نوع الوقود';
	@override String get vin => 'رقم الشاصي (VIN)';
	@override String get licensePlate => 'رقم اللوحة';
	@override String get serviceInterval => 'فاصل الخدمة (كم)';
	@override String get healthScore => 'مؤشر الصحة';
	@override String get excellent => 'ممتاز';
	@override String get good => 'جيد';
	@override String get fair => 'مقبول';
	@override String get poor => 'ضعيف';
	@override String get upcomingMaintenance => 'الصيانة القادمة';
	@override String get dashboardSubtitle => 'كل ما تحتاجه لمركباتك في مكان واحد';
	@override String get sectionVehicles => 'مركباتي';
	@override String get vehicles => 'المركبات';
	@override String get active => 'نشطة';
	@override String get inMaintenance => 'قيد الصيانة';
	@override String get scanOrEnterVin => 'امسح أو أدخل رقم الشاصي';
	@override String get vinDecodeSubtitle => 'أدخل رقم شاصي من 17 حرفاً لفك تشفير معلومات المركبة';
	@override String get vinScanUnavailable => 'المسح بالكاميرا غير متاح بعد. أدخل رقم الشاصي يدوياً.';
	@override String get decodedResult => 'نتيجة فك التشفير';
	@override String get addToGarage => 'إضافة إلى المرآب';
	@override String get trim => 'الفئة';
	@override String get source => 'المصدر';
	@override String get confidence => 'الثقة';
	@override String get bodyClass => 'فئة الهيكل';
	@override String get drivetrain => 'نظام الدفع';
	@override String get missingFields => 'مفقود: {fields}';
	@override String get browseCatalog => 'تصفح الكتالوج';
	@override String get fromCatalog => 'من الكتالوج';
}

// Path: parts
class _Translations$parts$ar implements Translations$parts$en {
	_Translations$parts$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get parts => 'القطع';
	@override String get partStatus => 'حالة القطعة';
	@override String get original => 'أصلي';
	@override String get replaced => 'مستبدل';
	@override String get serviced => 'مخدوم';
	@override String get worn => 'بالي';
	@override String get damaged => 'تالف';
	@override String get replacedAt => 'استبدل في';
	@override String get mileageAtReplacement => 'الكيلومترات عند الاستبدال';
	@override String get partStatusLegend => 'دليل حالات القطع';
	@override String get engineParts => 'المحرك ونقل الحركة';
	@override String get brakeParts => 'الفرامل';
	@override String get suspensionParts => 'التعليق';
	@override String get tireParts => 'الإطارات';
	@override String get bodyParts => 'الهيكل والخارجية';
	@override String get electricalParts => 'الكهرباء';
	@override String get vehicleHealthMap => 'خريطة حالة السيارة';
	@override String get tapZonesHint => 'اضغط على أي منطقة لتحديث حالتها';
	@override String get partCategories => 'فئات القطع';
	@override String get noPartsTracked => 'لا توجد قطع متعقبة';
	@override String get noPartsTrackedSubtitle => 'ستظهر القطع التي تضيفها هنا مجمعة حسب النظام.';
	@override String get mileageAtMaintenance => 'الكيلومترات عند الصيانة';
	@override String get conditionDetailsHint => 'أضف أي تفاصيل عن الحالة...';
}

// Path: profile
class _Translations$profile$ar implements Translations$profile$en {
	_Translations$profile$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get profile => 'الملف الشخصي';
	@override String get settings => 'الإعدادات';
	@override String get security => 'الأمان';
	@override String get changeEmail => 'تغيير البريد الإلكتروني';
	@override String get changePassword => 'تغيير كلمة المرور';
	@override String get logout => 'تسجيل الخروج';
	@override String get language => 'اللغة';
	@override String get distanceUnit => 'وحدة المسافة';
	@override String get currency => 'العملة';
	@override String get preferences => 'التفضيلات';
	@override String get avatar => 'الصورة الرمزية';
	@override String get removeAvatar => 'إزالة الصورة';
	@override String get selectImage => 'اختر صورة';
	@override String get camera => 'الكاميرا';
	@override String get gallery => 'المعرض';
	@override String get changeEmailTitle => 'تغيير البريد الإلكتروني';
	@override String get changePasswordTitle => 'تغيير كلمة المرور';
	@override String get newEmail => 'بريد إلكتروني جديد';
	@override String get emailChanged => 'تم تغيير البريد الإلكتروني بنجاح';
	@override String get passwordChanged => 'تم تغيير كلمة المرور بنجاح. يرجى تسجيل الدخول مرة أخرى.';
	@override String get selectLanguage => 'اختر اللغة';
	@override String get selectDistanceUnit => 'اختر وحدة المسافة';
	@override String get selectCurrency => 'اختر العملة';
	@override String get kilometers => 'كيلومترات (كم)';
	@override String get miles => 'أميال (ميل)';
	@override String get tunisianDinar => 'دينار تونسي (TND)';
	@override String get euro => 'يورو (EUR)';
	@override String get usDollar => 'دولار أمريكي (USD)';
	@override String get english => 'الإنجليزية';
	@override String get french => 'الفرنسية';
	@override String get arabic => 'العربية';
	@override String get darkMode => 'الوضع الداكن';
	@override String get lightMode => 'الوضع الفاتح';
	@override String get theme => 'السمة';
	@override String get appearance => 'المظهر';
	@override String get themeWhite => 'أبيض';
	@override String get themeBlack => 'أسود';
	@override String get themeNightOwl => 'بومة الليل';
	@override String get about => 'حول';
	@override String get version => 'الإصدار';
	@override String get buildNumber => 'البناء';
	@override String get privacyPolicy => 'سياسة الخصوصية';
	@override String get termsOfService => 'شروط الخدمة';
	@override String get contactSupport => 'اتصل بالدعم';
	@override String get appDescription => 'إدارة ذكية للمركبات وتتبع الصيانة';
	@override String get welcome => 'مرحباً بكم في أوتوفو';
	@override String get welcomeSubtitle => 'رفيقك الذكي للمركبات';
	@override String get getStarted => 'ابدأ الآن';
}

// Path: services
class _Translations$services$ar implements Translations$services$en {
	_Translations$services$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get services => 'الخدمات';
	@override String get maintenanceRecords => 'سجلات الصيانة';
	@override String get addMaintenance => 'إضافة صيانة';
	@override String get maintenanceType => 'النوع';
	@override String get nextServiceMileage => 'الكيلومترات للخدمة القادمة';
	@override String get nextServiceDue => 'الخدمة القادمة مستحقة';
	@override String get nextServiceKm => 'الخدمة القادمة (كم)';
	@override String get schedule => 'الجدولة';
	@override String get partsReplaced => 'القطع المستبدلة';
	@override String get allPartsAdded => 'تمت إضافة جميع القطع';
	@override String get addPartsReplaced => 'إضافة قطع مستبدلة';
	@override String get recordNotFound => 'السجل غير موجود';
	@override String get overdue => 'متأخر';
	@override String get allCaughtUp => 'كل شيء على ما يرام!';
	@override String get noUpcomingMaintenance => 'لا توجد صيانة قادمة مجدولة لهذه السيارة.';
	@override String get kmLeft => 'كم متبقٍ';
}

/// The flat map containing all translations for locale <ar>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsAr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'auth.login' => 'تسجيل الدخول',
			'auth.register' => 'تسجيل جديد',
			'auth.email' => 'البريد الإلكتروني',
			'auth.password' => 'كلمة المرور',
			'auth.confirmPassword' => 'تأكيد كلمة المرور',
			'auth.firstName' => 'الاسم الأول',
			'auth.lastName' => 'الاسم الأخير',
			'auth.forgotPassword' => 'نسيت كلمة المرور؟',
			'auth.resetPassword' => 'إعادة تعيين كلمة المرور',
			'auth.newPassword' => 'كلمة مرور جديدة',
			'auth.currentPassword' => 'كلمة المرور الحالية',
			'auth.dontHaveAccount' => 'ليس لديك حساب؟',
			'auth.alreadyHaveAccount' => 'لديك حساب بالفعل؟',
			'auth.signUp' => 'إنشاء حساب',
			'auth.signIn' => 'تسجيل الدخول',
			'auth.welcomeBack' => 'مرحباً بعودتك',
			'auth.sendResetLink' => 'إرسال رابط إعادة التعيين',
			'auth.resetPasswordTitle' => 'إعادة تعيين كلمة المرور',
			'auth.resetPasswordSubtitle' => 'أدخل كلمة المرور الجديدة أدناه',
			'auth.forgotPasswordSubtitle' => 'أدخل بريدك الإلكتروني وسنرسل لك رابط إعادة التعيين',
			'auth.orContinueWith' => 'أو المتابعة مع',
			'auth.google' => 'جوجل',
			'auth.googleSignInDisabled' => 'تسجيل الدخول عبر جوجل غير مهيأ',
			'catalog.catalog' => 'الكتالوج',
			'catalog.vehicleCatalog' => 'كتالوج المركبات',
			'catalog.makes' => 'الماركات',
			'catalog.models' => 'الموديلات',
			'catalog.specifications' => 'المواصفات',
			'catalog.engines' => 'المحركات',
			'catalog.transmissions' => 'ناقلات الحركة',
			'catalog.searchMakes' => 'البحث عن الماركات...',
			'catalog.searchModels' => 'البحث عن الموديلات...',
			'catalog.selectMake' => 'اختر ماركة',
			'catalog.selectModel' => 'اختر موديل',
			'catalog.selectYear' => 'اختر سنة',
			'catalog.fuel' => 'الوقود',
			'catalog.bodyClass' => 'فئة الهيكل',
			'catalog.engine' => 'المحرك',
			'catalog.drivetrain' => 'نظام الدفع',
			'catalog.noMakesFound' => 'لم يتم العثور على علامات تجارية',
			'catalog.noModelsFound' => 'لم يتم العثور على موديلات',
			'catalog.noResults' => 'لا توجد نتائج',
			'catalog.nothingMatches' => 'لا توجد نتائج مطابقة لبحثك.',
			'catalog.clearSearch' => 'مسح البحث',
			'catalog.configurations' => 'التكوينات',
			'catalog.selectVehicle' => 'اختر مركبة',
			'catalog.selectModelFirst' => 'اختر موديلاً أولاً',
			'catalog.useThisVehicle' => 'استخدام هذه المركبة',
			'catalog.startOver' => 'البدء من جديد',
			'catalog.yearLabel' => 'السنة:',
			'catalog.gearsUnit' => 'سرعات',
			'catalog.noYearsForModel' => 'لا توجد بيانات لهذا الموديل بعد',
			'catalog.noConfigurations' => 'لم يتم العثور على تكوينات',
			'catalog.noEngines' => 'لم يتم العثور على محركات',
			'catalog.noTransmissions' => 'لم يتم العثور على ناقلات حركة',
			'common.appTitle' => 'أوتوفو',
			'common.loading' => 'جاري التحميل...',
			'common.error' => 'خطأ',
			'common.success' => 'نجاح',
			'common.retry' => 'إعادة المحاولة',
			'common.close' => 'إغلاق',
			'common.confirm' => 'تأكيد',
			'common.back' => 'رجوع',
			'common.next' => 'التالي',
			'common.done' => 'تم',
			'common.skip' => 'تخطي',
			'common.search' => 'بحث',
			'common.filter' => 'تصفية',
			'common.sort' => 'ترتيب',
			'common.all' => 'الكل',
			'common.save' => 'حفظ',
			'common.cancel' => 'إلغاء',
			'common.delete' => 'حذف',
			'common.edit' => 'تعديل',
			'common.update' => 'تحديث',
			'common.create' => 'إنشاء',
			'common.status' => 'الحالة',
			'common.active' => 'نشط',
			'common.maintenance' => 'صيانة مطلوبة',
			'common.inactive' => 'غير نشط',
			'common.notes' => 'ملاحظات',
			'common.date' => 'التاريخ',
			'common.title' => 'العنوان',
			'common.cost' => 'التكلفة',
			'common.category' => 'الفئة',
			'common.engine' => 'المحرك',
			'common.transmission' => 'ناقل الحركة',
			'common.mileage' => 'عداد الكيلومترات',
			'common.color' => 'اللون',
			'common.colorName' => 'اسم اللون',
			'common.year' => 'السنة',
			'common.overview' => 'نظرة عامة',
			'common.details' => 'التفاصيل',
			'common.add' => 'إضافة',
			'common.summary' => 'الملخص',
			'common.schedule' => 'الجدولة',
			'common.somethingWentWrong' => 'حدث خطأ ما',
			'common.couldNotLoadRecord' => 'تعذر تحميل هذا السجل. تحقق من اتصالك وحاول مرة أخرى.',
			'common.selectDate' => 'اختر التاريخ',
			'common.required' => 'هذا الحقل مطلوب',
			'common.invalidNumber' => 'أدخل رقماً صحيحاً',
			'common.mustBePositive' => 'يجب أن يكون أكبر من صفر',
			'common.updated' => 'آخر تحديث',
			'errors.invalidCredentials' => 'بيانات اعتماد غير صالحة',
			'errors.emailAlreadyExists' => 'يوجد حساب بهذا البريد الإلكتروني بالفعل',
			'errors.userNotFound' => 'المستخدم غير موجود',
			'errors.accountInactive' => 'الحساب غير نشط',
			'errors.rateLimitExceeded' => 'عدد كبير من الطلبات. يرجى المحاولة لاحقاً.',
			'errors.validationError' => 'يرجى التحقق من إدخالك',
			'errors.networkError' => 'خطأ في الشبكة. تحقق من اتصالك.',
			'errors.unknownError' => 'حدث خطأ غير معروف',
			'errors.sessionExpired' => 'انتهت صلاحية جلستك. يرجى تسجيل الدخول مرة أخرى.',
			'errors.carNotFound' => 'المركبة غير موجودة',
			'errors.maintenanceNotFound' => 'سجل الصيانة غير موجود',
			'errors.vinAlreadyExistsInGarage' => 'توجد مركبة بهذا الرقم في مرآبك بالفعل',
			'errors.invalidVinFormat' => 'تنسيق رقم الشاصي غير صالح',
			'errors.vinDecodeFailed' => 'فشل في فك تشفير رقم الشاصي. يرجى التحقق من الرقم والمحاولة مرة أخرى.',
			'errors.accessDenied' => 'ليس لديك صلاحية لتنفيذ هذا الإجراء',
			'errors.notFound' => 'المورد غير موجود',
			'errors.conflict' => 'حدث تعارض مع طلبك',
			'errors.missingParameter' => 'مطلوب مغلق مفقود',
			'errors.malformedJson' => 'بيانات الطلب غير صالحة',
			'errors.internalServerError' => 'حدث خطأ داخلي. يرجى المحاولة لاحقاً.',
			'garage.garage' => 'المرآب',
			'garage.addVehicle' => 'إضافة مركبة',
			'garage.addCar' => 'إضافة سيارة',
			'garage.noVehicles' => 'لا توجد مركبات بعد',
			'garage.noVehiclesSubtitle' => 'أضف سيارتك الأولى للبدء',
			'garage.scanVin' => 'مسح رقم الشاصي',
			'garage.manualEntry' => 'إدخال يدوي',
			'garage.vinDecode' => 'فك تشفير VIN',
			'garage.decode' => 'فك التشفير',
			'garage.make' => 'الماركة',
			'garage.model' => 'الموديل',
			'garage.fuelType' => 'نوع الوقود',
			'garage.vin' => 'رقم الشاصي (VIN)',
			'garage.licensePlate' => 'رقم اللوحة',
			'garage.serviceInterval' => 'فاصل الخدمة (كم)',
			'garage.healthScore' => 'مؤشر الصحة',
			'garage.excellent' => 'ممتاز',
			'garage.good' => 'جيد',
			'garage.fair' => 'مقبول',
			'garage.poor' => 'ضعيف',
			'garage.upcomingMaintenance' => 'الصيانة القادمة',
			'garage.dashboardSubtitle' => 'كل ما تحتاجه لمركباتك في مكان واحد',
			'garage.sectionVehicles' => 'مركباتي',
			'garage.vehicles' => 'المركبات',
			'garage.active' => 'نشطة',
			'garage.inMaintenance' => 'قيد الصيانة',
			'garage.scanOrEnterVin' => 'امسح أو أدخل رقم الشاصي',
			'garage.vinDecodeSubtitle' => 'أدخل رقم شاصي من 17 حرفاً لفك تشفير معلومات المركبة',
			'garage.vinScanUnavailable' => 'المسح بالكاميرا غير متاح بعد. أدخل رقم الشاصي يدوياً.',
			'garage.decodedResult' => 'نتيجة فك التشفير',
			'garage.addToGarage' => 'إضافة إلى المرآب',
			'garage.trim' => 'الفئة',
			'garage.source' => 'المصدر',
			'garage.confidence' => 'الثقة',
			'garage.bodyClass' => 'فئة الهيكل',
			'garage.drivetrain' => 'نظام الدفع',
			'garage.missingFields' => 'مفقود: {fields}',
			'garage.browseCatalog' => 'تصفح الكتالوج',
			'garage.fromCatalog' => 'من الكتالوج',
			'parts.parts' => 'القطع',
			'parts.partStatus' => 'حالة القطعة',
			'parts.original' => 'أصلي',
			'parts.replaced' => 'مستبدل',
			'parts.serviced' => 'مخدوم',
			'parts.worn' => 'بالي',
			'parts.damaged' => 'تالف',
			'parts.replacedAt' => 'استبدل في',
			'parts.mileageAtReplacement' => 'الكيلومترات عند الاستبدال',
			'parts.partStatusLegend' => 'دليل حالات القطع',
			'parts.engineParts' => 'المحرك ونقل الحركة',
			'parts.brakeParts' => 'الفرامل',
			'parts.suspensionParts' => 'التعليق',
			'parts.tireParts' => 'الإطارات',
			'parts.bodyParts' => 'الهيكل والخارجية',
			'parts.electricalParts' => 'الكهرباء',
			'parts.vehicleHealthMap' => 'خريطة حالة السيارة',
			'parts.tapZonesHint' => 'اضغط على أي منطقة لتحديث حالتها',
			'parts.partCategories' => 'فئات القطع',
			'parts.noPartsTracked' => 'لا توجد قطع متعقبة',
			'parts.noPartsTrackedSubtitle' => 'ستظهر القطع التي تضيفها هنا مجمعة حسب النظام.',
			'parts.mileageAtMaintenance' => 'الكيلومترات عند الصيانة',
			'parts.conditionDetailsHint' => 'أضف أي تفاصيل عن الحالة...',
			'profile.profile' => 'الملف الشخصي',
			'profile.settings' => 'الإعدادات',
			'profile.security' => 'الأمان',
			'profile.changeEmail' => 'تغيير البريد الإلكتروني',
			'profile.changePassword' => 'تغيير كلمة المرور',
			'profile.logout' => 'تسجيل الخروج',
			'profile.language' => 'اللغة',
			'profile.distanceUnit' => 'وحدة المسافة',
			'profile.currency' => 'العملة',
			'profile.preferences' => 'التفضيلات',
			'profile.avatar' => 'الصورة الرمزية',
			'profile.removeAvatar' => 'إزالة الصورة',
			'profile.selectImage' => 'اختر صورة',
			'profile.camera' => 'الكاميرا',
			'profile.gallery' => 'المعرض',
			'profile.changeEmailTitle' => 'تغيير البريد الإلكتروني',
			'profile.changePasswordTitle' => 'تغيير كلمة المرور',
			'profile.newEmail' => 'بريد إلكتروني جديد',
			'profile.emailChanged' => 'تم تغيير البريد الإلكتروني بنجاح',
			'profile.passwordChanged' => 'تم تغيير كلمة المرور بنجاح. يرجى تسجيل الدخول مرة أخرى.',
			'profile.selectLanguage' => 'اختر اللغة',
			'profile.selectDistanceUnit' => 'اختر وحدة المسافة',
			'profile.selectCurrency' => 'اختر العملة',
			'profile.kilometers' => 'كيلومترات (كم)',
			'profile.miles' => 'أميال (ميل)',
			'profile.tunisianDinar' => 'دينار تونسي (TND)',
			'profile.euro' => 'يورو (EUR)',
			'profile.usDollar' => 'دولار أمريكي (USD)',
			'profile.english' => 'الإنجليزية',
			'profile.french' => 'الفرنسية',
			'profile.arabic' => 'العربية',
			'profile.darkMode' => 'الوضع الداكن',
			'profile.lightMode' => 'الوضع الفاتح',
			'profile.theme' => 'السمة',
			'profile.appearance' => 'المظهر',
			'profile.themeWhite' => 'أبيض',
			'profile.themeBlack' => 'أسود',
			'profile.themeNightOwl' => 'بومة الليل',
			'profile.about' => 'حول',
			'profile.version' => 'الإصدار',
			'profile.buildNumber' => 'البناء',
			'profile.privacyPolicy' => 'سياسة الخصوصية',
			'profile.termsOfService' => 'شروط الخدمة',
			'profile.contactSupport' => 'اتصل بالدعم',
			'profile.appDescription' => 'إدارة ذكية للمركبات وتتبع الصيانة',
			'profile.welcome' => 'مرحباً بكم في أوتوفو',
			'profile.welcomeSubtitle' => 'رفيقك الذكي للمركبات',
			'profile.getStarted' => 'ابدأ الآن',
			'services.services' => 'الخدمات',
			'services.maintenanceRecords' => 'سجلات الصيانة',
			'services.addMaintenance' => 'إضافة صيانة',
			'services.maintenanceType' => 'النوع',
			'services.nextServiceMileage' => 'الكيلومترات للخدمة القادمة',
			'services.nextServiceDue' => 'الخدمة القادمة مستحقة',
			'services.nextServiceKm' => 'الخدمة القادمة (كم)',
			'services.schedule' => 'الجدولة',
			'services.partsReplaced' => 'القطع المستبدلة',
			'services.allPartsAdded' => 'تمت إضافة جميع القطع',
			'services.addPartsReplaced' => 'إضافة قطع مستبدلة',
			'services.recordNotFound' => 'السجل غير موجود',
			'services.overdue' => 'متأخر',
			'services.allCaughtUp' => 'كل شيء على ما يرام!',
			'services.noUpcomingMaintenance' => 'لا توجد صيانة قادمة مجدولة لهذه السيارة.',
			'services.kmLeft' => 'كم متبقٍ',
			_ => null,
		};
	}
}
