import 'package:flutter/material.dart';

import 'app/app.dart';
import 'di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupDependencies();

  runApp(const AutivoApp());
}
