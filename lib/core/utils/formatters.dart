import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../app/theme/racing_theme.dart';
import '../constants/app_constants.dart';

String formatDate(DateTime date, {String? locale}) {
  final format = DateFormat.yMMMd(locale);
  return format.format(date);
}

String formatDateTime(DateTime date, {String? locale}) {
  final format = DateFormat.yMMMd(locale).add_jm();
  return format.format(date);
}

String formatShortDate(DateTime date, {String? locale}) {
  final format = DateFormat.yMd(locale);
  return format.format(date);
}

String formatCurrency(num amount, {String? currencyCode, String? locale}) {
  final format = NumberFormat.currency(
    locale: locale,
    symbol: currencyCode ?? 'TND',
    decimalDigits: 2,
  );
  return format.format(amount);
}

String formatNumber(num value, {String? locale}) {
  final format = NumberFormat.compact(locale: locale);
  return format.format(value);
}

String formatMileage(int km, {String? locale, String? distanceUnit}) {
  if (distanceUnit == 'mi') {
    final miles = (km / 1.60934).round();
    return '$miles mi';
  }
  return '$km km';
}

String getStatusLabel(String status, {String? locale}) {
  switch (status) {
    case 'active':
      return locale == 'ar' ? 'نشط' : (locale == 'fr' ? 'Actif' : 'Active');
    case 'maintenance':
      return locale == 'ar'
          ? 'صيانة مطلوبة'
          : (locale == 'fr' ? 'Maintenance requise' : 'Maintenance Due');
    case 'inactive':
      return locale == 'ar'
          ? 'غير نشط'
          : (locale == 'fr' ? 'Inactif' : 'Inactive');
    default:
      return status;
  }
}

String getFuelTypeLabel(String fuelType, {String? locale}) {
  final labels = FuelTypes.labels;
  if (locale == 'ar') {
    const arLabels = {
      'gasoline': 'بنزين',
      'diesel': 'ديزل',
      'electric': 'كهربائي',
      'hybrid': 'هجين',
      'flex_fuel': 'وقود مرن',
    };
    return arLabels[fuelType] ?? fuelType;
  }
  if (locale == 'fr') {
    const frLabels = {
      'gasoline': 'Essence',
      'diesel': 'Diesel',
      'electric': 'Électrique',
      'hybrid': 'Hybride',
      'flex_fuel': 'Carburant flexible',
    };
    return frLabels[fuelType] ?? fuelType;
  }
  return labels[fuelType] ?? fuelType;
}

String getPartStatusLabel(String status, {String? locale}) {
  if (locale == 'ar') {
    const arLabels = {
      'original': 'أصلي',
      'replaced': 'مستبدل',
      'serviced': 'مخدوم',
      'worn': 'بالي',
      'damaged': 'تالف',
    };
    return arLabels[status] ?? status;
  }
  if (locale == 'fr') {
    const frLabels = {
      'original': 'Origine',
      'replaced': 'Remplacé',
      'serviced': 'Entretenu',
      'worn': 'Usé',
      'damaged': 'Endommagé',
    };
    return frLabels[status] ?? status;
  }
  return PartStatuses.labels[status] ?? status;
}

String getMaintenanceTypeLabel(String type, {String? locale}) {
  if (locale == 'ar') {
    const arLabels = {
      'maintenance': 'صيانة',
      'repair': 'إصلاح',
      'paint': 'دهان',
      'accident': 'حادث',
      'fuel': 'وقود',
      'document': 'وثائق',
      'inspection': 'فحص',
      'modification': 'تعديل',
      'tires': 'إطارات',
      'battery': 'بطارية',
      'electrical': 'كهرباء',
    };
    return arLabels[type] ?? type;
  }
  if (locale == 'fr') {
    const frLabels = {
      'maintenance': 'Maintenance',
      'repair': 'Réparation',
      'paint': 'Peinture',
      'accident': 'Accident',
      'fuel': 'Carburant',
      'document': 'Document',
      'inspection': 'Inspection',
      'modification': 'Modification',
      'tires': 'Pneus',
      'battery': 'Batterie',
      'electrical': 'Électrique',
    };
    return frLabels[type] ?? type;
  }
  return MaintenanceTypes.labels[type] ?? type;
}

