import 'package:flutter/material.dart';
import 'driver_sigin.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool isPassenger = true;
  String selectedGender = 'Female';
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

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
    super.dispose();
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
              _buildLabel('select gender'),
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
                  onPressed: () {},
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
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
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
             onTap: () {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const CreateDriverAccountScreen()),
  );
},
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                height: 42,
                decoration: BoxDecoration(
                  color: !isPassenger ? primaryYellow : Colors.transparent,
                  borderRadius: BorderRadius.circular(26),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Driver',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: !isPassenger ? darkText : Colors.grey,
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isPassenger = true),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                height: 42,
                decoration: BoxDecoration(
                  color: isPassenger ? primaryYellow : Colors.transparent,
                  borderRadius: BorderRadius.circular(26),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Passenger',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: isPassenger ? darkText : Colors.grey,
                      ),
                    ),
                    if (isPassenger) ...[
                      const SizedBox(width: 6),
                      const Icon(Icons.check_circle,
                          color: darkText, size: 18),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: darkText,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: hintText, fontSize: 14),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildGenderOption(String gender) {
    final bool isSelected = selectedGender == gender;
    return GestureDetector(
      onTap: () => setState(() => selectedGender = gender),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? lightYellow : cardBg,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? primaryYellow : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 11,
                        height: 11,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryYellow,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              gender,
              style: TextStyle(
                fontSize: 15,
                fontWeight:
                    isSelected ? FontWeight.w600 : FontWeight.w400,
                color: darkText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBirthdayField() {
    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: _buildDatePart(
              controller: _dayController,
              hint: 'DD',
            ),
          ),
          const Text(' / ', style: TextStyle(color: hintText, fontSize: 16)),
          Expanded(
            child: _buildDatePart(
              controller: _monthController,
              hint: 'MM',
            ),
          ),
          const Text(' / ', style: TextStyle(color: hintText, fontSize: 16)),
          Expanded(
            flex: 2,
            child: _buildDatePart(
              controller: _yearController,
              hint: 'YYYY',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePart({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: hintText, fontSize: 14),
        border: InputBorder.none,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
      ),
    );
  }
}