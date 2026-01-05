import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/hardware_service.dart';

class HardwareGridItem extends StatelessWidget {
  final HardwareComponent component;

  const HardwareGridItem({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    Color statusColor = Colors.green;
    if (component.status == 'Warning') statusColor = Colors.orange;
    if (component.status == 'Error') statusColor = Colors.red;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(_getIconForType(component.type), color: colorScheme.primary, size: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: statusColor.withOpacity(0.5)),
                  ),
                  child: Text(
                    component.status.toUpperCase(),
                    style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              component.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              component.id,
              style: TextStyle(color: Colors.grey[600], fontSize: 10),
            ),
            const Spacer(),
            
            // Metrics
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMetric("LOAD", "${(component.load * 100).toInt()}%"),
                _buildMetric("TEMP", "${component.temperature.toInt()}°C"),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: component.load,
              backgroundColor: Colors.grey[800],
              valueColor: AlwaysStoppedAnimation<Color>(
                component.load > 0.8 ? Colors.red : colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 8),
            
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {},
                  child: Text("CONFIG", style: TextStyle(color: colorScheme.primary, fontSize: 10)),
                ),
                const SizedBox(width: 12),
                InkWell(
                  onTap: () {},
                  child: Text("RESET", style: TextStyle(color: colorScheme.error, fontSize: 10)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMetric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 9, color: Colors.grey)),
        Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
      ],
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'CPU': return FontAwesomeIcons.microchip;
      case 'GPU': return FontAwesomeIcons.display;
      case 'RAM': return FontAwesomeIcons.memory;
      case 'I/O': return FontAwesomeIcons.usb;
      case 'NETWORK': return FontAwesomeIcons.networkWired;
      default: return FontAwesomeIcons.server;
    }
  }
}
