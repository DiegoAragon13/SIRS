import 'package:flutter/material.dart';

import '../../widgets/CustomBottomNavigation.dart';
import '../../widgets/CustomHeader.dart';
import '../../widgets/FeaturedStudentsCard.dart';
import '../../widgets/QuickActionsCard.dart';
import '../../widgets/StatsGrid.dart';
import '../../widgets/WelcomeSection.dart';

class PortalEmpresaScreen extends StatelessWidget {
  const PortalEmpresaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          // Header personalizado
          const CustomHeader(userAvatar: '',),
          // Contenido principal con scroll
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const WelcomeSection(),
                  const SizedBox(height: 20),
                  const StatsGrid(),
                  const SizedBox(height: 20),
                  const QuickActionsCard(),
                  const SizedBox(height: 20),
                  const FeaturedStudentsCard(),
                  const SizedBox(height: 80), // Espacio para el bottom navigation
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}