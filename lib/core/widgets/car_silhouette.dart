import 'package:flutter/material.dart';
import '../../app/theme/racing_theme.dart';
import '../utils/formatters.dart';

class CarSilhouette extends StatefulWidget {
  final List<Map<String, dynamic>> parts;
  final Function(String partId)? onPartTap;
  final double size;

  const CarSilhouette({
    required this.parts,
    super.key,
    this.onPartTap,
    this.size = 300,
  });

  @override
  State<CarSilhouette> createState() => _CarSilhouetteState();
}

class _CarSilhouetteState extends State<CarSilhouette> {
  final Map<String, _PartPosition> _partPositions = {
    'engine': _PartPosition(0.5, 0.25),
    'battery': _PartPosition(0.3, 0.2),
    'alternator': _PartPosition(0.7, 0.2),
    'radiator': _PartPosition(0.5, 0.15),
    'air-filter': _PartPosition(0.4, 0.3),
    'oil-filter': _PartPosition(0.6, 0.3),
    'belts': _PartPosition(0.5, 0.35),
    'transmission': _PartPosition(0.5, 0.45),
    'front-left-brake': _PartPosition(0.2, 0.5),
    'front-right-brake': _PartPosition(0.8, 0.5),
    'rear-left-brake': _PartPosition(0.2, 0.75),
    'rear-right-brake': _PartPosition(0.8, 0.75),
    'front-left-suspension': _PartPosition(0.15, 0.45),
    'front-right-suspension': _PartPosition(0.85, 0.45),
    'rear-left-suspension': _PartPosition(0.15, 0.7),
    'rear-right-suspension': _PartPosition(0.85, 0.7),
    'front-left-tire': _PartPosition(0.1, 0.45),
    'front-right-tire': _PartPosition(0.9, 0.45),
    'rear-left-tire': _PartPosition(0.1, 0.75),
    'rear-right-tire': _PartPosition(0.9, 0.75),
    'exhaust': _PartPosition(0.5, 0.85),
    'fuel-system': _PartPosition(0.5, 0.55),
    'cooling': _PartPosition(0.5, 0.3),
    'steering': _PartPosition(0.5, 0.4),
    'headlights': _PartPosition(0.5, 0.1),
    'tail-lights': _PartPosition(0.5, 0.95),
    'body-front': _PartPosition(0.5, 0.05),
    'body-rear': _PartPosition(0.5, 0.98),
    'interior': _PartPosition(0.5, 0.6),
    'electrical': _PartPosition(0.3, 0.55),
  };

  Map<String, String> _getPartStatuses() {
    final map = <String, String>{};
    for (final part in widget.parts) {
      map[part['partId'] as String] = part['status'] as String? ?? 'original';
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final partStatuses = _getPartStatuses();

    return SizedBox(
      width: widget.size,
      height: widget.size * 0.5,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(widget.size, widget.size * 0.5),
            painter: _CarSilhouettePainter(
              theme: theme,
              partPositions: _partPositions,
              partStatuses: partStatuses,
              onPartTap: widget.onPartTap,
            ),
          ),
        ],
      ),
    );
  }
}

class _PartPosition {
  final double x;
  final double y;
  const _PartPosition(this.x, this.y);
}

class _CarSilhouettePainter extends CustomPainter {
  final ThemeData theme;
  final Map<String, _PartPosition> partPositions;
  final Map<String, String> partStatuses;
  final Function(String)? onPartTap;

  _CarSilhouettePainter({
    required this.theme,
    required this.partPositions,
    required this.partStatuses,
    this.onPartTap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = theme.dividerColor.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final fillPaint = Paint()
      ..color = theme.cardColor
      ..style = PaintingStyle.fill;

    // Car body outline
    final path = Path();
    path.moveTo(size.width * 0.1, size.height * 0.5);
    path.quadraticBezierTo(
      size.width * 0.1,
      size.height * 0.3,
      size.width * 0.2,
      size.height * 0.25,
    );
    path.lineTo(size.width * 0.4, size.height * 0.15);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.1,
      size.width * 0.6,
      size.height * 0.15,
    );
    path.lineTo(size.width * 0.8, size.height * 0.25);
    path.quadraticBezierTo(
      size.width * 0.9,
      size.height * 0.3,
      size.width * 0.9,
      size.height * 0.5,
    );
    path.lineTo(size.width * 0.9, size.height * 0.85);
    path.quadraticBezierTo(
      size.width * 0.9,
      size.height * 0.95,
      size.width * 0.8,
      size.height * 0.95,
    );
    path.lineTo(size.width * 0.2, size.height * 0.95);
    path.quadraticBezierTo(
      size.width * 0.1,
      size.height * 0.95,
      size.width * 0.1,
      size.height * 0.85,
    );
    path.close();

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, paint);

    // Wheels
    _drawWheel(canvas, size, size.width * 0.25, size.height * 0.85);
    _drawWheel(canvas, size, size.width * 0.75, size.height * 0.85);

    // Draw part indicators
    for (final entry in partPositions.entries) {
      final partId = entry.key;
      final pos = entry.value;
      final status = partStatuses[partId] ?? 'original';
      final x = size.width * pos.x;
      final y = size.height * pos.y;

      _drawPartIndicator(canvas, x, y, status);
    }
  }

  void _drawWheel(Canvas canvas, Size size, double cx, double cy) {
    final wheelPaint = Paint()
      ..color = theme.colorScheme.outline
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(Offset(cx, cy), 18, wheelPaint);
    canvas.drawCircle(Offset(cx, cy), 8, wheelPaint);
  }

  void _drawPartIndicator(Canvas canvas, double x, double y, String status) {
    Color color;
    switch (status) {
      case 'original':
        color = StatusColors.original;
      case 'replaced':
        color = StatusColors.replaced;
      case 'serviced':
        color = StatusColors.serviced;
      case 'worn':
        color = StatusColors.worn;
      case 'damaged':
        color = StatusColors.damaged;
      default:
        color = theme.colorScheme.onSurfaceVariant;
    }

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = theme.cardColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(Offset(x, y), 10, paint);
    canvas.drawCircle(Offset(x, y), 10, borderPaint);
  }

  @override
  bool shouldRepaint(covariant _CarSilhouettePainter oldDelegate) {
    return oldDelegate.partStatuses != partStatuses;
  }
}

class PartStatusLegend extends StatelessWidget {
  final String? locale;

  const PartStatusLegend({super.key, this.locale});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statuses = [
      ('original', StatusColors.original),
      ('replaced', StatusColors.replaced),
      ('serviced', StatusColors.serviced),
      ('worn', StatusColors.worn),
      ('damaged', StatusColors.damaged),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: statuses.map((s) {
        final label = getPartStatusLabel(s.$1, locale: locale);
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: s.$2, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
            Text(label, style: theme.textTheme.bodySmall),
          ],
        );
      }).toList(),
    );
  }
}
