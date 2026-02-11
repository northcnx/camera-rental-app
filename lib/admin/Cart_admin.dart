// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class CartAdmin extends StatefulWidget {
//   const CartAdmin({super.key});

//   @override
//   State<CartAdmin> createState() => _CartAdminState();
// }

// class _CartAdminState extends State<CartAdmin> {
//   final supabase = Supabase.instance.client;
//   final picker = ImagePicker();

//   List<dynamic> cameraList = [];
//   List<dynamic> categories = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchCamerasFast();
//     loadCategories();
//   }

//   // ================= FETCH FAST =================
//   Future<void> fetchCamerasFast() async {
//     // เพิ่ม rented_by เข้าไปใน select ด้วย เพื่อให้ข้อมูลครบถ้วน
//     cameraList = await supabase
//         .from('cameras')
//         .select('''
//           id,
//           name,
//           price_per_day,
//           brand,
//           image_url,
//           is_active,
//           rented_by, 
//           category_id,
//           camera_categories(name_manu)
//         ''')
//         .order('created_at', ascending: false);

//     setState(() {});
//   }

//   Future<void> loadCategories() async {
//     categories = await supabase
//         .from('camera_categories')
//         .select('id, name_manu');

//     setState(() {});
//   }

//   // ================= IMAGE UPLOAD =================
//   Future<String?> uploadImage(Uint8List bytes) async {
//     try {
//       final filePath =
//           'camera/cam_${DateTime.now().millisecondsSinceEpoch}.jpg';

//       await supabase.storage
//           .from('camera-images')
//           .uploadBinary(
//             filePath,
//             bytes,
//             fileOptions: const FileOptions(
//               contentType: 'image/jpeg',
//               upsert: false,
//             ),
//           );

//       return supabase.storage.from('camera-images').getPublicUrl(filePath);
//     } catch (e) {
//       debugPrint('UPLOAD ERROR: $e');
//       return null;
//     }
//   }

//   // ================= TOGGLE (แก้ไขแล้ว) =================
//   // ฟังก์ชันนี้จะทำการล้าง rented_by เมื่อเปิดใช้งาน (is_active = true)
//   void toggleActiveFast(int index) async {
//     final item = cameraList[index];
//     final newValue = !item['is_active']; // ค่าใหม่ที่จะเป็น (True/False)

//     setState(() {
//       item['is_active'] = newValue;
//       // ถ้าค่าใหม่คือ True (ว่าง/เปิดใช้งาน) ให้ล้างชื่อคนเช่าใน UI ทันที
//       if (newValue == true) {
//         item['rented_by'] = null;
//       }
//     });

//     // เตรียมข้อมูลสำหรับอัปเดต
//     final Map<String, dynamic> updateData = {'is_active': newValue};

//     // ถ้าเปิดใช้งาน (Available) ให้ล้างข้อมูล rented_by ในฐานข้อมูลด้วย
//     if (newValue == true) {
//       updateData['rented_by'] = null;
//     }

//     await supabase.from('cameras').update(updateData).eq('id', item['id']);
//   }

//   // ================= DELETE =================
//   Future<void> deleteCamera(int index) async {
//     final id = cameraList[index]['id'];
//     setState(() {
//       cameraList.removeAt(index);
//     });

//     await supabase.from('cameras').delete().eq('id', id);
//   }

//   // ================= ADD / EDIT =================
//   void openDialog({Map<String, dynamic>? item, int? editIndex}) {
//     final nameCtrl = TextEditingController(text: item?['name'] ?? '');
//     final priceCtrl = TextEditingController(
//       text: item?['price_per_day']?.toString() ?? '',
//     );
//     final brandCtrl = TextEditingController(text: item?['brand'] ?? '');

