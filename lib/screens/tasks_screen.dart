import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  String _filter = 'All';
  final List<String> _filters = ['All', 'Pending', 'Completed', 'Overdue'];

  final List<Map<String, dynamic>> _tasks = [
    {
      'title': 'Design Q3 presentation deck',
      'priority': 'High',
      'due': 'Aug 24',
      'initials': 'SK',
      'color': Color(0xFF1B2A4A),
      'completed': false,
      'status': 'Pending',
    },
    {
      'title': 'Review client proposals for Vertex',
      'priority': 'Medium',
      'due': 'Aug 22',
      'initials': 'JO',
      'color': Color(0xFFF5A623),
      'completed': true,
      'status': 'Completed',
    },
    {
      'title': 'Onboard new team member Ben',
      'priority': 'Low',
      'due': 'Aug 21',
      'initials': 'MA',
      'color': Color(0xFF9B59B6),
      'completed': false,
      'status': 'Overdue',
    },
    {
      'title': 'Update pipeline stage for Acme',
      'priority': 'Medium',
      'due': 'Aug 23',
      'initials': 'PS',
      'color': Color(0xFF2ECC71),
      'completed': false,
      'status': 'Pending',
    },
    {
      'title': 'Send weekly performance report',
      'priority': 'High',
      'due': 'Aug 25',
      'initials': 'SK',
      'color': Color(0xFF1B2A4A),
      'completed': false,
      'status': 'Pending',
    },
  ];

  Color _priorityColor(String priority) {
    switch (priority) {
      case 'High':
        return const Color(0xFFE74C3C);
      case 'Medium':
        return const Color(0xFFF5A623);
      case 'Low':
        return const Color(0xFF2ECC71);
      default:
        return Colors.grey;
    }
  }

  List<Map<String, dynamic>> get _filtered {
    if (_filter == 'All') return _tasks;
    return _tasks.where((t) => t['status'] == _filter).toList();
  }

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
                  'Tasks',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1B2A4A),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _showAddTask(context),
                  icon: const Icon(Icons.add, size: 16),
                  label: Text('Task', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
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

            // Filter tabs
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: _filters.map((f) {
                  final active = _filter == f;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _filter = f),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: active ? const Color(0xFF1B2A4A) : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            f,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: active ? Colors.white : Colors.grey[400],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView.separated(
                itemCount: _filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, i) {
                  final task = _filtered[i];
                  return GestureDetector(
                    onTap: () => _showTaskDetail(context, task),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                task['completed'] = !task['completed'];
                                task['status'] = task['completed'] ? 'Completed' : 'Pending';
                              });
                            },
                            child: Icon(
                              task['completed']
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: task['completed']
                                  ? const Color(0xFF2ECC71)
                                  : Colors.grey[300],
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task['title'],
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1B2A4A),
                                    decoration: task['completed']
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: _priorityColor(task['priority']).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        task['priority'],
                                        style: GoogleFonts.inter(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: _priorityColor(task['priority']),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Icon(Icons.calendar_today_outlined,
                                        size: 11, color: Colors.grey[400]),
                                    const SizedBox(width: 3),
                                    Text(
                                      task['due'],
                                      style: GoogleFonts.inter(
                                          fontSize: 11, color: Colors.grey[400]),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: task['color'],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                task['initials'],
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTaskDetail(BuildContext context, Map<String, dynamic> task) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _TaskDetailSheet(task: task),
    );
  }

  void _showAddTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _AddTaskSheet(),
    );
  }
}

class _TaskDetailSheet extends StatelessWidget {
  final Map<String, dynamic> task;

  const _TaskDetailSheet({required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back_ios, size: 18, color: Color(0xFF1B2A4A))),
              const SizedBox(width: 8),
              Text('Task Detail', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF1B2A4A))),
            ],
          ),
          const SizedBox(height: 16),
          Text(task['title'], style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: const Color(0xFF1B2A4A))),
          const SizedBox(height: 8),
          Text(
            'Create a comprehensive performance deck for the board meeting.',
            style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[500], height: 1.5),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5A623).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('Due ${task['due']}', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFFF5A623))),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE74C3C).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('High Priority', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFFE74C3C))),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('COMMENTS', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.grey[400], letterSpacing: 1.0)),
          const SizedBox(height: 10),
          _CommentTile('SK', 'Sarah Kim', '7h ago', 'Slides 1-5 complete, working on the performance charts now.', const Color(0xFF1B2A4A)),
          _CommentTile('MA', 'Marcus Allen', '4h ago', 'Please include client retention data from Q2.', const Color(0xFF9B59B6)),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _CommentTile extends StatelessWidget {
  final String initials;
  final String name;
  final String time;
  final String comment;
  final Color color;

  const _CommentTile(this.initials, this.name, this.time, this.comment, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
            child: Center(child: Text(initials, style: GoogleFonts.inter(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700))),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF1B2A4A))),
                    const SizedBox(width: 6),
                    Text(time, style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[400])),
                  ],
                ),
                const SizedBox(height: 2),
                Text(comment, style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600], height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AddTaskSheet extends StatefulWidget {
  const _AddTaskSheet();

  @override
  State<_AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<_AddTaskSheet> {
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  String _priority = 'Medium';

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
                Text('Add Task', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF1B2A4A))),
              ],
            ),
            const SizedBox(height: 16),
            _field(_titleCtrl, 'Task title'),
            const SizedBox(height: 10),
            TextField(
              controller: _descCtrl,
              maxLines: 3,
              style: GoogleFonts.inter(fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Description...',
                hintStyle: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13),
                filled: true, fillColor: Colors.grey[50],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey[300]!)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey[300]!)),
                contentPadding: const EdgeInsets.all(14),
              ),
            ),
            const SizedBox(height: 10),
            Text('Priority', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500, color: const Color(0xFF1B2A4A))),
            const SizedBox(height: 8),
            Row(
              children: ['Low', 'Medium', 'High'].map((p) {
                final selected = _priority == p;
                Color c = p == 'Low' ? const Color(0xFF2ECC71) : p == 'Medium' ? const Color(0xFFF5A623) : const Color(0xFFE74C3C);
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => _priority = p),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: selected ? c : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: selected ? c : Colors.grey[300]!),
                      ),
                      child: Text(p, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: selected ? Colors.white : Colors.grey[500])),
                    ),
                  ),
                );
              }).toList(),
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
                child: Text('Create Task', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(TextEditingController ctrl, String hint) {
    return TextField(
      controller: ctrl,
      style: GoogleFonts.inter(fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13),
        filled: true, fillColor: Colors.grey[50],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey[300]!)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey[300]!)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
    );
  }
}
