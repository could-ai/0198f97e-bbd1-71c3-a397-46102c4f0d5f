import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/password_entry.dart';
import 'add_password_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text('密码管理器'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddPasswordScreen()),
              );
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<Box<PasswordEntry>>(
        valueListenable: Hive.box<PasswordEntry>('passwords').listenable(),
        builder: (context, box, _) {
          final passwords = box.values.toList();
          if (passwords.isEmpty) {
            return const Center(
              child: Text('暂无密码条目，请点击右上角添加'),
            );
          }
          return ListView.builder(
            itemCount: passwords.length,
            itemBuilder: (context, index) {
              final entry = passwords[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(entry.title),
                  subtitle: Text('${entry.username} @ ${entry.website}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.visibility),
                    onPressed: () {
                      _showPasswordDialog(context, entry);
                    },
                  ),
                  onLongPress: () {
                    _showOptionsDialog(context, entry);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showPasswordDialog(BuildContext context, PasswordEntry entry) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(entry.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('用户名: ${entry.username}'),
            Text('密码: ${entry.password}'),
            Text('网站: ${entry.website}'),
            if (entry.notes != null) Text('备注: ${entry.notes}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  void _showOptionsDialog(BuildContext context, PasswordEntry entry) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('操作'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _editPassword(context, entry);
            },
            child: const Text('编辑'),
          ),
          TextButton(
            onPressed: () {
              entry.delete();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('密码已删除')),
              );
            },
            child: const Text('删除', style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
        ],
      ),
    );
  }

  void _editPassword(BuildContext context, PasswordEntry entry) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPasswordScreen(entry: entry),
      ),
    );
  }
}
