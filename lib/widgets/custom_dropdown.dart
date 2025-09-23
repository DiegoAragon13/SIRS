import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const CustomDropdown({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F8FF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.school,
            color: Color(0xFF888888),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFF888888),
                ),
                style: const TextStyle(
                  color: Color(0xFF4A4A4A),
                  fontSize: 16,
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Alumno',
                    child: Text('Alumno'),
                  ),
                  DropdownMenuItem(
                    value: 'Profesor',
                    child: Text('Profesor'),
                  ),
                  DropdownMenuItem(
                    value: 'Administrador',
                    child: Text('Administrador'),
                  ),
                ],
                onChanged: (value) => onChanged(value!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}