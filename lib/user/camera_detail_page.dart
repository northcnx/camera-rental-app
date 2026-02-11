// import 'package:flutter/material.dart';

// class CameraDetailPage extends StatelessWidget {
//   final dynamic camera;

//   const CameraDetailPage({super.key, required this.camera});

//   @override
//   Widget build(BuildContext context) {
//     // กำหนดค่าตัวแปร (ป้องกัน Error กรณีข้อมูลเป็น null)
//     final String imageUrl = camera != null && camera['image_url'] != null
//         ? camera['image_url']
//         : '';
//     final String name = camera != null && camera['name'] != null
//         ? camera['name']
//         : 'ไม่มีชื่อ';
//     final String brand = camera != null && camera['brand'] != null
//         ? camera['brand']
//         : '-';
//     final dynamic rawPrice = camera != null ? camera['price_per_day'] : 0;
//     final String price = rawPrice.toString();

//     return Scaffold(
//       backgroundColor: const Color(0xFF3A3A3A),
//       appBar: AppBar(
//         title: Text(name, style: const TextStyle(color: Colors.white)),
//         backgroundColor: const Color(0xFF3A3A3A),
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // รูปภาพ
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: imageUrl.isNotEmpty
//                   ? Image.network(
//                       imageUrl,
//                       width: double.infinity,
//                       height: 250,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) {
//                         return Container(
//                           height: 250,
//                           color: Colors.grey[800],
//                           child: const Center(
//                             child: Icon(
//                               Icons.broken_image,
//                               color: Colors.white,
//                               size: 50,
//                             ),
//                           ),
//                         );
//                       },
//                     )
//                   : Container(
//                       height: 250,
//                       color: Colors.grey[800],
//                       child: const Center(
//                         child: Icon(
//                           Icons.image_not_supported,
//                           color: Colors.white,
//                           size: 50,
//                         ),
//                       ),
//                     ),
//             ),
//             const SizedBox(height: 16),

//             // ชื่อ
//             Text(
//               name,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),

//             // แบรนด์
//             Text(
//               'แบรนด์: $brand',
//               style: const TextStyle(color: Colors.white70, fontSize: 18),
//             ),
//             const SizedBox(height: 8),

