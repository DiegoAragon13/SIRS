import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        // Logo ITD
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: theme.primaryColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              'ITD',
              style: TextStyle(
                color: isDark ? theme.colorScheme.tertiary : Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: theme.textTheme.headlineSmall?.fontFamily,
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Título
        Text(
          'Plataforma Educativa',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontSize: 28,
          ),
        ),

        const SizedBox(height: 8),

        // Subtítulo
        Text(
          'Sistema Unificado de Gestión Académica',
          style: TextStyle(
            fontSize: 16,
            color: isDark
                ? const Color(0xFFBBB8B4)
                : const Color(0xFF8C6F47),
            fontFamily: theme.textTheme.bodyLarge?.fontFamily,
          ),
        ),
      ],
    );
  }
}