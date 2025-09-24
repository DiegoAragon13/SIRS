import 'package:flutter/material.dart';
import '../widgets/custom_buttom.dart';
import '../widgets/custom_logo.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/demo_credentials.dart';
import 'new_admin_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedUserType = 'Alumno';
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    // Verificar si es administrador
    if (_selectedUserType == 'Administrador') {
      // Navegar al dashboard de administrador
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const NewAdminDashboard(),
        ),
      );
    } else {
      // Para otros tipos de usuario, mostrar mensaje temporal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Iniciando sesión como $_selectedUserType...'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),

                // Logo y título
                const CustomLogo(),

                const SizedBox(height: 60),

                // Formulario de login
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF4A0D06) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: theme.shadowColor,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título del formulario
                      Text(
                        'Iniciar Sesión',
                        style: theme.textTheme.headlineSmall,
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Selecciona tu tipo de usuario e ingresa tus credenciales',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark
                              ? const Color(0xFFBBB8B4)
                              : const Color(0xFF8C6F47),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Tipo de Usuario
                      Text(
                        'Tipo de Usuario',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 12),

                      CustomDropdown(
                        value: _selectedUserType,
                        onChanged: (value) {
                          setState(() {
                            _selectedUserType = value;
                          });
                        },
                      ),

                      const SizedBox(height: 24),

                      // Correo Electrónico
                      Text(
                        'Correo Electrónico',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 12),

                      CustomTextField(
                        controller: _emailController,
                        hintText: 'tu@email.com',
                        keyboardType: TextInputType.emailAddress,
                      ),

                      const SizedBox(height: 24),

                      // Contraseña
                      Text(
                        'Contraseña',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 12),

                      CustomTextField(
                        controller: _passwordController,
                        hintText: '••••••••',
                        isPassword: true,
                        isPasswordVisible: _isPasswordVisible,
                        onTogglePassword: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),

                      const SizedBox(height: 32),

                      // Botón de login
                      CustomButton(
                        text: 'Iniciar Sesión',
                        onPressed: _handleLogin,
                      ),

                      const SizedBox(height: 24),

                      // Credenciales de demostración
                      const DemoCredentials(),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Enlace de contacto
                Text(
                  '¿Problemas para acceder? Contacta al administrador',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark
                        ? const Color(0xFFBBB8B4)
                        : const Color(0xFF8C6F47),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
