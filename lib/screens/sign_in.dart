import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore
import 'package:joride_app/screens/login_screen.dart';
import 'sign_in.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool isPassenger = true;
  String selectedGender = 'Female';

  // Controllers
  ///////////test
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static const Color primaryYellow = Color(0xFFFFC107);
  static const Color lightYellow = Color(0xFFFFF9E0);
  static const Color darkText = Color(0xFF1A1A1A);
  static const Color hintText = Color(0xFFBBBBBB);
  static const Color cardBg = Color(0xFFFFFFFF);

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // إنشاء الحساب + حفظ البيانات في Firestore
  void _createAccount() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final birthday =
        '${_dayController.text.trim()}/${_monthController.text.trim()}/${_yearController.text.trim()}';
    final role = isPassenger ? 'rider' : 'driver';
    final gender = selectedGender;

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // حفظ البيانات في Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set({
            'firstName': firstName,
            'lastName': lastName,
            'email': email,
            'birthday': birthday,
            'role': role,
            'gender': gender,
            'createdAt': Timestamp.now(),
          });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created successfully!")),
      );

      // الانتقال لصفحة تسجيل الدخول
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String message = 'Something went wrong';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 32),
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: darkText,
                    ),
                  ),
                  Icon(Icons.language, color: primaryYellow, size: 26),
                ],
              ),
              const SizedBox(height: 24),

              _buildToggle(),

              const SizedBox(height: 28),
              _buildLabel('First name'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _firstNameController,
                hint: 'Enter your first name',
              ),

              const SizedBox(height: 20),
              _buildLabel('Last name'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _lastNameController,
                hint: 'Enter your last name',
              ),

              const SizedBox(height: 20),
              _buildLabel('Email'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _emailController,
                hint: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20),
              _buildLabel('Password'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _passwordController,
                hint: 'Enter your password',
                keyboardType: TextInputType.visiblePassword,
              ),

              const SizedBox(height: 20),
              _buildLabel('Select gender'),
              const SizedBox(height: 12),
              _buildGenderOption('Female'),
              const SizedBox(height: 8),
              _buildGenderOption('Male'),

              const SizedBox(height: 20),
              _buildLabel('Birthday'),
              const SizedBox(height: 8),
              _buildBirthdayField(),

              const SizedBox(height: 36),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryYellow,
                    foregroundColor: darkText,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  onPressed: _createAccount,
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggle() {
    return Container(); // جسم صالح مؤقت
  }

  Widget _buildLabel(String text) {
    return Text(text); // مؤقت
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(controller: controller); // مؤقت
  }

  Widget _buildGenderOption(String gender) {
    return Container(); // مؤقت
  }

  Widget _buildBirthdayField() {
    return Container(); // مؤقت
  }

  Widget _buildDatePart({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(controller: controller); // مؤقت
  }
}