//     String? categoryId = item?['category_id'];
//     Uint8List? imageBytes;
//     bool saving = false;

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (ctx) {
//         return StatefulBuilder(
//           builder: (ctx, setD) {
//             Future<void> pickImage() async {
//               final picked = await picker.pickImage(
//                 source: ImageSource.gallery,
//               );
//               if (picked != null) {
//                 imageBytes = await picked.readAsBytes();
//                 setD(() {});
//               }
//             }

//             Future<void> save() async {
//               if (nameCtrl.text.isEmpty ||
//                   priceCtrl.text.isEmpty ||
//                   brandCtrl.text.isEmpty ||
//                   categoryId == null) {
//                 return;
//               }

//               setD(() => saving = true);

//               String? imageUrl = item?['image_url'];
//               if (imageBytes != null) {
//                 imageUrl = await uploadImage(imageBytes!);
//               }
//               if (imageUrl == null) return;

//               final data = {
//                 'name': nameCtrl.text,
//                 'price_per_day': int.parse(priceCtrl.text),
//                 'brand': brandCtrl.text,
//                 'category_id': categoryId,
//                 'image_url': imageUrl,
//               };

//               if (item == null) {
//                 // Insert
//                 final inserted = await supabase
//                     .from('cameras')
//                     .insert(data)
//                     .select('''
//                       id,
//                       name,
//                       price_per_day,
//                       brand,
//                       image_url,
//                       is_active,
//                       rented_by,
//                       category_id,
//                       camera_categories(name_manu)
//                     ''')
//                     .single();

//                 setState(() {
//                   cameraList.insert(0, inserted);
//                 });
//               } else {
//                 // Update
//                 await supabase
//                     .from('cameras')
//                     .update(data)
//                     .eq('id', item['id']);

//                 setState(() {
//                   cameraList[editIndex!] = {
//                     ...item,
//                     ...data,
//                     'camera_categories': {
//                       'name_manu': categories.firstWhere(
//                         (c) => c['id'] == categoryId,
//                       )['name_manu'],
//                     },
//                   };
//                 });
//               }

//               if (ctx.mounted) Navigator.pop(ctx);
//             }

//             return AlertDialog(
//               title: Text(item == null ? 'เพิ่มสินค้า' : 'แก้ไขสินค้า'),
//               content: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     TextField(
//                       controller: nameCtrl,
//                       decoration: const InputDecoration(labelText: 'ชื่อกล้อง'),
//                     ),
//                     TextField(
//                       controller: priceCtrl,
//                       keyboardType: TextInputType.number,
//                       decoration: const InputDecoration(
//                         labelText: 'ราคาต่อวัน',
//                       ),
//                     ),
//                     TextField(
//                       controller: brandCtrl,
//                       decoration: const InputDecoration(labelText: 'แบรนด์'),
//                     ),
//                     const SizedBox(height: 8),
//                     DropdownButtonFormField<String>(
//                       value: categoryId,
//                       hint: const Text('เลือกประเภท'),
//                       items: categories
//                           .map(
//                             (c) => DropdownMenuItem<String>(
//                               value: c['id'],
//                               child: Text(c['name_manu']),
//                             ),
//                           )
//                           .toList(),
//                       onChanged: (v) => setD(() => categoryId = v),
//                     ),
//                     const SizedBox(height: 10),
//                     GestureDetector(
//                       onTap: pickImage,
//                       child: Container(
//                         height: 150,
//                         color: Colors.grey[300],
//                         child: imageBytes != null
//                             ? Image.memory(imageBytes!, fit: BoxFit.cover)
//                             : item?['image_url'] != null
//                             ? Image.network(
//                                 item!['image_url'],
//                                 fit: BoxFit.cover,
//                               )
//                             : const Center(child: Text('เลือกรูป')),
//                       ),
//                     ),
//                     if (saving)
//                       const Padding(
//                         padding: EdgeInsets.all(8),
//                         child: CircularProgressIndicator(),
//                       ),
//                   ],
//                 ),
//               ),
//               actions: saving
//                   ? []
//                   : [
//                       TextButton(
//                         onPressed: () => Navigator.pop(ctx),
//                         child: const Text('ยกเลิก'),
//                       ),
//                       ElevatedButton(
//                         onPressed: save,
//                         child: const Text('บันทึก'),
//                       ),
//                     ],
//             );
//           },
//         );
//       },
//     );
//   }

//   // ================= UI =================
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('จัดการสินค้า'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add),
//             onPressed: () => openDialog(),
//           ),
//         ],
//       ),
//       body: cameraList.isEmpty
//           ? const Center(child: Text('ไม่มีสินค้า'))
//           : ListView.builder(
//               itemCount: cameraList.length,
//               itemBuilder: (_, i) {
//                 final item = cameraList[i];
//                 final isRented = item['rented_by'] != null;

//                 return Card(
//                   margin: const EdgeInsets.all(8),
//                   // เปลี่ยนสีพื้นหลังเล็กน้อยถ้าถูกเช่าอยู่ จะได้สังเกตง่าย
//                   color: isRented ? Colors.orange.shade50 : Colors.white,
//                   child: ListTile(
//                     leading: Image.network(
//                       item['image_url'] ?? '',
//                       width: 60,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) =>
//                           const Icon(Icons.camera_alt),
//                     ),
//                     title: Text(item['name'] ?? ''),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           '${item['price_per_day']} / วัน • '
//                           '${item['brand']} • '
//                           '${item['camera_categories']?['name_manu'] ?? '-'}',
//                         ),
//                         if (isRented)
//                           const Text(
//                             'สถานะ: ถูกเช่าอยู่',
//                             style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                       ],
//                     ),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         // Switch เปิด-ปิด สถานะ
//                         Switch(
//                           value: item['is_active'] ?? false,
//                           onChanged: (_) => toggleActiveFast(i),
//                           activeColor: Colors.green,
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.edit, color: Colors.orange),
//                           onPressed: () => openDialog(item: item, editIndex: i),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete, color: Colors.red),
//                           onPressed: () => deleteCamera(i),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }




