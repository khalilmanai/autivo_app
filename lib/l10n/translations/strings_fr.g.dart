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
class TranslationsFr with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsFr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fr>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key);

	late final TranslationsFr _root = this; // ignore: unused_field

	@override 
	TranslationsFr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsFr(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$auth$fr auth = _Translations$auth$fr._(_root);
	@override late final _Translations$catalog$fr catalog = _Translations$catalog$fr._(_root);
	@override late final _Translations$common$fr common = _Translations$common$fr._(_root);
	@override late final _Translations$errors$fr errors = _Translations$errors$fr._(_root);
	@override late final _Translations$garage$fr garage = _Translations$garage$fr._(_root);
	@override late final _Translations$parts$fr parts = _Translations$parts$fr._(_root);
	@override late final _Translations$profile$fr profile = _Translations$profile$fr._(_root);
	@override late final _Translations$services$fr services = _Translations$services$fr._(_root);
}

// Path: auth
class _Translations$auth$fr implements Translations$auth$en {
	_Translations$auth$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get login => 'Connexion';
	@override String get register => 'Inscription';
	@override String get email => 'E-mail';
	@override String get password => 'Mot de passe';
	@override String get confirmPassword => 'Confirmer le mot de passe';
	@override String get firstName => 'Prénom';
	@override String get lastName => 'Nom';
	@override String get forgotPassword => 'Mot de passe oublié ?';
	@override String get resetPassword => 'Réinitialiser le mot de passe';
	@override String get newPassword => 'Nouveau mot de passe';
	@override String get currentPassword => 'Mot de passe actuel';
	@override String get dontHaveAccount => 'Pas de compte ?';
	@override String get alreadyHaveAccount => 'Déjà un compte ?';
	@override String get signUp => 'S\'inscrire';
	@override String get signIn => 'Se connecter';
	@override String get welcomeBack => 'Bon retour';
	@override String get sendResetLink => 'Envoyer le lien de réinitialisation';
	@override String get resetPasswordTitle => 'Réinitialiser votre mot de passe';
	@override String get resetPasswordSubtitle => 'Entrez votre nouveau mot de passe ci-dessous';
	@override String get forgotPasswordSubtitle => 'Entrez votre email et nous vous enverrons un lien de réinitialisation';
	@override String get orContinueWith => 'Ou continuez avec';
	@override String get google => 'Google';
	@override String get googleSignInDisabled => 'La connexion Google n\'est pas configurée';
}

// Path: catalog
class _Translations$catalog$fr implements Translations$catalog$en {
	_Translations$catalog$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get catalog => 'Catalogue';
	@override String get vehicleCatalog => 'Catalogue véhicules';
	@override String get makes => 'Marques';
	@override String get models => 'Modèles';
	@override String get specifications => 'Spécifications';
	@override String get engines => 'Moteurs';
	@override String get transmissions => 'Transmissions';
	@override String get searchMakes => 'Rechercher des marques...';
	@override String get searchModels => 'Rechercher des modèles...';
	@override String get selectMake => 'Sélectionner une marque';
	@override String get selectModel => 'Sélectionner un modèle';
	@override String get selectYear => 'Sélectionner une année';
	@override String get fuel => 'Carburant';
	@override String get bodyClass => 'Carrosserie';
	@override String get engine => 'Moteur';
	@override String get drivetrain => 'Transmission';
	@override String get noMakesFound => 'Aucune marque trouvée';
	@override String get noModelsFound => 'Aucun modèle trouvé';
	@override String get noResults => 'Aucun résultat';
	@override String get nothingMatches => 'Aucun résultat pour votre recherche.';
	@override String get clearSearch => 'Effacer la recherche';
	@override String get configurations => 'Configurations';
	@override String get selectVehicle => 'Sélectionner un véhicule';
	@override String get selectModelFirst => 'Sélectionnez d\'abord un modèle';
	@override String get useThisVehicle => 'Utiliser ce véhicule';
	@override String get startOver => 'Recommencer';
	@override String get yearLabel => 'Année :';
	@override String get gearsUnit => 'rapports';
	@override String get noYearsForModel => 'Aucune donnée pour ce modèle pour le moment';
	@override String get noConfigurations => 'Aucune configuration trouvée';
	@override String get noEngines => 'Aucun moteur trouvé';
	@override String get noTransmissions => 'Aucune boîte trouvée';
}

