import 'package:flutter/material.dart';

class FeaturedStudentsCard extends StatelessWidget {
  const FeaturedStudentsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Estudiantes Destacados',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.headlineSmall?.color,
            ),
          ),
          SizedBox(height: 16),
          StudentCard(
            initials: 'AL',
            name: 'Ana...',
            career: 'Ing. Si...',
            specialty: 'Sistema de In...',
            rating: 5,
            initialsColor: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
          ),
          SizedBox(height: 12),
          StudentCard(
            initials: 'CR',
            name: 'Carl...',
            career: 'Ing. In...',
            specialty: 'Optimización...',
            rating: 4,
            initialsColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
          ),
          SizedBox(height: 12),
          StudentCard(
            initials: 'MG',
            name: 'María...',
            career: 'Ing. Si...',
            specialty: 'App Móvil',
            rating: 5,
            initialsColor: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}

class StudentCard extends StatelessWidget {
  final String initials;
  final String name;
  final String career;
  final String specialty;
  final int rating;
  final Color initialsColor;

  const StudentCard({
    Key? key,
    required this.initials,
    required this.name,
    required this.career,
    required this.specialty,
    required this.rating,
    required this.initialsColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Color(0xFFFAFAFA)
            : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.grey.shade200
              : Theme.of(context).colorScheme.outline.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Avatar con iniciales
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: initialsColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                initials,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          // Información del estudiante
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                Text(
                  career,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          // Rating y especialidad
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    size: 16,
                    color: index < rating
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.3),
                  );
                }),
              ),
              SizedBox(height: 2),
              Text(
                specialty,
                style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}