import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class LogbookScreen extends StatefulWidget {
  const LogbookScreen({super.key});

  @override
  State<LogbookScreen> createState() => _LogbookScreenState();
}

class _LogbookScreenState extends State<LogbookScreen> {
  List<dynamic> _entries = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadLogbook();
  }

  Future<void> _loadLogbook() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/logbook.json');

      if (await file.exists()) {
        final content = await file.readAsString();
        final List<dynamic> logs = json.decode(content);
        setState(() {
          _entries = logs.reversed.toList(); // show newest first
        });
      }
    } catch (e) {
      debugPrint('❌ Error reading logbook: $e');
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Widget _buildEntry(Map<String, dynamic> entry) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.assignment_turned_in, color: Colors.green),
        title: Text(entry['result'] ?? '📝 No result description'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('🕒 ${entry['timestamp']}'),
            if (entry['note'] != null) Text('Note: ${entry['note']}'),
          ],
        ),
        trailing: Text(entry['cost'] ?? 'N/A', style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AgriX Logbook')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _entries.isEmpty
              ? const Center(
                  child: Text(
                    '📭 No log entries found.\nPerform a scan and save results to view them here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadLogbook,
                  child: ListView.builder(
                    itemCount: _entries.length,
                    itemBuilder: (context, index) =>
                        _buildEntry(_entries[index] as Map<String, dynamic>),
                  ),
                ),
    );
  }
}
