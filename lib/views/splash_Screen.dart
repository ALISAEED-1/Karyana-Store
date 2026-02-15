import 'package:backend_project/views/register_screen.dart';
import 'package:backend_project/views/rootpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashscreenDemo extends StatefulWidget {

  const SplashscreenDemo({super.key});

  @override
  State<SplashscreenDemo> createState() => _SplashscreenDemoState();
}

class _SplashscreenDemoState extends State<SplashscreenDemo> {
  @override
  void initState() {
    super.initState();

    // ⏳ Delay for 5 seconds, then navigate
    Future.delayed(const Duration(seconds: 15), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RegisterScreen()), // 👈 replace with your page
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50 ,
      body: Column(
        children: [

          const SizedBox(height: 70),
          Padding(
            padding: const EdgeInsets.only(left: 10,top: 300 ),
            child: Text(
              "Karyana",
              style: GoogleFonts.montserrat(
                color: Colors.red,
                fontSize: 36,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 50),

          // 🔄 Spinner (Throbber)
          const Center(
            child: CircularProgressIndicator(
              color: Colors.red, // change color if you like
              strokeWidth: 3, // thickness
            ),
          ),
        ],
      ),
    );
  }
}

// 👉 Replace this with your actual page
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("This is Home Page 🚀")),
    );
  }
}
