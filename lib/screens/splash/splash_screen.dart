import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../backend/auth_provider.dart';
import '../login/login_screen_phone.dart';
import '../home/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // Show splash screen for 2.5 seconds
    await Future.delayed(const Duration(milliseconds: 2500));

    if (!mounted) return;

    // Check authentication status
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final token = await authProvider.getToken();

    if (!mounted) return;

    // Navigate based on auth status
    if (token != null && token.isNotEmpty) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LoginScreenPhone()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Screenshot (259) 1.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
