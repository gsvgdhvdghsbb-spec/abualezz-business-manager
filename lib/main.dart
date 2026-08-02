import 'package:flutter/material.dart';

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
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0D1B2A),
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {},
              ),
              const Column(
                children: [
                  Text('مرحباً', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text('أبو العز', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
              const CircleAvatar(
                backgroundColor: Color(0xFF1B263B),
                child: Icon(Icons.person, color: Colors.white),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'لوحة التحكم',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              
              // بطاقات الإحصائيات العلوية
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      title: 'إجمالي الديون',
                      value: '8,750.00',
                      unit: 'ريال',
                      color: const Color(0xFFD90429),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      title: 'إجمالي النقد',
                      value: '12,540.00',
                      unit: 'ريال',
                      color: const Color(0xFF2EC4B6),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      title: 'عدد الفواتير',
                      value: '320',
                      unit: '',
                      color: const Color(0xFF3A86FF),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      title: 'عدد العملاء',
                      value: '125',
                      unit: '',
                      color: const Color(0xFF3A86FF),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // بطاقة إجمالي الأرباح
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B263B),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white12),
                ),
                child: const Column(
                  children: [
                    Text('إجمالي الأرباح', style: TextStyle(color: Colors.grey, fontSize: 14)),
                    SizedBox(height: 8),
                    Text(
                      '24,680.00 ريال',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // بطاقة رسم بياني مبسط للأرباح الشهرية
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B263B),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('الأرباح الشهرية', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    Container(
                      height: 120,
                      color: Colors.black26,
                      child: const Center(
                        child: Icon(Icons.show_chart, color: Color(0xFF3A86FF), size: 80),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // زر الإضافة الدائري
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF3A86FF),
          onPressed: () {},
          child: const Icon(Icons.add, size: 30, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        // شريط الملاحة السفلي
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
                const SizedBox(width: 40), // مسافة لزر +
                _buildNavItem(Icons.receipt, 'الفواتير', 2),
                _buildNavItem(Icons.more_horiz, 'المزيد', 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({required String title, required String value, required String unit, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(color: Colors.white70, fontSize: 13)),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          if (unit.isNotEmpty) Text(unit, style: const TextStyle(color: Colors.white70, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? const Color(0xFF3A86FF) : Colors.grey),
          Text(label, style: TextStyle(color: isSelected ? const Color(0xFF3A86FF) : Colors.grey, fontSize: 10)),
        ],
      ),
    );
  }
}
