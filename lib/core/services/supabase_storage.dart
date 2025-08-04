import 'dart:io';

import 'package:fruit_market_dashboard/core/services/storage_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageService implements StorageService {
  static late Supabase _supabase;
  static void initSupabaseStorage() async {
    _supabase = await Supabase.initialize(
      url: 'https://cqmiilnudjjjfffustox.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNxbWlpbG51ZGpqamZmZnVzdG94Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQyODM1NjIsImV4cCI6MjA2OTg1OTU2Mn0.3bBtVmsUK8TnDPrb-krPiVx2pg44p_LUFmQ8jOhLRYE',
    );
  }

  @override
  Future<String> uploadFile(File file, String path) {
    // TODO: implement uploadFile
    throw UnimplementedError();
  }
}
