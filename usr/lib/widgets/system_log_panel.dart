import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/hardware_service.dart';

class SystemLogPanel extends StatelessWidget {
  const SystemLogPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final logs = Provider.of<HardwareService>(context).systemLogs;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.grey[800]!),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: logs.length,
        itemBuilder: (context, index) {
          final log = logs[index];
          Color logColor = const Color(0xFF00FFC2);
          if (log.contains("WARNING")) logColor = Colors.orange;
          if (log.contains("ERROR")) logColor = Colors.red;
          
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Text(
              log,
              style: TextStyle(
                color: logColor,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          );
        },
      ),
    );
  }
}
