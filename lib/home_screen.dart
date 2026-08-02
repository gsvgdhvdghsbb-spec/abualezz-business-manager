import 'package:flutter/material.dart';
import 'add_product_screen.dart';
import 'pos_screen.dart';
import 'customers_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نظام إدارة أبو العز'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.point_of_sale),
            tooltip: 'نقطة البيع',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PosScreen()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('نظام إدارة أبو العز'),
              accountEmail: Text('الإصدار الاحترافي V1.0'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.store, size: 40, color: Colors.deepOrange),
              ),
              decoration: BoxDecoration(color: Colors.deepOrange),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard, color: Colors.deepOrange),
              title: const Text('لوحة التحكم'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.add_box, color: Colors.deepOrange),
              title: const Text('إضافة صنف جديد'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddProductScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.point_of_sale, color: Colors.deepOrange),
              title: const Text('الفواتير والمبيعات (POS)'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PosScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.people, color: Colors.deepOrange),
              title: const Text('العملاء والموردون'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CustomersScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ملخص اليوم',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _SummaryCard(
                    title: 'فاتورة جديدة',
                    value: 'POS',
                    icon: Icons.point_of_sale,
                    color: Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PosScreen()),
                      );
                    },
                  ),
                  _SummaryCard(
                    title: 'إضافة صنف',
                    value: 'المخزون',
                    icon: Icons.add_shopping_cart,
                    color: Colors.blue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AddProductScreen()),
                      );
                    },
                  ),
                  _SummaryCard(
                    title: 'العملاء والديون',
                    value: 'الدليل الحسابي',
                    icon: Icons.people,
                    color: Colors.purple,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CustomersScreen()),
                      );
                    },
                  ),
                  const _SummaryCard(
                    title: 'تنبيهات المخزون',
                    value: '0 أصناف',
                    icon: Icons.warning_amber_rounded,
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProductScreen()),
          );
        },
        backgroundColor: Colors.deepOrange,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('إضافة صنف', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: color),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