import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartAdmin extends StatefulWidget {
  const CartAdmin({super.key});

  @override
  State<CartAdmin> createState() => _CartAdminState();
}

class _CartAdminState extends State<CartAdmin> {
  final supabase = Supabase.instance.client;
  final picker = ImagePicker();

  List<dynamic> cameraList = [];
  List<dynamic> categories = [];

  @override
  void initState() {
    super.initState();
    fetchCamerasFast();
    loadCategories();
  }

  Future<void> fetchCamerasFast() async {
    cameraList = await supabase
        .from('cameras')
        .select('''
          id, name, price_per_day, brand, image_url, is_active, 
          rented_by, category_id, items_included,
          camera_categories(name_manu)
        ''')
        .order('created_at', ascending: false);
    setState(() {});
  }

  Future<void> loadCategories() async {
    categories = await supabase.from('camera_categories').select('id, name_manu');
    setState(() {});
  }

  Future<String?> uploadImage(Uint8List bytes) async {
    try {
      final filePath = 'camera/cam_${DateTime.now().millisecondsSinceEpoch}.jpg';
      await supabase.storage.from('camera-images').uploadBinary(
            filePath,
            bytes,
            fileOptions: const FileOptions(contentType: 'image/jpeg', upsert: false),
          );
      return supabase.storage.from('camera-images').getPublicUrl(filePath);
    } catch (e) {
      debugPrint('UPLOAD ERROR: $e');
      return null;
    }
  }

  void toggleActiveFast(int index) async {
    final item = cameraList[index];
    final newValue = !item['is_active'];
    setState(() {
      item['is_active'] = newValue;
      if (newValue == true) item['rented_by'] = null;
    });
    final Map<String, dynamic> updateData = {'is_active': newValue};
    if (newValue == true) updateData['rented_by'] = null;
    await supabase.from('cameras').update(updateData).eq('id', item['id']);
  }

  Future<void> deleteCamera(int index) async {
    final id = cameraList[index]['id'];
    setState(() => cameraList.removeAt(index));
    await supabase.from('cameras').delete().eq('id', id);
  }

