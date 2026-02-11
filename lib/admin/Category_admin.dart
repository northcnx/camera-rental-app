import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryAdmin extends StatefulWidget {
  const CategoryAdmin({super.key});

  @override
  State<CategoryAdmin> createState() => _CategoryAdminState();
}

class _CategoryAdminState extends State<CategoryAdmin> {
  final supabase = Supabase.instance.client;
  final picker = ImagePicker();

  late Future<List<dynamic>> categories;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    setState(() {
      categories = _fetchCategories();
    });
  }

  Future<List<dynamic>> _fetchCategories() async {
    return await supabase
        .from('camera_categories')
        .select()
        .order('created_at');
  }

  // ================== UPLOAD IMAGE ==================
  Future<String?> uploadImage(XFile file) async {
    try {
      final bytes = await file.readAsBytes();
      final fileName =
          'category/cat_${DateTime.now().millisecondsSinceEpoch}.jpg';

      await supabase.storage
          .from('category-images')
          .uploadBinary(
            fileName,
            bytes,
            fileOptions: const FileOptions(
              contentType: 'image/jpeg',
              upsert: true,
            ),
          );

      return supabase.storage.from('category-images').getPublicUrl(fileName);
    } catch (e) {
      debugPrint('UPLOAD ERROR: $e');
      return null;
    }
  }

  // ================== DELETE ==================
  Future<void> deleteCategory(String id) async {
    await supabase.from('camera_categories').delete().eq('id', id);
    _refresh();
  }

  // ================== CONFIRM DELETE ==================
  Future<void> confirmDelete(String id) async {
    final ok = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('ยืนยันการลบ'),
        content: const Text('คุณต้องการลบรายการนี้ใช่หรือไม่?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('ยกเลิก'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('ลบ'),
          ),
        ],
      ),
    );

    if (ok == true) {
      await deleteCategory(id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ลบข้อมูลสำเร็จ'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  // ================== DIALOG ADD / EDIT ==================
  void openDialog({String? id, String? currentName, String? currentImage}) {
    final nameCtrl = TextEditingController(text: currentName ?? '');
    XFile? newImage;
    bool saving = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setD) {
            Future<void> pickImage() async {
              final picked = await picker.pickImage(
                source: ImageSource.gallery,
              );
              if (picked != null) setD(() => newImage = picked);
            }

            Future<void> save() async {
              if (nameCtrl.text.isEmpty) return;

              setD(() => saving = true);
              String? imageUrl = currentImage;

              if (newImage != null) {
                imageUrl = await uploadImage(newImage!);
              }

              if (imageUrl == null || imageUrl.isEmpty) {
                setD(() => saving = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('กรุณาเลือกรูปภาพ'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              if (id == null) {
                await supabase.from('camera_categories').insert({
                  'name_manu': nameCtrl.text,
                  'image_camera_manu': imageUrl,
                });
              } else {
                await supabase
                    .from('camera_categories')
                    .update({
                      'name_manu': nameCtrl.text,
                      'image_camera_manu': imageUrl,
                    })
                    .eq('id', id);
              }

              Navigator.pop(ctx);
              _refresh();
            }

            Widget preview() {
              if (newImage != null) {
                return kIsWeb
                    ? Image.network(newImage!.path, fit: BoxFit.cover)
                    : Image.file(File(newImage!.path), fit: BoxFit.cover);
              }
              if (currentImage != null && currentImage.isNotEmpty) {
                return Image.network(currentImage, fit: BoxFit.cover);
              }
              return const Center(child: Text('แตะเพื่อเลือกรูป'));
            }

            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text(id == null ? 'เพิ่มประเภท' : 'แก้ไขประเภท'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameCtrl,
                    style: const TextStyle(color: Color(0xFF676767)),
                    decoration: InputDecoration(
                      labelText: 'ชื่อประเภท',

                      // label ปกติ
                      labelStyle: const TextStyle(
                        color: Color(0xFF676767),
                        fontWeight: FontWeight.w500,
                      ),

                      // label ตอนลอย (อ่านชัด เหมือนมีกรอบ)
                      floatingLabelStyle: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        backgroundColor: Colors.white, // ⭐ สำคัญมาก
                      ),

                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),

                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: saving ? null : pickImage,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 150,
                        color: Colors.grey[300],
                        child: preview(),
                      ),
                    ),
                  ),
                  if (saving) ...[
                    const SizedBox(height: 12),
                    const CircularProgressIndicator(),
                  ],
                ],
              ),
              actions: saving
                  ? []
                  : [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red, // สีตัวอักษร
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(
                              color: Color.fromARGB(255, 224, 24, 9), // สีกรอบ
                              width: 2,
                            ),
                          ),
                        ),
                        child: const Text(
                          'ยกเลิก',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      ElevatedButton(
                        onPressed: save,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            0,
                            138,
                            46,
                          ), // สีปุ่ม
                          foregroundColor: Colors.white, // สีตัวอักษร + icon
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // มุมโค้ง
                          ),
                        ),
                        child: const Text(
                          'บันทึก',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
            );
          },
        );
      },
    );
  }

  // ================== UI ==================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3A3A3A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3A3A3A),
        title: const Text('จัดการประเภท'),
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextButton.icon(
              onPressed: () => openDialog(),
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                'เพิ่มประเภท',
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: categories,
        builder: (_, s) {
          if (!s.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = s.data!;
          if (data.isEmpty) {
            return const Center(child: Text('ไม่มีข้อมูล'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: data.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (_, i) {
              final item = data[i];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // ===== รูปโค้งแล้ว =====
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        child: Image.network(
                          item['image_camera_manu'],
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.broken_image),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(
                        item['name_manu'],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton.icon(
                          onPressed: () => openDialog(
                            id: item['id'],
                            currentName: item['name_manu'],
                            currentImage: item['image_camera_manu'],
                          ),
                          icon: const Icon(Icons.edit, color: Colors.amber),
                          label: const Text(
                            'แก้ไข',
                            style: TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        TextButton.icon(
                          onPressed: () => confirmDelete(item['id']),
                          icon: const Icon(Icons.delete, color: Colors.red),
                          label: const Text(
                            '',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
