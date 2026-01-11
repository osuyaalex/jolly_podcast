import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';
import '../../utility/sizes.dart';
import '../../utility/iacolors.dart';
import '../../utility/uiutils.dart';
import '../../backend/auth_provider.dart';
import '../home/home_page.dart';

class LoginScreenPassword extends StatefulWidget {
  final String phoneNumber;

  const LoginScreenPassword({super.key, required this.phoneNumber});

  @override
  State<LoginScreenPassword> createState() => _LoginScreenPasswordState();
}

class _LoginScreenPasswordState extends State<LoginScreenPassword> {
  final TextEditingController _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() async {
    _videoController = VideoPlayerController.asset(
      'assets/videos/mandancing.mp4',
    );

    await _videoController.initialize();
    await _videoController.setLooping(true);
    await _videoController.play();

    setState(() {
      _isVideoInitialized = true;
    });
  }



  @override
  void dispose() {
    _videoController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          // Video Background
          if (_isVideoInitialized)
            Positioned.fill(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _videoController.value.size.width,
                  height: _videoController.value.size.height,
                  child: VideoPlayer(_videoController),
                ),
              ),
            )
          else
            Positioned.fill(
              child: Container(
                color: Colors.black,
              ),
            ),
          // Dark Overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.5),
            ),
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.pW),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   Expanded(child: Container()),
                    // Jolly Logo
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/Screenshot__265__1-removebg-preview 1.png',
                          height: 12.pH,
                        ),
                      ],
                    ),
                    3.gap,
                    // Tagline
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 90.pW,
                          child: Text(
                            'Enter the 6 digit code sent to your phone number ${widget.phoneNumber}',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              //letterSpacing: 0.5,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    2.gap,
                    // Code Input Field
                    TextFormField(
                      controller: _codeController,
                      style: theme.textTheme.bodySmall,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Enter password',
                        hintStyle: TextStyle(
                          fontSize: 3.8.pW,
                          color: Colors.grey.shade500,
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal,
                        ),
                        counterText: '',
                        filled: true,
                        fillColor: Colors.white,
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
                          return 'Please enter the code';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 2.5.pH),
                    // Continue Button
                    SizedBox(
                      width: double.infinity,
                      height: 8.pH,
                      child: ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  final authProvider = Provider.of<AuthProvider>(
                                    context,
                                    listen: false,
                                  );

                                  try {
                                    await authProvider.login(
                                      widget.phoneNumber,
                                      _codeController.text,
                                    );

                                    // Navigate to home page on success
                                    if (mounted) {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: (_) => HomePage()),
                                      );
                                    }
                                  } catch (error) {
                                    // Show error dialog
                                    if (mounted) {
                                      UiUtils.showAlertDialog(
                                        context: context,
                                        title: 'Error',
                                        content: error.toString(),
                                        defaultActionText: 'close', onDismissed: (bool p1) {  },
                                      );
                                    }
                                  } finally {
                                    if (mounted) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                  }
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
                        child: _isLoading
                            ? SizedBox(
                                height: 4.pH,
                                width: 4.pH,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                'Continue',
                                style: TextStyle(
                                  fontSize: 4.2.pW,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                    1.gap,
                    // Resend Code Text

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
