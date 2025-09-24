import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/custom_logo.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_dropdown.dart';
import 'new_admin_dashboard.dart';
import 'package:sirs/Pages/screens/PortalEmpresaScreen.dart';
import 'package:sirs/widgets/custom_buttom.dart';

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
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    // Validar campos
    if (_emailController.text.trim().isEmpty || _passwordController.text.trim().isEmpty) {
      _showErrorMessage('Por favor completa todos los campos');
      return;
    }

    // Validar que no sea Alumno (aún no implementado)
    if (_selectedUserType == 'Alumno') {
      _showErrorMessage('El acceso para Alumnos aún no está disponible');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Autenticar con Firebase
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        // Autenticación exitosa, navegar según el tipo de usuario
        if (_selectedUserType == 'ITD') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const NewAdminDashboard(),
            ),
          );
        } else if (_selectedUserType == 'Empresa') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const PortalEmpresaScreen(),
            ),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No se encontró una cuenta con este correo electrónico';
          break;
        case 'wrong-password':
          errorMessage = 'Contraseña incorrecta';
          break;
        case 'invalid-email':
          errorMessage = 'El formato del correo electrónico no es válido';
          break;
        case 'user-disabled':
          errorMessage = 'Esta cuenta ha sido deshabilitada';
          break;
        case 'too-many-requests':
          errorMessage = 'Demasiados intentos fallidos. Intenta más tarde';
          break;
        case 'invalid-credential':
          errorMessage = 'Las credenciales proporcionadas no son válidas';
          break;
        default:
          errorMessage = 'Error de autenticación: ${e.message}';
      }
      _showErrorMessage(errorMessage);
    } catch (e) {
      _showErrorMessage('Error inesperado. Intenta nuevamente');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
      ),
    );
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
                        text: _isLoading ? 'Iniciando Sesión...' : 'Iniciar Sesión',
                        onPressed: _isLoading ? null : _handleLogin,
                      ),

                      const SizedBox(height: 24),

                      // Credenciales de demostración
                      // const DemoCredentials(),
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