// Path: common
class _Translations$common$fr implements Translations$common$en {
	_Translations$common$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get appTitle => 'Autivo';
	@override String get loading => 'Chargement...';
	@override String get error => 'Erreur';
	@override String get success => 'Succès';
	@override String get retry => 'Réessayer';
	@override String get close => 'Fermer';
	@override String get confirm => 'Confirmer';
	@override String get back => 'Retour';
	@override String get next => 'Suivant';
	@override String get done => 'Terminé';
	@override String get skip => 'Ignorer';
	@override String get search => 'Rechercher';
	@override String get filter => 'Filtrer';
	@override String get sort => 'Trier';
	@override String get all => 'Tous';
	@override String get save => 'Enregistrer';
	@override String get cancel => 'Annuler';
	@override String get delete => 'Supprimer';
	@override String get edit => 'Modifier';
	@override String get update => 'Mettre à jour';
	@override String get create => 'Créer';
	@override String get status => 'Statut';
	@override String get active => 'Actif';
	@override String get maintenance => 'Maintenance requise';
	@override String get inactive => 'Inactif';
	@override String get notes => 'Notes';
	@override String get date => 'Date';
	@override String get title => 'Titre';
	@override String get cost => 'Coût';
	@override String get category => 'Catégorie';
	@override String get engine => 'Moteur';
	@override String get transmission => 'Transmission';
	@override String get mileage => 'Kilométrage';
	@override String get color => 'Couleur';
	@override String get colorName => 'Nom de la couleur';
	@override String get year => 'Année';
	@override String get overview => 'Aperçu';
	@override String get details => 'Détails';
	@override String get add => 'Ajouter';
	@override String get summary => 'Résumé';
	@override String get schedule => 'Planification';
	@override String get somethingWentWrong => 'Une erreur est survenue';
	@override String get couldNotLoadRecord => 'Impossible de charger cet enregistrement. Vérifiez votre connexion et réessayez.';
	@override String get selectDate => 'Choisir une date';
	@override String get required => 'Ce champ est obligatoire';
	@override String get invalidNumber => 'Saisissez un nombre valide';
	@override String get mustBePositive => 'Doit être supérieur à zéro';
	@override String get updated => 'Mis à jour';
}

// Path: errors
class _Translations$errors$fr implements Translations$errors$en {
	_Translations$errors$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get invalidCredentials => 'Identifiants invalides';
	@override String get emailAlreadyExists => 'Un compte avec cet email existe déjà';
	@override String get userNotFound => 'Utilisateur non trouvé';
	@override String get accountInactive => 'Compte inactif';
	@override String get rateLimitExceeded => 'Trop de requêtes. Veuillez réessayer plus tard.';
	@override String get validationError => 'Veuillez vérifier votre saisie';
	@override String get networkError => 'Erreur réseau. Vérifiez votre connexion.';
	@override String get unknownError => 'Une erreur inconnue s\'est produite';
	@override String get sessionExpired => 'Votre session a expiré. Veuillez vous reconnecter.';
	@override String get carNotFound => 'Véhicule non trouvé';
	@override String get maintenanceNotFound => 'Enregistrement d\'entretien non trouvé';
	@override String get vinAlreadyExistsInGarage => 'Un véhicule avec ce VIN existe déjà dans votre garage';
	@override String get invalidVinFormat => 'Format de VIN invalide';
	@override String get vinDecodeFailed => 'Échec du décodage du VIN. Veuillez vérifier le numéro et réessayer.';
	@override String get accessDenied => 'Vous n\'avez pas la permission d\'effectuer cette action';
	@override String get notFound => 'Ressource non trouvée';
	@override String get conflict => 'Un conflit s\'est produit avec votre requête';
	@override String get missingParameter => 'Un paramètre requis est manquant';
	@override String get malformedJson => 'Les données de la requête sont invalides';
	@override String get internalServerError => 'Une erreur interne s\'est produite. Veuillez réessayer plus tard.';
}

