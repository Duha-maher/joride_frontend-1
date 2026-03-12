import 'package:flutter/material.dart';

class VehicleInformationScreen extends StatefulWidget {
  const VehicleInformationScreen({super.key});

  @override
  State<VehicleInformationScreen> createState() => _VehicleInformationScreenState();
}

class _VehicleInformationScreenState extends State<VehicleInformationScreen> {
  bool _submitted = false;
  int _selectedYear = 2025;
  final TextEditingController _vehicleTypeController = TextEditingController();
  final TextEditingController _vehicleModelController = TextEditingController();

  static const Color primaryYellow = Color(0xFFFFC107);
  static const Color darkText = Color(0xFF1A1A1A);
  static const Color hintText = Color(0xFFBBBBBB);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color errorColor = Color(0xFFE53935);

  final List<int> _years = List.generate(30, (i) => 2025 - i);

  @override
  void dispose() {
    _vehicleTypeController.dispose();
    _vehicleModelController.dispose();
    super.dispose();
  }

  bool _isEmpty(TextEditingController c) => c.text.trim().isEmpty;

  void _onContinue() {
    setState(() => _submitted = true);
    final bool valid = !_isEmpty(_vehicleTypeController) &&
        !_isEmpty(_vehicleModelController);
    if (valid) {
  
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3EC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           
              const Center(
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: darkText,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              const Center(
                child: Text(
                  'Vehicle Information',
                  style: TextStyle(
                    fontSize: 13,
                    color: primaryYellow,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              _buildLabel('Vehicle Type'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _vehicleTypeController,
                hint: '',
                hasError: _submitted && _isEmpty(_vehicleTypeController),
              ),
              const SizedBox(height: 24),

         
              _buildLabel('vehicle model'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _vehicleModelController,
                hint: 'e.g., Toyota Camry 2022',
                hasError: _submitted && _isEmpty(_vehicleModelController),
              ),
              const SizedBox(height: 24),

       
              _buildLabel('vehicle year'),
              const SizedBox(height: 8),
              _buildYearDropdown(),

              const SizedBox(height: 40),

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
                  onPressed: _onContinue,
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
    bool hasError = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: hasError ? Border.all(color: errorColor, width: 1.5) : null,
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
        onChanged: (_) => setState(() {}),
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

  Widget _buildYearDropdown() {
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: _selectedYear,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: darkText),
          items: _years.map((year) {
            return DropdownMenuItem<int>(
              value: year,
              child: Text(
                year.toString(),
                style: const TextStyle(fontSize: 15, color: darkText),
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) setState(() => _selectedYear = value);
          },
        ),
      ),
    );
  }
}