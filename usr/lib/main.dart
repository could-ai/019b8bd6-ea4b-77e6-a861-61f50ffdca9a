import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'screens/dashboard_screen.dart';
import 'services/hardware_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HardwareService()),
      ],
      child: const HardwareControlApp(),
    ),
  );
}

class HardwareControlApp extends StatelessWidget {
  const HardwareControlApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Titanium Hardware Commander',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0E14),
        primaryColor: const Color(0xFF00FFC2),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00FFC2),
          secondary: Color(0xFF00B8D4),
          surface: Color(0xFF161B22),
          error: Color(0xFFFF3D00),
          onPrimary: Colors.black,
        ),
        textTheme: GoogleFonts.jetbrainsMonoTextTheme(
          ThemeData.dark().textTheme,
        ),
        cardTheme: CardTheme(
          color: const Color(0xFF161B22),
          elevation: 4,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboardScreen(),
      },
    );
  }
}
