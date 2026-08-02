import 'package:flutter/material';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نظام إدارة أبو العز'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
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
              leading: const Icon(Icons.dashboard),
              title: const Text('لوحة التحكم'),
              onTap: () => setState(() => _selectedIndex = 0),
            ),
            ListTile(
              leading: const Icon(Icons.inventory_2),
              title: const Text('المخزون والأصناف'),
              onTap: () => setState(() => _selectedIndex = 1),
            ),
            ListTile(
              leading: const Icon(Icons.point_of_sale),
              title: const Text('الفواتير والمبيعات'),
              onTap: () => setState(() => _selectedIndex = 2),
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('العملاء والموردون'),
              onTap: () => setState(() => _selectedIndex = 3),
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('التقارير المالية'),
              onTap: () => setState(() => _selectedIndex = 4),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('الإعدادات'),
              onTap: () {},
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
                children: const [
                  _SummaryCard(
                    title: 'المبيعات اليومية',
                    value: '0.00',
                    icon: Icons.monetization_on,
                    color: Colors.green,
                  ),
                  _SummaryCard(
                    title: 'المشتريات',
                    value: '0.00',
                    icon: Icons.shopping_cart,
                    color: Colors.blue,
                  ),
                  _SummaryCard(
                    title: 'الديون المستحقة',
                    value: '0.00',
                    icon: Icons.account_balance_wallet,
                    color: Colors.red,
                  ),
                  _SummaryCard(
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
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: color),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
