import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'checkout_page.dart';

class CartUser extends StatefulWidget {
  const CartUser({super.key});

  @override
  State<CartUser> createState() => _CartUserState();
}

class _CartUserState extends State<CartUser> {
  final supabase = Supabase.instance.client;

  late Future<List<dynamic>> cartFuture;
  bool _isLoading = false;

  // เก็บ ID ของตะกร้าที่ถูกติ๊กเลือก
  Set<String> selectedCartIds = {};

  // ⭐ ตัวแปรใหม่: ตรวจสอบว่าอยู่ในโหมด "แก้ไข" หรือไม่
  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
    cartFuture = fetchCart();
  }

  Future<List<dynamic>> fetchCart() async {
    final user = supabase.auth.currentUser;
    if (user == null) return [];

    return await supabase
        .from('carts')
        .select('id, qty, cameras(*)')
        .eq('user_id', user.id);
  }

  // ฟังก์ชันสำหรับสลับการเลือกสินค้า
  void toggleSelection(String cartId) {
    setState(() {
      if (selectedCartIds.contains(cartId)) {
        selectedCartIds.remove(cartId);
      } else {
        selectedCartIds.add(cartId);
      }
    });
  }

  // ⭐ ฟังก์ชันใหม่: สำหรับลบสินค้าที่ติ๊กเลือกออกจากฐานข้อมูล Supabase
  Future<void> deleteSelectedItems() async {
    if (selectedCartIds.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // วนลูปเพื่อลบสินค้าตาม ID ที่ติ๊กไว้
      for (String cartId in selectedCartIds) {
        await supabase.from('carts').delete().eq('id', cartId);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ลบสินค้าออกจากตะกร้าเรียบร้อยแล้ว'),
            backgroundColor: Colors.green,
          ),
        );

        // รีเซ็ตค่า เคลียร์ที่เลือกไว้ ปิดโหมดแก้ไข และดึงข้อมูลตะกร้าใหม่
        setState(() {
          selectedCartIds.clear();
          _isEditMode = false;
          cartFuture = fetchCart(); 
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('เกิดข้อผิดพลาดในการลบ: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF323232), // สีพื้นหลังเทาเข้ม
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- ช่องค้นหา (Search Bar) ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'ค้นหา...',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ),

            // --- หัวข้อ "ตะกร้าสินค้า" และปุ่ม แก้ไข ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ตะกร้าสินค้า',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // ⭐ เปลี่ยนให้เหลือแค่ปุ่มแก้ไข และชิดขวา
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isEditMode = !_isEditMode; // สลับโหมดเปิด/ปิด
                            // ถ้ากดยกเลิกโหมดแก้ไข ให้เคลียร์ของที่ติ๊กเลือกไว้ด้วย
                            if (!_isEditMode) {
                              selectedCartIds.clear();
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          // ถ้าอยู่โหมดแก้ไข ปุ่มจะเป็นสีแดง ถ้าปกติจะเป็นสีขาว
                          backgroundColor: _isEditMode ? Colors.redAccent : Colors.white,
                          foregroundColor: _isEditMode ? Colors.white : Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          minimumSize: Size.zero,
                        ),
                        child: Text(_isEditMode ? 'เสร็จสิ้น' : 'แก้ไข'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),

            // --- รายการสินค้า ---
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: cartFuture,
                builder: (_, s) {
                  if (s.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!s.hasData || s.data!.isEmpty) {
                    return const Center(
                      child: Text('ไม่มีสินค้าในตะกร้า', style: TextStyle(color: Colors.white70)),
                    );
                  }

                  final cartItems = s.data!;

                  return Stack(
                    children: [
                      RefreshIndicator(
                        onRefresh: () async {
                          setState(() {
                            cartFuture = fetchCart();
                          });
                        },
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 120), // เผื่อที่ให้ปุ่มด้านล่าง
                          itemCount: cartItems.length,
                          itemBuilder: (_, i) {
                            final cart = cartItems[i];
                            final cam = cart['cameras'];
                            final cartId = cart['id'].toString();
                            final isSelected = selectedCartIds.contains(cartId);
                            final isActive = cam['is_active'] ?? false; // เช็คสถานะว่าง
                            final brand = cam['brand'] ?? 'Canon';

                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E1E1E), // สีการ์ดดำเทา
                                borderRadius: BorderRadius.circular(16),
                                // ถ้าอยู่ในโหมดแก้ไขและถูกเลือก ให้ขอบการ์ดเป็นสีแดง
                                border: _isEditMode && isSelected 
                                    ? Border.all(color: Colors.redAccent, width: 1.5) 
                                    : null,
                              ),
                              child: Column(
                                children: [
                                  // ชื่อกล้อง + ปุ่มเลือก (Radio/Checkbox)
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          cam['name'] ?? 'ไม่ระบุชื่อ',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => toggleSelection(cartId),
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            // เปลี่ยนสีวงกลมตามโหมด
                                            color: isSelected 
                                                ? (_isEditMode ? Colors.redAccent : Colors.grey[400]) 
                                                : Colors.transparent,
                                            border: Border.all(
                                              color: _isEditMode ? Colors.redAccent : Colors.grey[400]!, 
                                              width: 2
                                            ),
                                          ),
                                          child: isSelected
                                              ? Icon(
                                                  Icons.check, 
                                                  size: 16, 
                                                  color: _isEditMode ? Colors.white : const Color(0xFF1E1E1E)
                                                )
                                              : null,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  // รูปภาพ + รายละเอียด
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // รูปกล้อง
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          cam['image_url'] ?? '',
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) => Container(
                                            width: 80, height: 80, color: Colors.grey[800],
                                            child: const Icon(Icons.camera_alt, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      // ข้อมูลด้านขวา
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Text('สถานะ: ', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                                  decoration: BoxDecoration(
                                                    color: isActive ? Colors.green : Colors.redAccent,
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: Text(
                                                    isActive ? 'ว่าง' : 'ไม่ว่าง',
                                                    style: const TextStyle(color: Colors.white, fontSize: 12),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Text('${cam['price_per_day'] ?? 0}/วัน', style: const TextStyle(color: Colors.white, fontSize: 12)),
                                                const Spacer(),
                                                const Text('แบรนด์ ', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: Text(brand, style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      
                      // --- ⭐ ปุ่มลอยด้านล่าง (สลับการทำงานตามโหมด) ---
                      Positioned(
                        bottom: 90, 
                        right: 16,
                        child: GestureDetector(
                          onTap: () {
                            // ถ้าไม่ได้เลือกอะไรเลย
                            if (selectedCartIds.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(_isEditMode ? 'กรุณาเลือกสินค้าที่ต้องการลบ' : 'กรุณาเลือกสินค้าอย่างน้อย 1 รายการ'),
                                  backgroundColor: Colors.orange,
                                ),
                              );
                              return;
                            }

                            if (_isEditMode) {
                              // 🔴 โหมดแก้ไข: กดแล้วลบสินค้า
                              deleteSelectedItems();
                            } else {
                              // 🟢 โหมดปกติ: กดแล้วไปหน้าชำระเงิน
                              final selectedItems = cartItems
                                  .where((item) => selectedCartIds.contains(item['id'].toString()))
                                  .toList();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CheckoutPage(selectedItems: selectedItems),
                                ),
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            decoration: BoxDecoration(
                              // สีปุ่ม: โหมดแก้ไขเป็นสีแดงเข้ม โหมดปกติเป็นสีชมพูอมแดง
                              color: _isEditMode ? const Color(0xFFD32F2F) : const Color(0xFFFF5C5C), 
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))
                              ]
                            ),
                            child: _isLoading 
                              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                              : Row(
                                  children: [
                                    if (_isEditMode) const Icon(Icons.delete, color: Colors.white, size: 20),
                                    if (_isEditMode) const SizedBox(width: 8),
                                    Text(
                                      _isEditMode 
                                          ? 'ลบสินค้า (${selectedCartIds.length})' 
                                          : 'เลือกสินค้า (${selectedCartIds.length})',
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                  ],
                                ),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