// Path: garage
class _Translations$garage$fr implements Translations$garage$en {
	_Translations$garage$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get garage => 'Garage';
	@override String get addVehicle => 'Ajouter un véhicule';
	@override String get addCar => 'Ajouter une voiture';
	@override String get noVehicles => 'Aucun véhicule pour l\'instant';
	@override String get noVehiclesSubtitle => 'Ajoutez votre première voiture pour commencer';
	@override String get scanVin => 'Scanner le VIN';
	@override String get manualEntry => 'Saisie manuelle';
	@override String get vinDecode => 'Décodage VIN';
	@override String get decode => 'Décoder';
	@override String get make => 'Marque';
	@override String get model => 'Modèle';
	@override String get fuelType => 'Type de carburant';
	@override String get vin => 'VIN';
	@override String get licensePlate => 'Plaque d\'immatriculation';
	@override String get serviceInterval => 'Intervalle de service (km)';
	@override String get healthScore => 'Score de santé';
	@override String get excellent => 'Excellent';
	@override String get good => 'Bon';
	@override String get fair => 'Moyen';
	@override String get poor => 'Mauvais';
	@override String get upcomingMaintenance => 'Entretiens à venir';
	@override String get dashboardSubtitle => 'Tout pour vos véhicules au même endroit';
	@override String get sectionVehicles => 'Mes véhicules';
	@override String get vehicles => 'Véhicules';
	@override String get active => 'Actives';
	@override String get inMaintenance => 'En maintenance';
	@override String get scanOrEnterVin => 'Scanner ou saisir le VIN';
	@override String get vinDecodeSubtitle => 'Saisissez un VIN de 17 caractères pour décoder les informations du véhicule';
	@override String get vinScanUnavailable => 'Le scan par caméra n\'est pas encore disponible. Saisissez le VIN manuellement.';
	@override String get decodedResult => 'Résultat du décodage';
	@override String get addToGarage => 'Ajouter au garage';
	@override String get trim => 'Finition';
	@override String get source => 'Source';
	@override String get confidence => 'Confiance';
	@override String get bodyClass => 'Carrosserie';
	@override String get drivetrain => 'Transmission';
	@override String get missingFields => 'Manquant : {fields}';
	@override String get browseCatalog => 'Parcourir le catalogue';
	@override String get fromCatalog => 'Depuis le catalogue';
}

// Path: parts
class _Translations$parts$fr implements Translations$parts$en {
	_Translations$parts$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get parts => 'Pièces';
	@override String get partStatus => 'Statut de la pièce';
	@override String get original => 'Origine';
	@override String get replaced => 'Remplacé';
	@override String get serviced => 'Entretien effectué';
	@override String get worn => 'Usé';
	@override String get damaged => 'Endommagé';
	@override String get replacedAt => 'Remplacé le';
	@override String get mileageAtReplacement => 'Kilométrage au remplacement';
	@override String get partStatusLegend => 'Légende des statuts de pièces';
	@override String get engineParts => 'Moteur et transmission';
	@override String get brakeParts => 'Freins';
	@override String get suspensionParts => 'Suspension';
	@override String get tireParts => 'Pneus';
	@override String get bodyParts => 'Carrosserie et extérieur';
	@override String get electricalParts => 'Électrique';
	@override String get vehicleHealthMap => 'Carte de santé du véhicule';
	@override String get tapZonesHint => 'Touchez une zone pour mettre à jour son statut';
	@override String get partCategories => 'Catégories de pièces';
	@override String get noPartsTracked => 'Aucune pièce suivie';
	@override String get noPartsTrackedSubtitle => 'Les pièces ajoutées apparaîtront ici, regroupées par système.';
	@override String get mileageAtMaintenance => 'Kilométrage lors de l\'entretien';
	@override String get conditionDetailsHint => 'Ajoutez des détails sur l\'état...';
}

