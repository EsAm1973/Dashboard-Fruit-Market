import 'dart:io';

import 'package:fruit_market_dashboard/core/services/storage_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as b;

class SupabaseStorageService implements StorageService {
  static late Supabase _supabase;
  static Future<void> initSupabaseStorage() async {
    _supabase = await Supabase.initialize(
      url: 'https://cqmiilnudjjjfffustox.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNxbWlpbG51ZGpqamZmZnVzdG94Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1NDI4MzU2MiwiZXhwIjoyMDY5ODU5NTYyfQ.Vegmfsdfs48dp5Zz-j558Bg5d2JOLPp00YPV8TUBCy0',
    );
  }

  @override
  Future<String> uploadFile(File file, String path) async {
    try {
      String fileName = b.basenameWithoutExtension(file.path);
      String extensionName = b.extension(file.path);
      String filePath = '$path/$fileName$extensionName';
      
      // Upload the file
      await _supabase.client.storage
          .from('products-image')
          .upload(filePath, file);

      // Get the public URL
      String publicUrl = _supabase.client.storage
          .from('products-image')
          .getPublicUrl(filePath);

      return publicUrl;
    } catch (e) {
      throw Exception('Failed to upload file: $e');
    }
  }
}
