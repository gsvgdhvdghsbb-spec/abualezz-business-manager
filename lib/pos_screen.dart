import 'package:flutter/material.dart';

class PosScreen extends StatefulWidget {
  const PosScreen({super.key});

  @override
  State<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen> {
  // قائمة تجريبية بالسلة
  final List<Map<String, dynamic>> _cartItems = [];
  double _totalAmount = 0.0;

  void _addItemToCart(String name, double price) {
    setState(() {
      _cartItems.add({
        'name': name,
        'price': price,
        'quantity': 1,
      });
      _calculateTotal();
    });
  }

  void _calculateTotal() {
    _totalAmount = _cartItems.fold(0.0, (sum, item) => sum + (item['price'] * item['quantity']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نقطة البيع - فاتورة جديدة'),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () {
              // مسح باركود المنتج لإضافته للفاتورة مباشرة
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // شريط البحث المباشر
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ابحث باسم الصنف أو الباركود...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          
          // قائمة المنتجات بالفاتورة
          Expanded(
            child: _cartItems.isEmpty
                ? const Center(
                    child: Text(
                      'الفاتورة فارغة\nقم بمسح الباركود أو اختيار صنف',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      final item = _cartItems[index];
                      return ListTile(
                        title: Text(item['name']),
                        subtitle: Text('السعر: ${item['price']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('x${item['quantity']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  _cartItems.removeAt(index);
                                  _calculateTotal();
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          // منطقة حساب الإجمالي وزر الحفظ والطباعة
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('الإجمالي الكلي:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(
                      '$_totalAmount ر.ي',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepOrange),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _cartItems.isEmpty ? null : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم إصدار الفاتورة وحفظها بنجاح!')),
                      );
                    },
                    icon: const Icon(Icons.print),
                    label: const Text('إصدار وحفظ الفاتورة', style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
