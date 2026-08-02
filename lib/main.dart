import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() {
  runApp(const AbuAlEzzApp());
}

class AbuAlEzzApp extends StatelessWidget {
  const AbuAlEzzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'محاسبة أبو العز',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D1B2A),
        primaryColor: const Color(0xFF1B263B),
        cardColor: const Color(0xFF1B263B),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const DashboardScreen(),
      const CustomersScreen(),
      const InvoicesScreen(),
      MoreMenuScreen(onNavigate: _onTabTapped),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0D1B2A),
          elevation: 0,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.account_balance_wallet, color: Color(0xFF3A86FF)),
              Column(
                children: [
                  Text('محاسبة أبو العز', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text('Abu Al-Ezz Accounting', style: TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              ),
              CircleAvatar(
                backgroundColor: Color(0xFF1B263B),
                child: Icon(Icons.person, color: Colors.white, size: 20),
              ),
            ],
          ),
        ),
        body: screens[_selectedIndex],
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF3A86FF),
          onPressed: () => _showAddInvoiceDialog(context),
          child: const Icon(Icons.add, size: 30, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: const Color(0xFF1B263B),
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home, 'الرئيسية', 0),
                _buildNavItem(Icons.people, 'العملاء', 1),
                const SizedBox(width: 40),
                _buildNavItem(Icons.receipt, 'الفواتير', 2),
                _buildNavItem(Icons.grid_view, 'المزيد', 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => _onTabTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? const Color(0xFF3A86FF) : Colors.grey),
          Text(label, style: TextStyle(color: isSelected ? const Color(0xFF3A86FF) : Colors.grey, fontSize: 11)),
        ],
      ),
    );
  }

  void _showAddInvoiceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1B263B),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('إجراء جديد', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2EC4B6), minimumSize: const Size(double.infinity, 45)),
                icon: const Icon(Icons.arrow_upward, color: Colors.white),
                label: const Text('فاتورة بيع جديدة', style: TextStyle(color: Colors.white)),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD90429), minimumSize: const Size(double.infinity, 45)),
                icon: const Icon(Icons.arrow_downward, color: Colors.white),
                label: const Text('فاتورة شراء جديدة', style: TextStyle(color: Colors.white)),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 1. لوحة التحكم
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(child: Text('لوحة التحكم', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white))),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(child: _buildStatCard('إجمالي الديون', '8,750.00', 'ريال', const Color(0xFFD90429))),
              const SizedBox(width: 10),
              Expanded(child: _buildStatCard('إجمالي النقد', '12,540.00', 'ريال', const Color(0xFF2EC4B6))),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _buildStatCard('عدد الفواتير', '320', '', const Color(0xFF3A86FF))),
              const SizedBox(width: 10),
              Expanded(child: _buildStatCard('عدد العملاء', '125', '', const Color(0xFF3A86FF))),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFF1B263B), borderRadius: BorderRadius.circular(12)),
            child: const Column(
              children: [
                Text('إجمالي الأرباح', style: TextStyle(color: Colors.grey)),
                SizedBox(height: 5),
                Text('24,680.00 ريال', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFF1B263B), borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('الأرباح الشهرية', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                Container(
                  height: 100,
                  decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(8)),
                  child: const Center(child: Icon(Icons.show_chart, color: Color(0xFF3A86FF), size: 70)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String unit, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Text(title, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 5),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          if (unit.isNotEmpty) Text(unit, style: const TextStyle(color: Colors.white70, fontSize: 10)),
        ],
      ),
    );
  }
}

// 2. العملاء والديون
class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customers = [
      {'name': 'أحمد محمد', 'phone': '771234567', 'debt': '2,450.00 ريال'},
      {'name': 'سلمان عبدالله', 'phone': '777888999', 'debt': '850.00 ريال'},
      {'name': 'مورد الرياض', 'phone': '711223344', 'debt': '1,600.00 ريال'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: customers.length,
      itemBuilder: (context, index) {
        final c = customers[index];
        return Card(
          color: const Color(0xFF1B263B),
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: const CircleAvatar(backgroundColor: Color(0xFF3A86FF), child: Icon(Icons.person, color: Colors.white)),
            title: Text(c['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text(c['phone']!, style: const TextStyle(color: Colors.grey)),
            trailing: Text(c['debt']!, style: const TextStyle(color: Color(0xFFD90429), fontWeight: FontWeight.bold)),
          ),
        );
      },
    );
  }
}

// 3. شاشة الفواتير
class InvoicesScreen extends StatelessWidget {
  const InvoicesScreen({super.key});

  void _printInvoice(String invoiceId, String amount) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text('Abu Al-Ezz Accounting', style: const pw.TextStyle(fontSize: 24)),
                pw.SizedBox(height: 10),
                pw.Text('Invoice ID: $invoiceId', style: const pw.TextStyle(fontSize: 18)),
                pw.Text('Total Amount: $amount', style: const pw.TextStyle(fontSize: 18)),
              ],
            ),
          );
        },
      ),
    );
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    final invoices = [
      {'id': '#INV-000125', 'name': 'عميل نقدي', 'amount': '1,250.00 ريال', 'status': 'مدفوعة'},
      {'id': '#INV-000124', 'name': 'أحمد محمد', 'amount': '2,450.00 ريال', 'status': 'جزئية'},
      {'id': '#INV-000123', 'name': 'مورد رئيسي', 'amount': '3,200.00 ريال', 'status': 'غير مدفوعة'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: invoices.length,
      itemBuilder: (context, index) {
        final inv = invoices[index];
        return Card(
          color: const Color(0xFF1B263B),
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: QrImageView(
              data: "${inv['id']} - ${inv['amount']}",
              version: QrVersions.auto,
              size: 40.0,
              backgroundColor: Colors.white,
            ),
            title: Text('${inv['id']} - ${inv['name']}', style: const TextStyle(color: Colors.white, fontSize: 14)),
            subtitle: Text(inv['amount'] as String, style: const TextStyle(color: Colors.white70)),
            trailing: IconButton(
              icon: const Icon(Icons.print, color: Color(0xFF3A86FF)),
              onPressed: () => _printInvoice(inv['id'] as String, inv['amount'] as String),
            ),
          ),
        );
      },
    );
  }
}