  // ================= ปรับปรุงหน้าเปิดเพิ่ม/แก้ไขสินค้า =================
  void openDialog({Map<String, dynamic>? item, int? editIndex}) {
    final nameCtrl = TextEditingController(text: item?['name'] ?? '');
    final priceCtrl = TextEditingController(text: item?['price_per_day']?.toString() ?? '');
    final brandCtrl = TextEditingController(text: item?['brand'] ?? '');
    final itemsIncludedCtrl = TextEditingController(text: item?['items_included'] ?? ''); // ⭐ ช่องพิมพ์อุปกรณ์เอง

    String? categoryId = item?['category_id'];
    Uint8List? imageBytes;
    bool saving = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setD) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: Text(item == null ? 'เพิ่มสินค้าใหม่' : 'แก้ไขข้อมูลสินค้า'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'ชื่อสินค้า')),
                    TextField(controller: brandCtrl, decoration: const InputDecoration(labelText: 'ยี่ห้อ')),
                    TextField(controller: priceCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'ราคาเช่าต่อวัน')),
                    const SizedBox(height: 10),
                    // ⭐ ช่องใส่ "อุปกรณ์ที่ให้" แบบพิมพ์เอง
                    TextField(
                      controller: itemsIncludedCtrl, 
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'อุปกรณ์ที่ทางร้านให้',
                        hintText: 'เช่น แบตเตอรี่, ที่ชาร์จ, กระเป๋า...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: categoryId,
                      hint: const Text('เลือกหมวดหมู่'),
                      items: categories.map((c) => DropdownMenuItem<String>(value: c['id'], child: Text(c['name_manu']))).toList(),
                      onChanged: (v) => setD(() => categoryId = v),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () async {
                        final picked = await picker.pickImage(source: ImageSource.gallery);
                        if (picked != null) {
                          imageBytes = await picked.readAsBytes();
                          setD(() {});
                        }
                      },
                      child: Container(
                        height: 120, width: double.infinity,
                        color: Colors.grey[200],
                        child: imageBytes != null
                            ? Image.memory(imageBytes!, fit: BoxFit.cover)
                            : (item?['image_url'] != null ? Image.network(item!['image_url'], fit: BoxFit.cover) : const Icon(Icons.add_a_photo)),
                      ),
                    ),
                    if (saving) const Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
                  ],
                ),
              ),
              actions: [
                if (!saving) Row(
                  children: [
                    // ⭐ ปุ่มยกเลิก
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: OutlinedButton.styleFrom(foregroundColor: Colors.black, side: const BorderSide(color: Colors.black)),
                        child: const Text('ยกเลิก'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // ⭐ ปุ่มบันทึก
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (nameCtrl.text.isEmpty || priceCtrl.text.isEmpty || categoryId == null) return;
                          setD(() => saving = true);
                          
                          String? imageUrl = item?['image_url'];
                          if (imageBytes != null) {
                            imageUrl = await uploadImage(imageBytes!);
                          }

                          final data = {
                            'name': nameCtrl.text,
                            'price_per_day': int.parse(priceCtrl.text),
                            'brand': brandCtrl.text,
                            'category_id': categoryId,
                            'items_included': itemsIncludedCtrl.text, // ⭐ ส่งข้อมูลที่พิมพ์เอง
                            if (imageUrl != null) 'image_url': imageUrl,
                          };

                          if (item == null) {
                            final res = await supabase.from('cameras').insert(data).select('*, camera_categories(name_manu)').single();
                            setState(() => cameraList.insert(0, res));
                          } else {
                            await supabase.from('cameras').update(data).eq('id', item['id']);
                            await fetchCamerasFast(); // รีเฟรชข้อมูลหลังอัปเดต
                          }
                          if (ctx.mounted) Navigator.pop(ctx);
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
                        child: const Text('บันทึก'),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('จัดการสินค้า', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white, elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.add_circle, color: Colors.black, size: 30), onPressed: () => openDialog()),
        ],
      ),
      body: cameraList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: cameraList.length,
              itemBuilder: (_, i) {
                final item = cameraList[i];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(item['image_url'] ?? '', width: 50, height: 50, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.camera)),
                    ),
                    title: Text(item['name'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${item['price_per_day']} / วัน • ${item['brand']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Switch(value: item['is_active'] ?? false, onChanged: (_) => toggleActiveFast(i), activeColor: Colors.green),
                        IconButton(icon: const Icon(Icons.edit, color: Colors.orange), onPressed: () => openDialog(item: item, editIndex: i)),
                        IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => deleteCamera(i)),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}