// Path: profile
class _Translations$profile$fr implements Translations$profile$en {
	_Translations$profile$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get profile => 'Profil';
	@override String get settings => 'Paramètres';
	@override String get security => 'Sécurité';
	@override String get changeEmail => 'Changer l\'email';
	@override String get changePassword => 'Changer le mot de passe';
	@override String get logout => 'Déconnexion';
	@override String get language => 'Langue';
	@override String get distanceUnit => 'Unité de distance';
	@override String get currency => 'Devise';
	@override String get preferences => 'Préférences';
	@override String get avatar => 'Avatar';
	@override String get removeAvatar => 'Supprimer l\'avatar';
	@override String get selectImage => 'Sélectionner une image';
	@override String get camera => 'Appareil photo';
	@override String get gallery => 'Galerie';
	@override String get changeEmailTitle => 'Changer l\'adresse email';
	@override String get changePasswordTitle => 'Changer le mot de passe';
	@override String get newEmail => 'Nouvel email';
	@override String get emailChanged => 'Email modifié avec succès';
	@override String get passwordChanged => 'Mot de passe modifié avec succès. Veuillez vous reconnecter.';
	@override String get selectLanguage => 'Sélectionner la langue';
	@override String get selectDistanceUnit => 'Sélectionner l\'unité de distance';
	@override String get selectCurrency => 'Sélectionner la devise';
	@override String get kilometers => 'Kilomètres (km)';
	@override String get miles => 'Miles (mi)';
	@override String get tunisianDinar => 'Dinar tunisien (TND)';
	@override String get euro => 'Euro (EUR)';
	@override String get usDollar => 'Dollar US (USD)';
	@override String get english => 'Anglais';
	@override String get french => 'Français';
	@override String get arabic => 'Arabe';
	@override String get darkMode => 'Mode sombre';
	@override String get lightMode => 'Mode clair';
	@override String get theme => 'Thème';
	@override String get appearance => 'Apparence';
	@override String get themeWhite => 'Blanc';
	@override String get themeBlack => 'Noir';
	@override String get themeNightOwl => 'Night Owl';
	@override String get about => 'À propos';
	@override String get version => 'Version';
	@override String get buildNumber => 'Build';
	@override String get privacyPolicy => 'Politique de confidentialité';
	@override String get termsOfService => 'Conditions d\'utilisation';
	@override String get contactSupport => 'Contacter le support';
	@override String get appDescription => 'Gestion intelligente de véhicule et suivi d\'entretien';
	@override String get welcome => 'Bienvenue sur Autivo';
	@override String get welcomeSubtitle => 'Votre compagnon véhicule intelligent';
	@override String get getStarted => 'Commencer';
}

// Path: services
class _Translations$services$fr implements Translations$services$en {
	_Translations$services$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get services => 'Services';
	@override String get maintenanceRecords => 'Historique d\'entretien';
	@override String get addMaintenance => 'Ajouter un entretien';
	@override String get maintenanceType => 'Type';
	@override String get nextServiceMileage => 'Prochain service (km)';
	@override String get nextServiceDue => 'Prochain service dû';
	@override String get nextServiceKm => 'Prochain service (km)';
	@override String get schedule => 'Planification';
	@override String get partsReplaced => 'Pièces remplacées';
	@override String get allPartsAdded => 'Toutes les pièces sont ajoutées';
	@override String get addPartsReplaced => 'Ajouter des pièces remplacées';
	@override String get recordNotFound => 'Enregistrement introuvable';
	@override String get overdue => 'En retard';
	@override String get allCaughtUp => 'Tout est à jour !';
	@override String get noUpcomingMaintenance => 'Aucun entretien à venir pour ce véhicule.';
	@override String get kmLeft => 'km restants';
}

