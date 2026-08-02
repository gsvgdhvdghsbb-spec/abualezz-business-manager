import 'package:flutter/material.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  // قائمة تجريبية للعملاء والموردين
  final List<Map<String, dynamic>> _contacts = [
    {'name': 'مؤسسة الأمل', 'phone': '770000000', 'type': 'مورد', 'balance': 150000.0},
    {'name': 'أحمد علي', 'phone': '771112223', 'type': 'عميل', 'balance': -25000.0},
  ];

  void _showAddContactDialog() {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    String type = 'عميل';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إضافة عميل / مورد جديد'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'الاسم الكامل / الجهة'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'رقم الهاتف'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: type,
              items: const [
                DropdownMenuItem(value: 'عميل', child: Text('عميل')),
                DropdownMenuItem(value: 'مورد', child: Text('مورد')),
              ],
              onChanged: (val) => type = val!,
              decoration: const InputDecoration(labelText: 'النوع'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                setState(() {
                  _contacts.add({
                    'name': nameController.text,
                    'phone': phoneController.text,
                    'type': type,
                    'balance': 0.0,
                  });
                });
                Navigator.pop(context);
              }
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('دليل العملاء والموردين'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: _contacts.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final contact = _contacts[index];
          final bool isDebt = contact['balance'] < 0;

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: contact['type'] == 'مورد' ? Colors.blue.shade100 : Colors.orange.shade100,
              child: Icon(
                contact['type'] == 'مورد' ? Icons.local_shipping : Icons.person,
                color: contact['type'] == 'مورد' ? Colors.blue : Colors.deepOrange,
              ),
            ),
            title: Text(contact['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${contact['type']} - هاتف: ${contact['phone']}'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('الرصيد / الحساب:', style: TextStyle(fontSize: 10, color: Colors.grey)),
                Text(
                  '${contact['balance']} ر.ي',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDebt ? Colors.red : Colors.green,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddContactDialog,
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.person_add, color: Colors.white),
      ),
    );
  }
}