//             // ราคา
//             Text(
//               'ราคาเช่า: ฿$price / วัน',
//               style: const TextStyle(
//                 color: Colors.orangeAccent,
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class CameraDetailPage extends StatefulWidget {
//   final dynamic camera;

//   const CameraDetailPage({super.key, required this.camera});

//   @override
//   State<CameraDetailPage> createState() => _CameraDetailPageState();
// }

// class _CameraDetailPageState extends State<CameraDetailPage> {
//   // ตัวแปรสำหรับเก็บวันที่ที่ผู้ใช้เลือก
//   DateTime? startDate;
//   DateTime? endDate;

//   // ฟังก์ชันสำหรับเปิดปฏิทินเลือกวัน
//   Future<void> _selectDate(BuildContext context, bool isStartDate) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(), // วันเริ่มต้นคือวันนี้
//       firstDate: DateTime.now(),   // เลือกย้อนหลังไม่ได้
//       lastDate: DateTime(2030),    // เลือกได้ถึงปี 2030
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: Color(0xFF1E1E1E), // สีส่วนหัวของปฏิทิน
//               onPrimary: Colors.white,
//               onSurface: Colors.black, // สีตัวเลขวัน
//             ),
//           ),
//           child: child ?? const SizedBox.shrink(),
//         );
//       },
//     );

//     if (picked != null) {
//       setState(() {
//         if (isStartDate) {
//           startDate = picked;
//           // ถ้าเลือกวันรับหลังวันคืน ให้เคลียร์วันคืนทิ้งไป
//           if (endDate != null && endDate!.isBefore(startDate!)) {
//             endDate = null;
//           }
//         } else {
//           // ถ้าเลือกวันคืนก่อนวันรับ ให้แจ้งเตือน
//           if (startDate != null && picked.isBefore(startDate!)) {
//              ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('วันคืนของต้องอยู่หลังวันรับของ')),
//             );
//             return;
//           }
//           endDate = picked;
//         }
//       });
//     }
//   }

//   // ฟังก์ชันแปลงวันที่ให้เป็นข้อความสวยๆ (เช่น 14 ก.พ. 2026)
//   String _formatDate(DateTime? date) {
//     if (date == null) return "เลือกวันที่";
//     return DateFormat('dd MMM yyyy').format(date);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // ป้องกัน Error กรณีข้อมูลเป็น null
//     final cam = widget.camera ?? {};
//     final String imageUrl = cam['image_url'] ?? '';
//     final String name = cam['name'] ?? 'ไม่มีชื่อ';
//     final dynamic price = cam['price_per_day'] ?? 0;
//     final bool isActive = cam['is_active'] ?? false;
//     final int stock = cam['stock'] ?? 3; // สมมติว่ามี field stock

//     return Scaffold(
//       backgroundColor: const Color(0xFF757575), // สีพื้นหลังเทากลางๆ ตามรูป
//       body: SafeArea(
//         child: Stack(
//           children: [
//             SingleChildScrollView(
//               padding: const EdgeInsets.only(bottom: 100), // เผื่อที่ให้ปุ่มด้านล่าง
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // --- ปุ่มย้อนกลับ & ช่องค้นหา (Search Bar) ---
//                     Row(
//                       children: [
//                         // ปุ่มย้อนกลับ
//                         Container(
//                           margin: const EdgeInsets.only(right: 12),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.2), // สีพื้นหลังปุ่มใสๆ
//                             shape: BoxShape.circle,
//                           ),
//                           child: IconButton(
//                             icon: const Icon(Icons.arrow_back, color: Colors.white),
//                             onPressed: () {
//                               Navigator.pop(context); // คำสั่งย้อนกลับไปหน้าก่อนหน้า
//                             },
//                           ),
//                         ),
//                         // ช่องค้นหา
//                         Expanded(
//                           child: Container(
//                             height: 40,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: const TextField(
//                               decoration: InputDecoration(
//                                 hintText: 'ค้นหา...',
//                                 prefixIcon: Icon(Icons.search, color: Colors.grey),
//                                 border: InputBorder.none,
//                                 contentPadding: EdgeInsets.symmetric(vertical: 10),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),

//                     // --- หัวข้อหมวดหมู่ & ชื่อกล้อง ---
//                     const Text(
//                       'Digital Camera', // หรือจะดึงจาก category ของกล้องก็ได้
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 28,
//                         fontWeight: FontWeight.normal,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       name,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                       ),
//                     ),
//                     const SizedBox(height: 16),

//                     // --- รูปภาพกล้อง ---
//                     Container(
//                       width: double.infinity,
//                       height: 250,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(16),
//                         child: imageUrl.isNotEmpty
//                             ? Image.network(
//                                 imageUrl,
//                                 fit: BoxFit.contain, // ให้รูปพอดีในกรอบขาว
//                               )
//                             : const Icon(Icons.camera_alt, size: 80, color: Colors.grey),
//                       ),
//                     ),
//                     const SizedBox(height: 24),

//                     // --- ราคา, สถานะ, ในคลังเหลืออีก ---
//                     Text(
//                       '$price/วัน',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 24,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         const Text('สถานะ: ', style: TextStyle(color: Colors.white70)),
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                           decoration: BoxDecoration(
//                             color: isActive ? Colors.green : Colors.redAccent,
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Text(
//                             isActive ? 'ว่าง' : 'ไม่ว่าง',
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'ในคลังเหลืออีก       $stock ตัว',
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                     const SizedBox(height: 16),

//                     // --- สี (ตัวเลือก) ---
//                     const Text('สี', style: TextStyle(color: Colors.white)),
//                     const SizedBox(height: 4),
//                     Container(
//                       width: 60,
//                       height: 25,
//                       decoration: BoxDecoration(
//                         color: Colors.grey[300],
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                     ),
//                     const SizedBox(height: 16),

//                     // --- วันที่รับ & วันที่คืน (กดแล้วมีปฏิทินเด้ง) ---
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text('วันที่รับ', style: TextStyle(color: Colors.white)),
//                               const SizedBox(height: 4),
//                               GestureDetector(
//                                 onTap: () => _selectDate(context, true),
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey[300],
//                                     borderRadius: BorderRadius.circular(4),
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(_formatDate(startDate), style: const TextStyle(color: Colors.black87)),
//                                       const Icon(Icons.calendar_today, size: 16, color: Colors.black54),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text('วันที่คืน', style: TextStyle(color: Colors.white)),
//                               const SizedBox(height: 4),
//                               GestureDetector(
//                                 onTap: () => _selectDate(context, false),
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey[300],
//                                     borderRadius: BorderRadius.circular(4),
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(_formatDate(endDate), style: const TextStyle(color: Colors.black87)),
//                                       const Icon(Icons.calendar_today, size: 16, color: Colors.black54),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 24),

//                     // --- จุดเด่น ---
//                     const Text(
//                       'จุดเด่น',
//                       style: TextStyle(color: Colors.white, fontSize: 18),
//                     ),
//                     const SizedBox(height: 8),
//                     const Text(
//                       '1. ขนาดพกพา + คุณภาพภาพดีกว่ามือถือ (1-inch sensor)\n'
//                       '→ เหมาะกับนักท่องเที่ยวที่อยากได้คุณภาพสูงในตัวเครื่องเล็กๆ\n'
//                       '2. เลนส์สว่าง f/1.8\n'
//                       'ทำงานได้ดีในสภาพแสงน้อยและให้โบเก้สวยสำหรับถ่ายพอร์ตเทรต/Vlog\n'
//                       '3. ฟีเจอร์วิดีโอครบ (4K, FHD120) + ช่องเสียบไมค์ + live streaming\n'
//                       '→ เหมาะสำหรับครีเอเตอร์',
//                       style: TextStyle(color: Colors.white70, fontSize: 14),
//                     ),
//                     const SizedBox(height: 24),

//                     // --- อุปกรณ์ที่ให้ ---
//                     const Text(
//                       'อุปกรณ์ที่ให้',
//                       style: TextStyle(color: Colors.white, fontSize: 14),
//                     ),
//                     const SizedBox(height: 8),
//                     const Text(
//                       '1) ตัวกล้อง (Camera Body)\n'
//                       '2) แบตเตอรี่ (Battery)\n'
//                       '3) ที่ชาร์จแบต / แท่นชาร์จ\n'
//                       '4) กระเป๋ากล้อง\n'
//                       '5) สายคล้องมือ / คล้องคอ\n'
//                       '6) ผ้าเช็ดเลนส์',
//                       style: TextStyle(color: Colors.white70, fontSize: 14),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             // --- ปุ่ม "เลือกลงตะกร้า" (ลอยอยู่ด้านล่างสุด) ---
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF757575).withOpacity(0.9), // เพิ่มพื้นหลังโปร่งแสงนิดๆ
//                 ),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // TODO: ใส่คำสั่งบันทึกลงฐานข้อมูลตาราง carts
//                     if (startDate == null || endDate == null) {
//                        ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('กรุณาเลือกวันที่รับและวันที่คืน')),
//                       );
//                       return;
//                     }
//                     print("เพิ่มลงตะกร้า: $name, วันรับ: $startDate, วันคืน: $endDate");
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF262626), // สีดำตามปุ่มในรูป
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: const Text(
//                     'เลือกลงตะกร้า',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // <--- อย่าลืม import supabase ด้วย

class CameraDetailPage extends StatefulWidget {
  final dynamic camera;

  const CameraDetailPage({super.key, required this.camera});

  @override
  State<CameraDetailPage> createState() => _CameraDetailPageState();
}

class _CameraDetailPageState extends State<CameraDetailPage> {
  DateTime? startDate;
  DateTime? endDate;

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), 
      firstDate: DateTime.now(),   
      lastDate: DateTime(2030),    
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF1E1E1E), 
              onPrimary: Colors.white,
              onSurface: Colors.black, 
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
          if (endDate != null && endDate!.isBefore(startDate!)) {
            endDate = null;
          }
        } else {
          if (startDate != null && picked.isBefore(startDate!)) {
             ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('วันคืนของต้องอยู่หลังวันรับของ')),
            );
            return;
          }
          endDate = picked;
        }
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "เลือกวันที่";
    return DateFormat('dd MMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final cam = widget.camera ?? {};
    final String imageUrl = cam['image_url'] ?? '';
    final String name = cam['name'] ?? 'ไม่มีชื่อ';
    final dynamic price = cam['price_per_day'] ?? 0;
    final bool isActive = cam['is_active'] ?? false;
    final int stock = cam['stock'] ?? 3; 

    return Scaffold(
      backgroundColor: const Color(0xFF757575), 
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100), 
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2), 
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () {
                              Navigator.pop(context); 
                            },
                          ),
                        ),
                        Expanded(
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
                      ],
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      'Digital Camera', 
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: imageUrl.isNotEmpty
                            ? Image.network(
                                imageUrl,
                                fit: BoxFit.contain, 
                              )
                            : const Icon(Icons.camera_alt, size: 80, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 24),

                    Text(
                      '$price/วัน',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text('สถานะ: ', style: TextStyle(color: Colors.white70)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: isActive ? Colors.green : Colors.redAccent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            isActive ? 'ว่าง' : 'ไม่ว่าง',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'ในคลังเหลืออีก       $stock ตัว',
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 16),

                    const Text('สี', style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 4),
                    Container(
                      width: 60,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('วันที่รับ', style: TextStyle(color: Colors.white)),
                              const SizedBox(height: 4),
                              GestureDetector(
                                onTap: () => _selectDate(context, true),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(_formatDate(startDate), style: const TextStyle(color: Colors.black87)),
                                      const Icon(Icons.calendar_today, size: 16, color: Colors.black54),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('วันที่คืน', style: TextStyle(color: Colors.white)),
                              const SizedBox(height: 4),
                              GestureDetector(
                                onTap: () => _selectDate(context, false),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(_formatDate(endDate), style: const TextStyle(color: Colors.black87)),
                                      const Icon(Icons.calendar_today, size: 16, color: Colors.black54),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      'จุดเด่น',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '1. ขนาดพกพา + คุณภาพภาพดีกว่ามือถือ (1-inch sensor)\n'
                      '→ เหมาะกับนักท่องเที่ยวที่อยากได้คุณภาพสูงในตัวเครื่องเล็กๆ\n'
                      '2. เลนส์สว่าง f/1.8\n'
                      'ทำงานได้ดีในสภาพแสงน้อยและให้โบเก้สวยสำหรับถ่ายพอร์ตเทรต/Vlog\n'
                      '3. ฟีเจอร์วิดีโอครบ (4K, FHD120) + ช่องเสียบไมค์ + live streaming\n'
                      '→ เหมาะสำหรับครีเอเตอร์',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      'อุปกรณ์ที่ให้',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '1) ตัวกล้อง (Camera Body)\n'
                      '2) แบตเตอรี่ (Battery)\n'
                      '3) ที่ชาร์จแบต / แท่นชาร์จ\n'
                      '4) กระเป๋ากล้อง\n'
                      '5) สายคล้องมือ / คล้องคอ\n'
                      '6) ผ้าเช็ดเลนส์',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),

            // --- ⭐ ปุ่ม "เลือกลงตะกร้า" (แก้ไขให้บันทึกลงฐานข้อมูลแล้ว) ---
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF757575).withOpacity(0.9), 
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    // 1. เช็คว่าเลือกวันหรือยัง
                    if (startDate == null || endDate == null) {
                       ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('กรุณาเลือกวันที่รับและวันที่คืน')),
                      );
                      return;
                    }

                    try {
                      // 2. เช็คว่าล็อกอินหรือยัง
                      final user = Supabase.instance.client.auth.currentUser;
                      if (user == null) {
                         ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('กรุณาเข้าสู่ระบบก่อนทำรายการ')),
                        );
                        return;
                      }

                      // 3. ส่งข้อมูลเข้าตาราง carts
                      await Supabase.instance.client.from('carts').insert({
                        'user_id': user.id,
                        'camera_id': cam['id'],
                        'qty': 1,
                        'start_date': startDate!.toIso8601String(), // วันที่รับ
                        'end_date': endDate!.toIso8601String(),     // วันที่คืน
                      });

                      // 4. ถ้าสำเร็จ ให้โชว์ป๊อปอัปเขียว และเด้งกลับไปหน้าก่อนหน้า
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('เพิ่มลงตะกร้าสำเร็จ!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pop(context); // กลับไปหน้าหมวดหมู่
                      }
                    } catch (e) {
                      // 5. ถ้าพัง (เช่นเพื่อนยังไม่เพิ่มคอลัมน์) จะโชว์ป๊อปอัปแดง
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('เกิดข้อผิดพลาด: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF262626), 
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'เลือกลงตะกร้า',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}