/// The flat map containing all translations for locale <fr>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsFr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'auth.login' => 'Connexion',
			'auth.register' => 'Inscription',
			'auth.email' => 'E-mail',
			'auth.password' => 'Mot de passe',
			'auth.confirmPassword' => 'Confirmer le mot de passe',
			'auth.firstName' => 'Prénom',
			'auth.lastName' => 'Nom',
			'auth.forgotPassword' => 'Mot de passe oublié ?',
			'auth.resetPassword' => 'Réinitialiser le mot de passe',
			'auth.newPassword' => 'Nouveau mot de passe',
			'auth.currentPassword' => 'Mot de passe actuel',
			'auth.dontHaveAccount' => 'Pas de compte ?',
			'auth.alreadyHaveAccount' => 'Déjà un compte ?',
			'auth.signUp' => 'S\'inscrire',
			'auth.signIn' => 'Se connecter',
			'auth.welcomeBack' => 'Bon retour',
			'auth.sendResetLink' => 'Envoyer le lien de réinitialisation',
			'auth.resetPasswordTitle' => 'Réinitialiser votre mot de passe',
			'auth.resetPasswordSubtitle' => 'Entrez votre nouveau mot de passe ci-dessous',
			'auth.forgotPasswordSubtitle' => 'Entrez votre email et nous vous enverrons un lien de réinitialisation',
			'auth.orContinueWith' => 'Ou continuez avec',
			'auth.google' => 'Google',
			'auth.googleSignInDisabled' => 'La connexion Google n\'est pas configurée',
			'catalog.catalog' => 'Catalogue',
			'catalog.vehicleCatalog' => 'Catalogue véhicules',
			'catalog.makes' => 'Marques',
			'catalog.models' => 'Modèles',
			'catalog.specifications' => 'Spécifications',
			'catalog.engines' => 'Moteurs',
			'catalog.transmissions' => 'Transmissions',
			'catalog.searchMakes' => 'Rechercher des marques...',
			'catalog.searchModels' => 'Rechercher des modèles...',
			'catalog.selectMake' => 'Sélectionner une marque',
			'catalog.selectModel' => 'Sélectionner un modèle',
			'catalog.selectYear' => 'Sélectionner une année',
			'catalog.fuel' => 'Carburant',
			'catalog.bodyClass' => 'Carrosserie',
			'catalog.engine' => 'Moteur',
			'catalog.drivetrain' => 'Transmission',
			'catalog.noMakesFound' => 'Aucune marque trouvée',
			'catalog.noModelsFound' => 'Aucun modèle trouvé',
			'catalog.noResults' => 'Aucun résultat',
			'catalog.nothingMatches' => 'Aucun résultat pour votre recherche.',
			'catalog.clearSearch' => 'Effacer la recherche',
			'catalog.configurations' => 'Configurations',
			'catalog.selectVehicle' => 'Sélectionner un véhicule',
			'catalog.selectModelFirst' => 'Sélectionnez d\'abord un modèle',
			'catalog.useThisVehicle' => 'Utiliser ce véhicule',
			'catalog.startOver' => 'Recommencer',
			'catalog.yearLabel' => 'Année :',
			'catalog.gearsUnit' => 'rapports',
			'catalog.noYearsForModel' => 'Aucune donnée pour ce modèle pour le moment',
			'catalog.noConfigurations' => 'Aucune configuration trouvée',
			'catalog.noEngines' => 'Aucun moteur trouvé',
			'catalog.noTransmissions' => 'Aucune boîte trouvée',
			'common.appTitle' => 'Autivo',
			'common.loading' => 'Chargement...',
			'common.error' => 'Erreur',
			'common.success' => 'Succès',
			'common.retry' => 'Réessayer',
			'common.close' => 'Fermer',
			'common.confirm' => 'Confirmer',
			'common.back' => 'Retour',
			'common.next' => 'Suivant',
			'common.done' => 'Terminé',
			'common.skip' => 'Ignorer',
			'common.search' => 'Rechercher',
			'common.filter' => 'Filtrer',
			'common.sort' => 'Trier',
			'common.all' => 'Tous',
			'common.save' => 'Enregistrer',
			'common.cancel' => 'Annuler',
			'common.delete' => 'Supprimer',
			'common.edit' => 'Modifier',
			'common.update' => 'Mettre à jour',
			'common.create' => 'Créer',
			'common.status' => 'Statut',
			'common.active' => 'Actif',
			'common.maintenance' => 'Maintenance requise',
			'common.inactive' => 'Inactif',
			'common.notes' => 'Notes',
			'common.date' => 'Date',
			'common.title' => 'Titre',
			'common.cost' => 'Coût',
			'common.category' => 'Catégorie',
			'common.engine' => 'Moteur',
			'common.transmission' => 'Transmission',
			'common.mileage' => 'Kilométrage',
			'common.color' => 'Couleur',
			'common.colorName' => 'Nom de la couleur',
			'common.year' => 'Année',
			'common.overview' => 'Aperçu',
			'common.details' => 'Détails',
			'common.add' => 'Ajouter',
			'common.summary' => 'Résumé',
			'common.schedule' => 'Planification',
			'common.somethingWentWrong' => 'Une erreur est survenue',
			'common.couldNotLoadRecord' => 'Impossible de charger cet enregistrement. Vérifiez votre connexion et réessayez.',
			'common.selectDate' => 'Choisir une date',
			'common.required' => 'Ce champ est obligatoire',
			'common.invalidNumber' => 'Saisissez un nombre valide',
			'common.mustBePositive' => 'Doit être supérieur à zéro',
			'common.updated' => 'Mis à jour',
			'errors.invalidCredentials' => 'Identifiants invalides',
			'errors.emailAlreadyExists' => 'Un compte avec cet email existe déjà',
			'errors.userNotFound' => 'Utilisateur non trouvé',
			'errors.accountInactive' => 'Compte inactif',
			'errors.rateLimitExceeded' => 'Trop de requêtes. Veuillez réessayer plus tard.',
			'errors.validationError' => 'Veuillez vérifier votre saisie',
			'errors.networkError' => 'Erreur réseau. Vérifiez votre connexion.',
			'errors.unknownError' => 'Une erreur inconnue s\'est produite',
			'errors.sessionExpired' => 'Votre session a expiré. Veuillez vous reconnecter.',
			'errors.carNotFound' => 'Véhicule non trouvé',
			'errors.maintenanceNotFound' => 'Enregistrement d\'entretien non trouvé',
			'errors.vinAlreadyExistsInGarage' => 'Un véhicule avec ce VIN existe déjà dans votre garage',
			'errors.invalidVinFormat' => 'Format de VIN invalide',
			'errors.vinDecodeFailed' => 'Échec du décodage du VIN. Veuillez vérifier le numéro et réessayer.',
			'errors.accessDenied' => 'Vous n\'avez pas la permission d\'effectuer cette action',
			'errors.notFound' => 'Ressource non trouvée',
			'errors.conflict' => 'Un conflit s\'est produit avec votre requête',
			'errors.missingParameter' => 'Un paramètre requis est manquant',
			'errors.malformedJson' => 'Les données de la requête sont invalides',
			'errors.internalServerError' => 'Une erreur interne s\'est produite. Veuillez réessayer plus tard.',
			'garage.garage' => 'Garage',
			'garage.addVehicle' => 'Ajouter un véhicule',
			'garage.addCar' => 'Ajouter une voiture',
			'garage.noVehicles' => 'Aucun véhicule pour l\'instant',
			'garage.noVehiclesSubtitle' => 'Ajoutez votre première voiture pour commencer',
			'garage.scanVin' => 'Scanner le VIN',
			'garage.manualEntry' => 'Saisie manuelle',
			'garage.vinDecode' => 'Décodage VIN',
			'garage.decode' => 'Décoder',
			'garage.make' => 'Marque',
			'garage.model' => 'Modèle',
			'garage.fuelType' => 'Type de carburant',
			'garage.vin' => 'VIN',
			'garage.licensePlate' => 'Plaque d\'immatriculation',
			'garage.serviceInterval' => 'Intervalle de service (km)',
			'garage.healthScore' => 'Score de santé',
			'garage.excellent' => 'Excellent',
			'garage.good' => 'Bon',
			'garage.fair' => 'Moyen',
			'garage.poor' => 'Mauvais',
			'garage.upcomingMaintenance' => 'Entretiens à venir',
			'garage.dashboardSubtitle' => 'Tout pour vos véhicules au même endroit',
			'garage.sectionVehicles' => 'Mes véhicules',
			'garage.vehicles' => 'Véhicules',
			'garage.active' => 'Actives',
			'garage.inMaintenance' => 'En maintenance',
			'garage.scanOrEnterVin' => 'Scanner ou saisir le VIN',
			'garage.vinDecodeSubtitle' => 'Saisissez un VIN de 17 caractères pour décoder les informations du véhicule',
			'garage.vinScanUnavailable' => 'Le scan par caméra n\'est pas encore disponible. Saisissez le VIN manuellement.',
			'garage.decodedResult' => 'Résultat du décodage',
			'garage.addToGarage' => 'Ajouter au garage',
			'garage.trim' => 'Finition',
			'garage.source' => 'Source',
			'garage.confidence' => 'Confiance',
			'garage.bodyClass' => 'Carrosserie',
			'garage.drivetrain' => 'Transmission',
			'garage.missingFields' => 'Manquant : {fields}',
			'garage.browseCatalog' => 'Parcourir le catalogue',
			'garage.fromCatalog' => 'Depuis le catalogue',
			'parts.parts' => 'Pièces',
			'parts.partStatus' => 'Statut de la pièce',
			'parts.original' => 'Origine',
			'parts.replaced' => 'Remplacé',
			'parts.serviced' => 'Entretien effectué',
			'parts.worn' => 'Usé',
			'parts.damaged' => 'Endommagé',
			'parts.replacedAt' => 'Remplacé le',
			'parts.mileageAtReplacement' => 'Kilométrage au remplacement',
			'parts.partStatusLegend' => 'Légende des statuts de pièces',
			'parts.engineParts' => 'Moteur et transmission',
			'parts.brakeParts' => 'Freins',
			'parts.suspensionParts' => 'Suspension',
			'parts.tireParts' => 'Pneus',
			'parts.bodyParts' => 'Carrosserie et extérieur',
			'parts.electricalParts' => 'Électrique',
			'parts.vehicleHealthMap' => 'Carte de santé du véhicule',
			'parts.tapZonesHint' => 'Touchez une zone pour mettre à jour son statut',
			'parts.partCategories' => 'Catégories de pièces',
			'parts.noPartsTracked' => 'Aucune pièce suivie',
			'parts.noPartsTrackedSubtitle' => 'Les pièces ajoutées apparaîtront ici, regroupées par système.',
			'parts.mileageAtMaintenance' => 'Kilométrage lors de l\'entretien',
			'parts.conditionDetailsHint' => 'Ajoutez des détails sur l\'état...',
			'profile.profile' => 'Profil',
			'profile.settings' => 'Paramètres',
			'profile.security' => 'Sécurité',
			'profile.changeEmail' => 'Changer l\'email',
			'profile.changePassword' => 'Changer le mot de passe',
			'profile.logout' => 'Déconnexion',
			'profile.language' => 'Langue',
			'profile.distanceUnit' => 'Unité de distance',
			'profile.currency' => 'Devise',
			'profile.preferences' => 'Préférences',
			'profile.avatar' => 'Avatar',
			'profile.removeAvatar' => 'Supprimer l\'avatar',
			'profile.selectImage' => 'Sélectionner une image',
			'profile.camera' => 'Appareil photo',
			'profile.gallery' => 'Galerie',
			'profile.changeEmailTitle' => 'Changer l\'adresse email',
			'profile.changePasswordTitle' => 'Changer le mot de passe',
			'profile.newEmail' => 'Nouvel email',
			'profile.emailChanged' => 'Email modifié avec succès',
			'profile.passwordChanged' => 'Mot de passe modifié avec succès. Veuillez vous reconnecter.',
			'profile.selectLanguage' => 'Sélectionner la langue',
			'profile.selectDistanceUnit' => 'Sélectionner l\'unité de distance',
			'profile.selectCurrency' => 'Sélectionner la devise',
			'profile.kilometers' => 'Kilomètres (km)',
			'profile.miles' => 'Miles (mi)',
			'profile.tunisianDinar' => 'Dinar tunisien (TND)',
			'profile.euro' => 'Euro (EUR)',
			'profile.usDollar' => 'Dollar US (USD)',
			'profile.english' => 'Anglais',
			'profile.french' => 'Français',
			'profile.arabic' => 'Arabe',
			'profile.darkMode' => 'Mode sombre',
			'profile.lightMode' => 'Mode clair',
			'profile.theme' => 'Thème',
			'profile.appearance' => 'Apparence',
			'profile.themeWhite' => 'Blanc',
			'profile.themeBlack' => 'Noir',
			'profile.themeNightOwl' => 'Night Owl',
			'profile.about' => 'À propos',
			'profile.version' => 'Version',
			'profile.buildNumber' => 'Build',
			'profile.privacyPolicy' => 'Politique de confidentialité',
			'profile.termsOfService' => 'Conditions d\'utilisation',
			'profile.contactSupport' => 'Contacter le support',
			'profile.appDescription' => 'Gestion intelligente de véhicule et suivi d\'entretien',
			'profile.welcome' => 'Bienvenue sur Autivo',
			'profile.welcomeSubtitle' => 'Votre compagnon véhicule intelligent',
			'profile.getStarted' => 'Commencer',
			'services.services' => 'Services',
			'services.maintenanceRecords' => 'Historique d\'entretien',
			'services.addMaintenance' => 'Ajouter un entretien',
			'services.maintenanceType' => 'Type',
			'services.nextServiceMileage' => 'Prochain service (km)',
			'services.nextServiceDue' => 'Prochain service dû',
			'services.nextServiceKm' => 'Prochain service (km)',
			'services.schedule' => 'Planification',
			'services.partsReplaced' => 'Pièces remplacées',
			'services.allPartsAdded' => 'Toutes les pièces sont ajoutées',
			'services.addPartsReplaced' => 'Ajouter des pièces remplacées',
			'services.recordNotFound' => 'Enregistrement introuvable',
			'services.overdue' => 'En retard',
			'services.allCaughtUp' => 'Tout est à jour !',
			'services.noUpcomingMaintenance' => 'Aucun entretien à venir pour ce véhicule.',
			'services.kmLeft' => 'km restants',
			_ => null,
		};
	}
}
