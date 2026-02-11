import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotiApprovedPage extends StatelessWidget {
  final dynamic data;

  const NotiApprovedPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // ดึงข้อมูลกล้องจาก Map data
    final camera = data['cameras'] ?? {};
    const bg = Color(0xFF3A3A3A);

    // จัดฟอร์แมตวันที่ให้สวยงาม (ถ้าไม่มีให้ใช้ขีด - แทน)
    String formattedDateRange = "-";
    if (data['start_date'] != null && data['end_date'] != null) {
      try {
        final start = DateFormat('dd').format(DateTime.parse(data['start_date']));
        final end = DateFormat('dd MMM yyyy').format(DateTime.parse(data['end_date']));
        formattedDateRange = "$start - $end";
      } catch (e) {
        formattedDateRange = "${data['start_date']} ถึง ${data['end_date']}";
      }
    }

    // เวลาจำลองรับกล้อง (สามารถเปลี่ยนไปดึงจาก DB ได้ถ้ามี)
    String pickupTime = data['start_date'] != null 
        ? "${DateFormat('dd MMM yyyy').format(DateTime.parse(data['start_date']))} 10:00 น." 
        : "-";

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Header (ช่องค้นหา) ---
              Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.search, color: Colors.black54),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text("ค้นหาการแจ้งเตือน...", style: TextStyle(color: Colors.black45, fontSize: 13)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // --- หัวข้อ "การแจ้งเตือน" และปุ่มย้อนกลับ ---
              Row(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(999),
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white24),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text("การแจ้งเตือน", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(height: 20),

              // --- กล่องดำใหญ่ (รายละเอียดการอนุมัติ) ---
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black, // สีพื้นหลังดำสนิท
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- ส่วนหัว: ร้านค้ายืนยัน ---
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.check_box_outlined, color: Colors.white, size: 28),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text("ร้านค้ายืนยันการเช่าแล้ว", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                  SizedBox(height: 4),
                                  Text("การทำรายการเช่าของคุณสำเร็จ", style: TextStyle(color: Colors.white54, fontSize: 12)),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 25),
                        
                        // --- การ์ดสินค้า (สีเทาเข้ม) ---
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2C2828), // สีพื้นหลังการ์ดสินค้าตามรูป
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  camera['image_url'] ?? '', 
                                  width: 60, height: 60, fit: BoxFit.cover, 
                                  errorBuilder: (c, e, s) => Container(width: 60, height: 60, color: Colors.grey[800])
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(camera['name'] ?? 'ไม่ระบุชื่อสินค้า', style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 6),
                                    const Text("สี: ดำ", style: TextStyle(color: Colors.white70, fontSize: 12)),
                                    const SizedBox(height: 4),
                                    const Text("จำนวน: 1", style: TextStyle(color: Colors.white70, fontSize: 12)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        
                        // --- ข้อมูลรายละเอียดเช่า ---
                        _buildInfoRow(Icons.calendar_month_outlined, "ระยะเวลาเช่า: $formattedDateRange"),
                        const SizedBox(height: 16),
                        _buildInfoRow(Icons.access_time_rounded, "รับกล้อง: $pickupTime"),
                        const SizedBox(height: 16),
                        _buildInfoRow(Icons.credit_card_rounded, "ยอดชำระ: ${data['total_price'] ?? 0} บาท (ชำระแล้ว)"),
                        
                        const SizedBox(height: 35),
                        
                        // --- แถบสีเขียวยืนยันด้านล่าง ---
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6EDC7B), // สีเขียวสว่าง
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Text(
                            "✓ ร้านค้าได้ตรวจสอบและยืนยันการเช่าเรียบร้อยแล้ว\nกรุณามารับสินค้าตามวันและเวลาที่กำหนด",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black87, fontSize: 11, fontWeight: FontWeight.bold, height: 1.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 100), // กันเมนูด้านล่างบัง
            ],
          ),
        ),
      ),
    );
  }

  // ฟังก์ชันช่วยสร้างแถวข้อมูล (ไอคอน + ข้อความ)
  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text, 
            style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)
          ),
        ),
      ],
    );
  }
}