String getPartLabel(String partId, {String? locale}) {
  if (locale == 'ar') {
    const arLabels = {
      'engine': 'المحرك',
      'battery': 'البطارية',
      'alternator': 'المولد',
      'radiator': 'الردياتير',
      'air-filter': 'فلتر الهواء',
      'oil-filter': 'فلتر الزيت',
      'belts': 'الأحزمة',
      'transmission': 'ناقل الحركة',
      'front-left-brake': 'فرامل أمامي يسار',
      'front-right-brake': 'فرامل أمامي يمين',
      'rear-left-brake': 'فرامل خلفي يسار',
      'rear-right-brake': 'فرامل خلفي يمين',
      'front-left-suspension': 'تعليق أمامي يسار',
      'front-right-suspension': 'تعليق أمامي يمين',
      'rear-left-suspension': 'تعليق خلفي يسار',
      'rear-right-suspension': 'تعليق خلفي يمين',
      'front-left-tire': 'إطار أمامي يسار',
      'front-right-tire': 'إطار أمامي يمين',
      'rear-left-tire': 'إطار خلفي يسار',
      'rear-right-tire': 'إطار خلفي يمين',
      'exhaust': 'العادم',
      'fuel-system': 'نظام الوقود',
      'cooling': 'نظام التبريد',
      'steering': 'التوجيه',
      'headlights': 'المصابيح الأمامية',
      'tail-lights': 'المصابيح الخلفية',
      'body-front': 'الهيكل الأمامي',
      'body-rear': 'الهيكل الخلفي',
      'interior': 'الداخلية',
      'electrical': 'النظام الكهربائي',
    };
    return arLabels[partId] ?? partId;
  }
  if (locale == 'fr') {
    const frLabels = {
      'engine': 'Moteur',
      'battery': 'Batterie',
      'alternator': 'Alternateur',
      'radiator': 'Radiateur',
      'air-filter': 'Filtre à air',
      'oil-filter': 'Filtre à huile',
      'belts': 'Courroies',
      'transmission': 'Transmission',
      'front-left-brake': 'Frein AV G',
      'front-right-brake': 'Frein AV D',
      'rear-left-brake': 'Frein AR G',
      'rear-right-brake': 'Frein AR D',
      'front-left-suspension': 'Suspension AV G',
      'front-right-suspension': 'Suspension AV D',
      'rear-left-suspension': 'Suspension AR G',
      'rear-right-suspension': 'Suspension AR D',
      'front-left-tire': 'Pneu AV G',
      'front-right-tire': 'Pneu AV D',
      'rear-left-tire': 'Pneu AR G',
      'rear-right-tire': 'Pneu AR D',
      'exhaust': 'Échappement',
      'fuel-system': 'Système carburant',
      'cooling': 'Refroidissement',
      'steering': 'Direction',
      'headlights': 'Phares',
      'tail-lights': 'Feux arrière',
      'body-front': 'Carrosserie AV',
      'body-rear': 'Carrosserie AR',
      'interior': 'Intérieur',
      'electrical': 'Électrique',
    };
    return frLabels[partId] ?? partId;
  }
  return ValidPartIds.labels[partId] ?? partId;
}

String getPartGroup(String partId) =>
    ValidPartIds.groups[partId] ?? 'engineParts';

int calculateHealthScore(List<Map<String, dynamic>> parts) {
  if (parts.isEmpty) return 100;

  int score = 100;
  for (final part in parts) {
    final status = part['status'] as String? ?? 'original';
    switch (status) {
      case 'original':
        break;
      case 'replaced':
      case 'serviced':
        score -= 2;
      case 'worn':
        score -= 10;
      case 'damaged':
        score -= 25;
    }
  }
  return score.clamp(0, 100);
}

String getHealthLabel(int score, {String? locale}) {
  if (score >= 90) {
    return locale == 'ar'
        ? 'ممتاز'
        : (locale == 'fr' ? 'Excellent' : 'Excellent');
  }
  if (score >= 75) {
    return locale == 'ar' ? 'جيد' : (locale == 'fr' ? 'Bon' : 'Good');
  }
  if (score >= 50) {
    return locale == 'ar' ? 'مقبول' : (locale == 'fr' ? 'Moyen' : 'Fair');
  }
  return locale == 'ar' ? 'ضعيف' : (locale == 'fr' ? 'Mauvais' : 'Poor');
}

Color getHealthColor(int score) {
  if (score >= 90) return StatusColors.active;
  if (score >= 75) return StatusColors.maintenance;
  if (score >= 50) return StatusColors.worn;
  return StatusColors.damaged;
}

bool isValidEmail(String email) {
  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
}

bool isStrongPassword(String password) {
  if (password.length < 8 || password.length > 128) return false;
  if (!RegExp('[a-z]').hasMatch(password)) return false;
  if (!RegExp('[A-Z]').hasMatch(password)) return false;
  if (!RegExp('[0-9]').hasMatch(password)) return false;
  if (!RegExp('[^A-Za-z0-9]').hasMatch(password)) return false;
  return true;
}

bool isValidVin(String vin) {
  final normalized = vin.trim().toUpperCase();
  if (normalized.length != 17) return false;
  if (!RegExp(r'^[A-Z0-9]+$').hasMatch(normalized)) return false;
  if (RegExp('[IOQ]').hasMatch(normalized)) return false;
  return true;
}

extension StringExtensions on String {
  String capitalize() =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  String toTitleCase() => split(' ').map((w) => w.capitalize()).join(' ');
}
