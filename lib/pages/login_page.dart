import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuis1/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controller: objek utk ambil/atur teks di dalam TextField
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Fungsi Login
  void _login() {
    // Validasi kosong
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      _showError("Username dan Password tidak boleh kosong!");
      return;
    }

    // validasi data
    if (_usernameController.text == "232" && _passwordController.text == "IF") {
      // Pindah ke home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(username: _usernameController.text),
        ), // bawa usn dari user
      );
    } else {
      _showError("Login failed! Check your data");
    }
  }

  // fungsi error message
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color.fromARGB(255, 209, 139, 220);

    return Scaffold(
      // SafeArea: Menjaga konten agar tidak tertutup notch atau status bar HP
      body: SafeArea(
        child: Stack(
          //
          children: [
            _buildLogo(primaryColor),
            _buildHeader(),
            _buildLoginForm(),
          ],
        ),
      ),
    );
  }

  // Logo
  Widget _buildLogo(Color color) {
    return Positioned(
      // atur posisi elemen secara absolut di dlm stack
      top: 20, // 20 dri atas
      left: 20, // 20 dari kiri
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.pets_rounded,
          size: 40,
          color: Color(0xFF8838AB),
        ),
      ),
    );
  }

  // Header Welcome
  Widget _buildHeader() {
    return Positioned(
      top: 130,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          "Welcome to Pet House",
          textAlign: TextAlign.center,
          style: GoogleFonts.oswald(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF551E67),
          ),
        ),
      ),
    );
  }

  // Login Form
  Widget _buildLoginForm() {
    return Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        // biar bisa di scroll waktu keyboard muncul
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 0), // coba ganti" aja
            // Username
            CustomInputField(
              hint: "Enter Username",
              controller: _usernameController,
            ),

            const SizedBox(height: 15),

            // Password
            CustomInputField(
              hint: "Enter Password",
              controller: _passwordController,
              isPassword: true, // Akan ditangani di CustomInputField
            ),

            const SizedBox(height: 30),

            // Button login
            ElevatedButton(
              onPressed: _login, // panggil method login
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 209, 139, 220),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Login", style: TextStyle(fontSize: 18)),
            ),

            // Daftar Acc
            // const SizedBox(height: 20),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     const Text("Don't have an account? "),
            //     GestureDetector(
            //       onTap: () {
            //         // navigate ke halaman daftar
            //       },
            //       child: const Text(
            //         "Sign Up Here",
            //         style: TextStyle(
            //           color: Colors.purple,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

// Input Field
class CustomInputField extends StatefulWidget {
  // Atribut class
  final String hint; //placeholder
  final TextEditingController controller; // biar tahu apa yg diketik user
  final bool isPassword;

  // Constructor
  const CustomInputField({
    super.key,
    required this.hint,
    required this.controller,
    this.isPassword = false,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _obscureText : false,
        decoration: InputDecoration(
          hintText: widget.hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          // Fitur visibility on/off
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () => setState(() => _obscureText = !_obscureText),
                )
              : null,
        ),
      ),
    );
  }
}
