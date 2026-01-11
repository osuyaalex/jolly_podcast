import 'package:flutter/material.dart';
import '../../utility/sizes.dart';
import '../../utility/iacolors.dart';
import 'login_screen_password.dart';

class LoginScreenPhone extends StatefulWidget {
  const LoginScreenPhone({super.key});

  @override
  State<LoginScreenPhone> createState() => _LoginScreenPhoneState();
}

class _LoginScreenPhoneState extends State<LoginScreenPhone> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/man_and_woman.png',
              fit: BoxFit.cover,
            ),
          ),
          // Dark Overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.45),
            ),
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.pW),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 Expanded(child: Container()),
                  // Jolly Logo
                  Image.asset(
                    'assets/images/Screenshot__265__1-removebg-preview 1.png',
                    height: 12.pH,
                  ),
                  SizedBox(height: 1.pH),
                  // Tagline
                  Text(
                    'PODCASTS FOR AFRICA BY AFRICANS',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  2.gap,
                  // Phone Input Field
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    style: Theme.of(context).textTheme.bodySmall,
                    decoration: InputDecoration(
                      hintText: 'Enter Phone Number',
                      hintStyle: const TextStyle(fontSize: 14),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(3.pW),
                        child: Image.asset(
                          'assets/images/image 30.png',
                          width: 6.pW,
                          height: 6.pW,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: IAColors.secondary, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: IAColors.secondary, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: IAColors.secondary, width: 2.5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.red, width: 2),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.red, width: 2.5),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  2.gap,
                  // Continue Button
                  SizedBox(
                    width: double.infinity,
                    height: 8.pH,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_phoneController.text.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreenPassword(
                                phoneNumber: _phoneController.text,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please enter your phone number'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: IAColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 4.2.pW,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  1.gap,
                  RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13
                        ),
                        text: 'By proceeding, you agree and accept our ',
                        children: [
                          TextSpan(
                            text: 'T&C',
                            style: TextStyle(
                              decoration: TextDecoration.underline
                            )
                          )
                        ]
                      )
                  ),
                  5.gap,
                  // Sign Up Text
                  Padding(
                    padding: EdgeInsets.only(bottom: 3.pH),
                    child: Text(
                      "BECOME A PODCAST CREATOR",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
