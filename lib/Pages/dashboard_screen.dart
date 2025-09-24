import 'package:flutter/material.dart';
import 'package:sirs/widgets/progress_widget.dart';
import 'package:sirs/widgets/recent_activity_widget.dart';
import 'package:sirs/widgets/upcoming_tasks_widget.dart';
import 'package:sirs/widgets/notification_item.dart';

import '../widgets/notifications_widget.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key); // quitar const

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF6E8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Bienvenido',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D2D2D),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Resumen de tu progreso',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF666666),
                ),
              ),
              SizedBox(height: 30),

              // Widgets
              ProgressWidget(), // quitar const
              SizedBox(height: 24),

              RecentActivityWidget(),
              SizedBox(height: 24),

              UpcomingTasksWidget(),
              SizedBox(height: 24),

              NotificationsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
