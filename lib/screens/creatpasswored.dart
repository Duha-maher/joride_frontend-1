import 'package:flutter/material.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _submitted = false;
  bool _passwordTouched = false;
  bool _confirmTouched = false;

  static const Color primaryYellow = Color(0xFFFFC107);
  static const Color darkText = Color(0xFF1A1A1A);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color errorColor = Color(0xFFE53935);
  static const Color successColor = Color(0xFF4CAF50);

  bool get _hasMinLength => _passwordController.text.length >= 10;
  bool get _hasUppercase => _passwordController.text.contains(RegExp(r'[A-Z]'));
  bool get _hasNumber => _passwordController.text.contains(RegExp(r'[0-9]'));
  bool get _passwordsMatch => _passwordController.text == _confirmController.text;
  bool get _passwordValid => _hasMinLength && _hasUppercase && _hasNumber;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _onContinue() {
    setState(() => _submitted = true);
    if (_passwordValid && _passwordsMatch) {
      // انتقل للشاشة التالية
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3EC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'create your  password',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: darkText,
                ),
              ),
              const SizedBox(height: 32),
              const Text('Password',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: darkText)),
              const SizedBox(height: 8),
              _buildPasswordField(
                controller: _passwordController,
                hint: 'Enter your password',
                obscure: _obscurePassword,
                onToggle: () => setState(() => _obscurePassword = !_obscurePassword),
                onChanged: (_) => setState(() => _passwordTouched = true),
                hasError: _submitted && !_passwordValid,
              ),
              const SizedBox(height: 16),
              _buildRequirements(),
              const SizedBox(height: 24),
              const Text('Confirm Password',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: darkText)),
              const SizedBox(height: 8),
              _buildPasswordField(
                controller: _confirmController,
                hint: 'Re-enter your password',
                obscure: _obscureConfirm,
                onToggle: () => setState(() => _obscureConfirm = !_obscureConfirm),
                onChanged: (_) => setState(() => _confirmTouched = true),
                hasError: _submitted && !_passwordsMatch,
              ),

              if (_submitted && !_passwordsMatch) ...[
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Icon(Icons.error_outline, color: errorColor, size: 16),
                    SizedBox(width: 6),
                    Text('Passwords do not match',
                        style: TextStyle(color: errorColor, fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
              ],

              const SizedBox(height: 40),

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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required bool obscure,
    required VoidCallback onToggle,
    required ValueChanged<String> onChanged,
    bool hasError = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: hasError ? Border.all(color: errorColor, width: 1.5) : null,
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFFBBBBBB), fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          suffixIcon: IconButton(
            icon: Icon(obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: Colors.grey, size: 20),
            onPressed: onToggle,
          ),
        ),
      ),
    );
  }

  Widget _buildRequirements() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Password Requirements',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF888888))),
          const SizedBox(height: 8),
          _buildRequirementRow('At least 10 characters', _hasMinLength),
          const SizedBox(height: 6),
          _buildRequirementRow('At least one uppercase letter', _hasUppercase),
          const SizedBox(height: 6),
          _buildRequirementRow('At least one number', _hasNumber),
        ],
      ),
    );
  }

  Widget _buildRequirementRow(String text, bool isMet) {
    final Color color = isMet ? successColor : (_passwordTouched ? errorColor : const Color(0xFF9E9E9E));
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withValues(alpha: 0.15),
          ),
          child: Icon(isMet ? Icons.check : Icons.close, size: 10, color: color),
        ),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: color)),
      ],
    );
  }
}