import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PipelineScreen extends StatefulWidget {
  const PipelineScreen({super.key});

  @override
  State<PipelineScreen> createState() => _PipelineScreenState();
}

class _PipelineScreenState extends State<PipelineScreen> {
  final Map<String, List<Map<String, dynamic>>> _columns = {
    'LEAD': [
      {'name': 'Bright Solutions', 'industry': 'Marketing', 'value': '\$12k', 'initials': 'BS', 'color': Color(0xFF1B2A4A)},
      {'name': 'Nova Retail', 'industry': 'E-commerce', 'value': '\$9k', 'initials': 'NR', 'color': Color(0xFF9B59B6)},
      {'name': 'Apex Media', 'industry': 'Advertising', 'value': '\$22k', 'initials': 'AM', 'color': Color(0xFFE74C3C)},
    ],
    'NEGOTIATION': [
      {'name': 'Vertex Ltd', 'industry': 'Technology', 'value': '\$45k', 'initials': 'VL', 'color': Color(0xFFF5A623)},
      {'name': 'Orien Co', 'industry': 'Finance', 'value': '\$19k', 'initials': 'OC', 'color': Color(0xFF2ECC71)},
    ],
    'DELIVERY': [
      {'name': 'Acme Corp', 'industry': 'Retail', 'value': '\$67k', 'initials': 'AC', 'color': Color(0xFF1B2A4A)},
      {'name': 'Zenith Inc', 'industry': 'Logistics', 'value': '\$31k', 'initials': 'ZI', 'color': Color(0xFF9B59B6)},
    ],
  };

  final Map<String, Color> _colColors = {
    'LEAD': Color(0xFF1B2A4A),
    'NEGOTIATION': Color(0xFFF5A623),
    'DELIVERY': Color(0xFF2ECC71),
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Client Pipeline',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1B2A4A),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _showAddClientDialog(context),
                  icon: const Icon(Icons.add, size: 16),
                  label: Text('Client', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF5A623),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Stage headers
            Row(
              children: _columns.keys.map((col) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      children: [
                        Text(
                          col,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: _colColors[col],
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: _colColors[col]!.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${_columns[col]!.length} clients',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: _colColors[col],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(height: 3, decoration: BoxDecoration(color: _colColors[col], borderRadius: BorderRadius.circular(2))),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _columns.keys.map((col) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ..._columns[col]!.map((client) => _ClientCard(
                                  client: client,
                                  stageColor: _colColors[col]!,
                                  onTap: () => _showClientDetail(context, client),
                                )),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () => _showAddClientDialog(context),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey[200]!),
                                ),
                                child: Center(
                                  child: Text(
                                    '+ Add',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showClientDetail(BuildContext context, Map<String, dynamic> client) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ClientDetailSheet(client: client),
    );
  }

  void _showAddClientDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _AddClientSheet(),
    );
  }
}

class _ClientCard extends StatelessWidget {
  final Map<String, dynamic> client;
  final Color stageColor;
  final VoidCallback onTap;

  const _ClientCard({
    required this.client,
    required this.stageColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[100]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: client['color'],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      client['initials'],
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    client['name'],
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1B2A4A),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              client['industry'],
              style: GoogleFonts.inter(fontSize: 10, color: Colors.grey[400]),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: stageColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                client['value'],
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: stageColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ClientDetailSheet extends StatelessWidget {
  final Map<String, dynamic> client;

  const _ClientDetailSheet({required this.client});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios, size: 18, color: Color(0xFF1B2A4A)),
              ),
              const SizedBox(width: 8),
              Text(
                'Client Detail',
                style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF1B2A4A)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(color: client['color'], borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: Text(client['initials'], style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w800)),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(client['name'], style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF1B2A4A))),
                  Text(client['industry'], style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[400])),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFFF5A623).withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                child: Text('Negotiation', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFFF5A623))),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _DetailRow('Contact', 'emily@vertex.com'),
          _DetailRow('Source', 'Referral'),
          _DetailRow('Assigned', 'Sarah Kim'),
          _DetailRow('Deal Value', client['value']),
          _DetailRow('Stage', 'Negotiation'),
          const SizedBox(height: 16),
          Text('ACTIVITY LOG', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.grey[400], letterSpacing: 1.0)),
          const SizedBox(height: 10),
          _ActivityItem('Called client — follow-up scheduled for Monday', 'Today, 2:30 PM'),
          _ActivityItem('Sent revised proposal PDF', 'Yesterday, 4:00 PM'),
          _ActivityItem('Initial discovery meeting held', 'Aug 10, 10:00 AM'),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[500])),
          Text(value, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF1B2A4A))),
        ],
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final String text;
  final String time;
  const _ActivityItem(this.text, this.time);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6, height: 6, margin: const EdgeInsets.only(top: 5, right: 10),
            decoration: const BoxDecoration(color: Color(0xFF1B2A4A), shape: BoxShape.circle),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text, style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF1B2A4A))),
                Text(time, style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[400])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AddClientSheet extends StatefulWidget {
  const _AddClientSheet();

  @override
  State<_AddClientSheet> createState() => _AddClientSheetState();
}

class _AddClientSheetState extends State<_AddClientSheet> {
  final _nameCtrl = TextEditingController();
  final _companyCtrl = TextEditingController();
  final _contactCtrl = TextEditingController();
  final _valueCtrl = TextEditingController();
  String _stage = 'Lead';
  String _source = 'Direct';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: EdgeInsets.only(
        left: 20, right: 20, top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back_ios, size: 18, color: Color(0xFF1B2A4A))),
                const SizedBox(width: 8),
                Text('Add / Edit Client', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF1B2A4A))),
              ],
            ),
            const SizedBox(height: 16),
            _field(_nameCtrl, 'Client Name'),
            const SizedBox(height: 10),
            _field(_companyCtrl, 'Company'),
            const SizedBox(height: 10),
            _field(_contactCtrl, 'Contact Info (email / phone)'),
            const SizedBox(height: 10),
            _field(_valueCtrl, 'Deal Value (\$)', keyboardType: TextInputType.number),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _source,
              decoration: _inputDecoration('Source'),
              items: ['Direct', 'Referral', 'Fiverr'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (v) => setState(() => _source = v!),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _stage,
              decoration: _inputDecoration('Stage'),
              items: ['Lead', 'Negotiation', 'Delivery'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (v) => setState(() => _stage = v!),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B2A4A),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: Text('Save Client', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(TextEditingController ctrl, String hint, {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: ctrl,
      keyboardType: keyboardType,
      style: GoogleFonts.inter(fontSize: 14),
      decoration: _inputDecoration(hint),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13),
      filled: true,
      fillColor: Colors.grey[50],
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey[300]!)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey[300]!)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF1B2A4A))),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    );
  }
}
