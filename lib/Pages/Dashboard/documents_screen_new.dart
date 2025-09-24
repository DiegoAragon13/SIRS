import 'package:flutter/material.dart';

class DocumentsScreenNew extends StatefulWidget {
  const DocumentsScreenNew({Key? key}) : super(key: key);

  @override
  State<DocumentsScreenNew> createState() => _DocumentsScreenNewState();
}

class _DocumentsScreenNewState extends State<DocumentsScreenNew> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _documents = [
    {
      'student': 'Juan Pérez',
      'document': 'Reporte Mensual #3',
      'type': 'Servicio Social',
      'date': '2024-03-15',
      'urgent': true,
    },
    {
      'student': 'María González',
      'document': 'Carta de Liberación',
      'type': 'Servicio Social',
      'date': '2024-03-14',
      'urgent': false,
    },
    {
      'student': 'Carlos Ruiz',
      'document': 'Propuesta de Proyecto',
      'type': 'Residencias',
      'date': '2024-03-13',
      'urgent': false,
    },
    {
      'student': 'Ana López',
      'document': 'Reporte Final',
      'type': 'Residencias',
      'date': '2024-03-12',
      'urgent': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1024;
    
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header Section
          isDesktop 
              ? _buildDesktopHeader() 
              : _buildMobileHeader(),
          
          SizedBox(height: isDesktop ? 24 : 16),

          // Main Card
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE5E7EB)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card Header
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: isDesktop 
                      ? _buildDesktopCardHeader()
                      : _buildMobileCardHeader(),
                ),
                
                // Documents List
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
                  child: Column(
                    children: _documents.asMap().entries.map((entry) {
                      final index = entry.key;
                      final doc = entry.value;
                      return Column(
                        children: [
                          if (index > 0) const SizedBox(height: 12),
                          _buildDocumentItem(doc, isDesktop),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          
          // Add bottom padding for mobile bottom navigation
          SizedBox(height: MediaQuery.of(context).size.width < 1024 ? 80 : 0),
        ],
      ),
    );
  }

  Widget _buildDesktopHeader() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Gestión de Documentos',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827),
            ),
          ),
        ),
        Row(
          children: [
            _buildButton(
              icon: Icons.filter_list,
              label: 'Filtrar',
              isOutlined: true,
              onTap: () {},
            ),
            const SizedBox(width: 8),
            _buildButton(
              icon: Icons.download,
              label: 'Exportar',
              isOutlined: false,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gestión de Documentos',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildButton(
                icon: Icons.filter_list,
                label: 'Filtrar',
                isOutlined: true,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildButton(
                icon: Icons.download,
                label: 'Exportar',
                isOutlined: false,
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopCardHeader() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Documentos Pendientes de Revisión',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
            ),
          ),
        ),
        SizedBox(
          width: 256,
          child: _buildSearchField(),
        ),
      ],
    );
  }

  Widget _buildMobileCardHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Documentos Pendientes de Revisión',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 16),
        _buildSearchField(),
      ],
    );
  }

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD1D5DB)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: 'Buscar estudiante...',
          hintStyle: TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xFF6B7280),
            size: 16,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        ),
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String label,
    required bool isOutlined,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: isOutlined ? Colors.transparent : const Color(0xFF660B05),
          border: Border.all(
            color: isOutlined ? const Color(0xFFD1D5DB) : const Color(0xFF660B05),
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isOutlined ? const Color(0xFF374151) : Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isOutlined ? const Color(0xFF374151) : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentItem(Map<String, dynamic> doc, bool isDesktop) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: isDesktop 
          ? _buildDesktopDocumentLayout(doc)
          : _buildMobileDocumentLayout(doc),
    );
  }

  Widget _buildDesktopDocumentLayout(Map<String, dynamic> doc) {
    return Row(
      children: [
        // Avatar and Info
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFF3F4F6),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  doc['student'].split(' ').map((n) => n[0]).join(''),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF374151),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doc['student'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF111827),
                  ),
                ),
                Text(
                  doc['document'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ],
        ),
        
        const SizedBox(width: 16),
        
        // Badges
        Row(
          children: [
            _buildBadge(doc['type'], isOutlined: true),
            if (doc['urgent'] == true) ...[
              const SizedBox(width: 8),
              _buildBadge('Urgente', isUrgent: true),
            ],
          ],
        ),
        
        const Spacer(),
        
        // Date and Actions
        Row(
          children: [
            Text(
              doc['date'],
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(width: 16),
            _buildActionButton(
              icon: Icons.visibility,
              label: 'Revisar',
              isOutlined: true,
              onTap: () {},
            ),
            const SizedBox(width: 8),
            _buildActionButton(
              icon: Icons.check_circle,
              label: 'Aprobar',
              isOutlined: false,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileDocumentLayout(Map<String, dynamic> doc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Student Info Row
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFF3F4F6),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  doc['student'].split(' ').map((n) => n[0]).join(''),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF374151),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doc['student'],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    doc['document'],
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6B7280),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 12),
        
        // Badges and Date Row
        Row(
          children: [
            _buildBadge(doc['type'], isOutlined: true),
            if (doc['urgent'] == true) ...[
              const SizedBox(width: 6),
              _buildBadge('Urgente', isUrgent: true),
            ],
            const Spacer(),
            Text(
              doc['date'],
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 12),
        
        // Actions Row
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                icon: Icons.visibility,
                label: 'Revisar',
                isOutlined: true,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildActionButton(
                icon: Icons.check_circle,
                label: 'Aprobar',
                isOutlined: false,
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBadge(String text, {bool isOutlined = false, bool isUrgent = false}) {
    Color backgroundColor;
    Color textColor;
    Color borderColor;

    if (isUrgent) {
      backgroundColor = const Color(0xFFDC2626);
      textColor = Colors.white;
      borderColor = const Color(0xFFDC2626);
    } else if (isOutlined) {
      backgroundColor = Colors.transparent;
      textColor = const Color(0xFF6B7280);
      borderColor = const Color(0xFFD1D5DB);
    } else {
      backgroundColor = const Color(0xFF660B05);
      textColor = Colors.white;
      borderColor = const Color(0xFF660B05);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required bool isOutlined,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isOutlined ? Colors.transparent : const Color(0xFF660B05),
          border: Border.all(
            color: isOutlined ? const Color(0xFFD1D5DB) : const Color(0xFF660B05),
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isOutlined ? const Color(0xFF374151) : Colors.white,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isOutlined ? const Color(0xFF374151) : Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}