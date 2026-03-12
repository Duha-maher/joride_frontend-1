import 'package:flutter/material.dart';
import 'sign_in.dart';
import 'vehicle_info.dart';

class CreateDriverAccountScreen extends StatefulWidget {
  const CreateDriverAccountScreen({super.key});

  @override
  State<CreateDriverAccountScreen> createState() => _CreateDriverAccountScreenState();
}

class _CreateDriverAccountScreenState extends State<CreateDriverAccountScreen> {
  bool _submitted = false;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _licenseController = TextEditingController();
  final TextEditingController _plateController = TextEditingController();
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  static const Color primaryYellow = Color(0xFFFFC107);
  static const Color darkText = Color(0xFF1A1A1A);
  static const Color hintText = Color(0xFFBBBBBB);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color errorColor = Color(0xFFE53935);

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _licenseController.dispose();
    _plateController.dispose();
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  bool _isEmpty(TextEditingController c) => c.text.trim().isEmpty;
  bool get _dateEmpty =>
      _isEmpty(_dayController) || _isEmpty(_monthController) || _isEmpty(_yearController);

  void _onContinue() {
    setState(() => _submitted = true);
    final bool valid = !_isEmpty(_firstNameController) &&
        !_isEmpty(_lastNameController) &&
        !_isEmpty(_licenseController) &&
        !_isEmpty(_plateController) &&
        !_dateEmpty;
    if (valid) {
   if (valid) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const VehicleInformationScreen()),
  );
}
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 32),
                  const Text('Create Account',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: darkText)),
                  Icon(Icons.language, color: primaryYellow, size: 26),
                ],
              ),
              const SizedBox(height: 24),
              _buildToggle(context),
              const SizedBox(height: 28),
              _buildLabel('First name'),
              const SizedBox(height: 8),
              _buildTextField(controller: _firstNameController, hint: 'Enter your first name',
                  hasError: _submitted && _isEmpty(_firstNameController)),
              const SizedBox(height: 20),
              _buildLabel('Last name'),
              const SizedBox(height: 8),
              _buildTextField(controller: _lastNameController, hint: 'Enter your last name',
                  hasError: _submitted && _isEmpty(_lastNameController)),
              const SizedBox(height: 20),
              _buildLabel('Driver\'s License Number'),
              const SizedBox(height: 8),
              _buildTextField(controller: _licenseController, hint: '',
                  hasError: _submitted && _isEmpty(_licenseController)),
              const SizedBox(height: 20),
              _buildLabel('License Expiry Date:'),
              const SizedBox(height: 8),
              _buildBirthdayField(),
              const SizedBox(height: 20),
              _buildLabel('License Plate Number'),
              const SizedBox(height: 8),
              _buildTextField(controller: _plateController, hint: 'ABC-1234',
                  hasError: _submitted && _isEmpty(_plateController)),
              const SizedBox(height: 36),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryYellow,
                    foregroundColor: darkText,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 0,
                  ),
                  onPressed: _onContinue,
                  child: const Text('Continue',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggle(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(30)),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 42,
              decoration: BoxDecoration(color: primaryYellow, borderRadius: BorderRadius.circular(26)),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Driver', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: darkText)),
                  SizedBox(width: 6),
                  Icon(Icons.check_circle, color: darkText, size: 18),
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const CreateAccountScreen())),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 42,
                decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(26)),
                alignment: Alignment.center,
                child: const Text('Passenger',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.grey)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) => Text(text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: darkText));

  Widget _buildTextField({required TextEditingController controller, required String hint, bool hasError = false}) {
    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: hasError ? Border.all(color: errorColor, width: 1.5) : null,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: TextField(
        controller: controller,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: hintText, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildBirthdayField() {
    final bool dateError = _submitted && _dateEmpty;
    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: dateError ? Border.all(color: errorColor, width: 1.5) : null,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Expanded(child: _buildDatePart(controller: _dayController, hint: 'DD')),
          const Text(' / ', style: TextStyle(color: hintText, fontSize: 16)),
          Expanded(child: _buildDatePart(controller: _monthController, hint: 'MM')),
          const Text(' / ', style: TextStyle(color: hintText, fontSize: 16)),
          Expanded(flex: 2, child: _buildDatePart(controller: _yearController, hint: 'YYYY')),
        ],
      ),
    );
  }

  Widget _buildDatePart({required TextEditingController controller, required String hint}) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: hintText, fontSize: 14),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
      ),
    );
  }
}