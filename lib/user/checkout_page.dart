import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  // รับข้อมูลสินค้าที่ถูกเลือกมาจากหน้าตะกร้า
  final List<dynamic> selectedItems;

  const CheckoutPage({super.key, required this.selectedItems});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int _paymentMethod = 1; // 1 = พร้อมเพย์, 2 = โอนบัญชีธนาคาร
  String? _slipFileName; // ชื่อไฟล์สลิป (จำลองไว้ก่อน)

  // ฟังก์ชันคำนวณยอดรวมเบื้องต้น
  int calculateTotal() {
    int total = 0;
    for (var item in widget.selectedItems) {
      final cam = item['cameras'];
      final price = cam['price_per_day'] ?? 0;
      total += int.parse(price.toString());
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final int totalPrice = calculateTotal();

    return Scaffold(
      backgroundColor: const Color(0xFF757575), // สีเทาตามรูป
      appBar: AppBar(
        backgroundColor: const Color(0xFF757575),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Container(
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ตะกร้าสินค้า', // หัวข้อเหมือนหน้าตะกร้าแต่เป็นหน้าสรุป
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // --- 1. รายการสินค้าที่เลือก ---
            ...widget.selectedItems.map((item) {
              final cam = item['cameras'];
              final isActive = cam['is_active'] ?? false;
              final brand = cam['brand'] ?? 'Canon';

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black, // สีดำตามแบบ
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cam['name'] ?? 'ไม่ระบุชื่อ',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            cam['image_url'] ?? '',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[800],
                              child: const Icon(Icons.camera_alt,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text('สถานะ: ',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12)),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: isActive
                                          ? Colors.green
                                          : Colors.redAccent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      isActive ? 'ว่าง' : 'ไม่ว่าง',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text('${cam['price_per_day'] ?? 0}/วัน',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 12)),
                                  const Spacer(),
                                  const Text('แบรนด์ ',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12)),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(brand,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      minimumSize: const Size(80, 30),
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                    child: const Text('รายละเอียด',
                                        style: TextStyle(fontSize: 12)),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF00509E),
                                      foregroundColor: Colors.white,
                                      minimumSize: const Size(80, 30),
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                    child: const Text('เช่าเลย',
                                        style: TextStyle(fontSize: 12)),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }).toList(), // วนลูปแสดงสินค้าทุกชิ้นที่ส่งมา

            // --- 2. สรุปราคา ---
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('สรุปราคา', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Text('ค่าบริการเช่ารวม: $totalPrice฿', style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text('ยอดรวม: $totalPrice฿', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), // ถ้ามีค่ามัดจำค่อยมาบวกเพิ่มตรงนี้
                  )
                ],
              ),
            ),

            // --- 3. วิธีชำระเงิน ---
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('วิธีชำระเงิน', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  // พร้อมเพย์
                  RadioListTile<int>(
                    value: 1,
                    groupValue: _paymentMethod,
                    onChanged: (val) => setState(() => _paymentMethod = val!),
                    title: const Text('พร้อมเพย์ทางร้าน', style: TextStyle(color: Colors.white, fontSize: 14)),
                    activeColor: Colors.white,
                    contentPadding: EdgeInsets.zero,
                  ),
                  // แสดง QR Code ถ้าเลือกพร้อมเพย์
                  if (_paymentMethod == 1)
                    Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        width: 120,
                        height: 120,
                        color: Colors.white,
                        child: const Center(child: Text('QR Code', style: TextStyle(color: Colors.black))), // เดี๋ยวค่อยเอาภาพ QR จริงมาใส่
                      ),
                    ),
                  // โอนบัญชีธนาคาร
                  RadioListTile<int>(
                    value: 2,
                    groupValue: _paymentMethod,
                    onChanged: (val) => setState(() => _paymentMethod = val!),
                    title: const Text('โอนบัญชีธนาคาร', style: TextStyle(color: Colors.white, fontSize: 14)),
                    activeColor: Colors.white,
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),

            // --- 4. แนบสลิปการโอน ---
            Container(
              margin: const EdgeInsets.only(bottom: 24),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('แนบสลิปการโอน', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // TODO: ใส่โค้ดเปิด Gallery มือถือ
                          setState(() {
                            _slipFileName = "slip_image_01.jpg"; // จำลองว่าเลือกไฟล์แล้ว
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[600],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: const Text('Choose File'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _slipFileName ?? 'No File chosen',
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),

            // --- 5. ปุ่มส่งการจอง ---
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: บันทึกข้อมูลคำสั่งซื้อลง Supabase
                  print("ส่งการจอง สำเร็จ!");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  'ส่งการจองให้ทางร้าน',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 40), // เว้นที่ด้านล่างหน่อย
          ],
        ),
      ),
    );
  }
}