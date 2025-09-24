import 'package:flutter/material.dart';

class Buttombarpato extends StatefulWidget {
  final Function(int)? onTabSelected;
  final int initialIndex;

  const Buttombarpato({
    Key? key,
    this.onTabSelected,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<Buttombarpato> createState() => _ButtombarpatoState();
}

class _ButtombarpatoState extends State<Buttombarpato> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (widget.onTabSelected != null) {
      widget.onTabSelected!(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: BottomNavItem(
                icon: Icons.home_filled,
                label: 'Home',
                isSelected: _selectedIndex == 0,
                onTap: () => _onItemTapped(0),
              ),
            ),
            Expanded(
              child: BottomNavItem(
                icon: Icons.people,
                label: 'Servicio',
                isSelected: _selectedIndex == 1,
                onTap: () => _onItemTapped(1),
              ),
            ),
            Expanded(
              child: BottomNavItem(
                icon: Icons.holiday_village,
                label: 'Residencia',
                isSelected: _selectedIndex == 2,
                onTap: () => _onItemTapped(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const BottomNavItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected
                  ? const Color(0xFF8B4513)
                  : Colors.grey[600],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected
                    ? const Color(0xFF8B4513)
                    : Colors.grey[600],
                fontWeight: isSelected
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}