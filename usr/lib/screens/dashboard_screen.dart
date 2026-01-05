import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/hardware_service.dart';
import '../widgets/hardware_grid_item.dart';
import '../widgets/system_log_panel.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hardwareService = Provider.of<HardwareService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(FontAwesomeIcons.microchip, color: Color(0xFF00FFC2)),
            const SizedBox(width: 12),
            const Text('TITANIUM // HARDWARE INTERFACE'),
          ],
        ),
        backgroundColor: const Color(0xFF0A0E14),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {}, // Would trigger full bus rescan
            tooltip: 'Rescan Hardware Bus',
          ),
          IconButton(
            icon: const Icon(Icons.settings_input_component),
            onPressed: () {},
            tooltip: 'Port Configuration',
          ),
          IconButton(
            icon: const Icon(Icons.power_settings_new, color: Colors.red),
            onPressed: () {},
            tooltip: 'Emergency Halt',
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Row(
        children: [
          // Left Sidebar (Navigation/Global Stats)
          Container(
            width: 80,
            color: const Color(0xFF161B22),
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildSideIcon(Icons.dashboard, true),
                _buildSideIcon(Icons.memory, false),
                _buildSideIcon(Icons.storage, false),
                _buildSideIcon(Icons.usb, false),
                _buildSideIcon(Icons.security, false),
                const Spacer(),
                _buildSideIcon(Icons.settings, false),
                const SizedBox(height: 20),
              ],
            ),
          ),
          
          // Main Content Area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status Header
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).primaryColor.withOpacity(0.05),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("SYSTEM INTEGRITY: 100%", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                        Text("KERNEL MODE: ACTIVE", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                        const Text("UPTIME: 00:42:15", style: TextStyle(fontFamily: 'monospace')),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Hardware Grid
                  Expanded(
                    flex: 2,
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // Responsive in real app
                        childAspectRatio: 1.4,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: hardwareService.components.length,
                      itemBuilder: (context, index) {
                        return HardwareGridItem(component: hardwareService.components[index]);
                      },
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  const Text("SYSTEM EVENT LOG // REAL-TIME KERNEL OUTPUT", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 8),
                  
                  // Log Panel
                  const Expanded(
                    flex: 1,
                    child: SystemLogPanel(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSideIcon(IconData icon, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: IconButton(
        icon: Icon(icon, color: isSelected ? const Color(0xFF00FFC2) : Colors.grey),
        onPressed: () {},
      ),
    );
  }
}