// 4. شبكة الموديولات والربط بالشاشات المخصصة
class MoreMenuScreen extends StatelessWidget {
  final Function(int) onNavigate;
  const MoreMenuScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final modules = [
      {'title': 'إدارة العملاء', 'icon': Icons.groups, 'screen': null, 'tab': 1},
      {'title': 'إدارة الأصناف', 'icon': Icons.inventory_2, 'screen': const ProductsScreen(), 'tab': -1},
      {'title': 'الفواتير', 'icon': Icons.receipt_long, 'screen': null, 'tab': 2},
      {'title': 'الصندوق النقدي', 'icon': Icons.account_balance, 'screen': const CashBoxScreen(), 'tab': -1},
      {'title': 'الديون والتحصيل', 'icon': Icons.money_off, 'screen': const DebtsScreen(), 'tab': -1},
      {'title': 'تقارير الأرباح', 'icon': Icons.analytics, 'screen': const ReportsScreen(), 'tab': -1},
      {'title': 'نسخ احتياطي', 'icon': Icons.cloud_upload, 'screen': const BackupScreen(), 'tab': -1},
      {'title': 'الإعدادات', 'icon': Icons.settings, 'screen': const SettingsScreen(), 'tab': -1},
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: modules.length,
      itemBuilder: (context, index) {
        final item = modules[index];
        final screen = item['screen'] as Widget?;
        final tab = item['tab'] as int;

        return Material(
          color: const Color(0xFF1B263B),
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              if (tab != -1) {
                onNavigate(tab);
              } else if (screen != null) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item['icon'] as IconData, color: const Color(0xFF3A86FF), size: 30),
                  const SizedBox(height: 8),
                  Text(item['title'] as String, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 11)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// --- شاشات الموديولات المستقلة ---

// شاشة إدارة الأصناف والمخزون
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {'name': 'فلتر زيت', 'price': '270.00 ريال', 'qty': '12 حبة'},
      {'name': 'بواجي', 'price': '100.00 ريال', 'qty': '24 حبة'},
      {'name': 'زيت محرك', 'price': '80.00 ريال', 'qty': '15 حبة'},
      {'name': 'فلتر هواء', 'price': '40.00 ريال', 'qty': '8 حبة'},
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('إدارة الأصناف والمخزون'), backgroundColor: const Color(0xFF0D1B2A)),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final p = products[index];
            return Card(
              color: const Color(0xFF1B263B),
              child: ListTile(
                leading: const Icon(Icons.inventory, color: Color(0xFF3A86FF)),
                title: Text(p['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: Text('الكمية: ${p['qty']}', style: const TextStyle(color: Colors.grey)),
                trailing: Text(p['price']!, style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
              ),
            );
          },
        ),
      ),
    );
  }
}

// شاشة الصندوق النقدي
class CashBoxScreen extends StatelessWidget {
  const CashBoxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('حركة الصندوق النقدي'), backgroundColor: const Color(0xFF0D1B2A)),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildRow('رصيد بداية اليوم', '10,540.00 ريال', Colors.white),
              const SizedBox(height: 10),
              _buildRow('إجمالي الوارد', '5,750.00 ريال', Colors.green),
              const SizedBox(height: 10),
              _buildRow('إجمالي الصادر', '3,250.00 ريال', Colors.red),
              const Divider(color: Colors.grey, height: 30),
              _buildRow('الرصيد الحالي', '13,040.00 ريال', const Color(0xFF3A86FF)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF1B263B), borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
          Text(value, style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// شاشة الديون والتحصيل
class DebtsScreen extends StatelessWidget {
  const DebtsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('الديون والتحصيل'), backgroundColor: const Color(0xFF0D1B2A)),
        body: const Center(child: Text('جدول الديون وأقساط العملاء والموردين', style: TextStyle(color: Colors.white))),
      ),
    );
  }
}

// شاشة التقارير
class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('تقارير الأرباح والمصروفات'), backgroundColor: const Color(0xFF0D1B2A)),
        body: const Center(child: Text('تقارير المبيعات والأرباح والمصروفات', style: TextStyle(color: Colors.white))),
      ),
    );
  }
}

// شاشة النسخ الاحتياطي
class BackupScreen extends StatelessWidget {
  const BackupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('النسخ الاحتياطي السحابي'), backgroundColor: const Color(0xFF0D1B2A)),
        body: Center(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3A86FF), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
            icon: const Icon(Icons.cloud_upload, color: Colors.white),
            label: const Text('إنشاء نسخة احتياطية الآن', style: TextStyle(color: Colors.white)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إنشاء النسخة الاحتياطية بنجاح')));
            },
          ),
        ),
      ),
    );
  }
}

// شاشة الإعدادات
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('الإعدادات'), backgroundColor: const Color(0xFF0D1B2A)),
        body: const Center(child: Text('إعدادات التطبيق والحساب والعملة', style: TextStyle(color: Colors.white))),
      ),
    );
  }
}
