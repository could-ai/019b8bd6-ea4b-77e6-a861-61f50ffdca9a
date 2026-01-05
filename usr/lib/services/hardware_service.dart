import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

// Models for Hardware Data
class HardwareComponent {
  final String id;
  final String name;
  final String type; // CPU, GPU, RAM, I/O, USB
  final String status; // Online, Idle, Busy, Error
  final double load; // 0.0 to 1.0
  final double temperature;
  final Map<String, dynamic> detailedStats;
  final List<String> logs;

  HardwareComponent({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    required this.load,
    required this.temperature,
    required this.detailedStats,
    required this.logs,
  });
}

class HardwareService extends ChangeNotifier {
  List<HardwareComponent> _components = [];
  List<String> _systemLogs = [];
  Timer? _simulationTimer;

  List<HardwareComponent> get components => _components;
  List<String> get systemLogs => _systemLogs;

  HardwareService() {
    _initializeMockHardware();
    _startMonitoring();
  }

  void _initializeMockHardware() {
    _components = [
      HardwareComponent(
        id: 'CPU-001',
        name: 'Core Processor Unit (Host)',
        type: 'CPU',
        status: 'Online',
        load: 0.15,
        temperature: 45.0,
        detailedStats: {'Cores': 16, 'Threads': 32, 'Clock': '4.2 GHz', 'L3 Cache': '64MB'},
        logs: ['Init sequence complete', 'Instruction set AVX-512 enabled'],
      ),
      HardwareComponent(
        id: 'GPU-001',
        name: 'Graphics Accelerator Alpha',
        type: 'GPU',
        status: 'Idle',
        load: 0.02,
        temperature: 38.0,
        detailedStats: {'VRAM': '24GB', 'Bus': 'PCIe 4.0 x16', 'Driver': '531.14'},
        logs: ['Display output active', 'CUDA cores ready'],
      ),
      HardwareComponent(
        id: 'MEM-001',
        name: 'System Memory Array',
        type: 'RAM',
        status: 'OK',
        load: 0.45,
        temperature: 40.0,
        detailedStats: {'Total': '64GB', 'Type': 'DDR5', 'Speed': '6000 MT/s', 'ECC': 'Enabled'},
        logs: ['Memory integrity check passed'],
      ),
      HardwareComponent(
        id: 'IO-USB-HUB',
        name: 'Universal Serial Bus Controller',
        type: 'I/O',
        status: 'Active',
        load: 0.10,
        temperature: 35.0,
        detailedStats: {'Ports': 12, 'Bandwidth': '20Gbps', 'Devices': 4},
        logs: ['Device connected: HID Keyboard', 'Device connected: Precision Mouse'],
      ),
      HardwareComponent(
        id: 'NET-ETH',
        name: 'Gigabit Ethernet Controller',
        type: 'NETWORK',
        status: 'Traffic',
        load: 0.60,
        temperature: 42.0,
        detailedStats: {'MAC': '00:1A:2B:3C:4D:5E', 'Duplex': 'Full', 'Speed': '10Gbps'},
        logs: ['Packet stream established', 'Firewall rules applied'],
      ),
    ];
    _addSystemLog("System Kernel Initialized. Access Level: ROOT/ADMIN.");
    notifyListeners();
  }

  void _startMonitoring() {
    // Simulate real-time hardware fluctuations
    _simulationTimer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      final random = Random();
      
      _components = _components.map((comp) {
        double newLoad = (comp.load + (random.nextDouble() * 0.1 - 0.05)).clamp(0.0, 1.0);
        double newTemp = (comp.temperature + (random.nextDouble() * 2 - 1)).clamp(20.0, 95.0);
        
        // Simulate random events/errors
        String status = comp.status;
        if (random.nextDouble() > 0.98) {
          status = "Scanning...";
          _addSystemLog("Hardware Scan initiated on ${comp.id}");
        } else if (random.nextDouble() > 0.99) {
           status = "Warning";
           _addSystemLog("WARNING: Voltage fluctuation detected on ${comp.name}");
        } else {
          status = "Online";
        }

        return HardwareComponent(
          id: comp.id,
          name: comp.name,
          type: comp.type,
          status: status,
          load: newLoad,
          temperature: newTemp,
          detailedStats: comp.detailedStats,
          logs: comp.logs,
        );
      }).toList();

      notifyListeners();
    });
  }

  void _addSystemLog(String message) {
    final timestamp = DateTime.now().toIso8601String().split('T')[1].substring(0, 8);
    _systemLogs.insert(0, "[$timestamp] $message");
    if (_systemLogs.length > 100) _systemLogs.removeLast();
    notifyListeners();
  }

  void executeCommand(String componentId, String command) {
    _addSystemLog("EXECUTING COMMAND: '$command' on target $componentId...");
    // Logic to send command to hardware would go here
    Future.delayed(const Duration(seconds: 1), () {
      _addSystemLog("Command '$command' executed successfully. Return Code: 0");
    });
  }

  @override
  void dispose() {
    _simulationTimer?.cancel();
    super.dispose();
  }
}
