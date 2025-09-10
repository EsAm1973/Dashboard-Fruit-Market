abstract class DatabaseService {
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  });
  Future<Map<String, dynamic>> getData({
    required String path,
    required String documentId,
  });

  Future<bool> checkIfDocumentExists({
    required String path,
    required String documentId,
  });

  Future<List<Map<String, dynamic>>> getAllData({required String path});

  Stream<List<Map<String, dynamic>>> watchAllData({required String path});

  Future<void> updateData({
    required String path,
    required String documentId,
    required Map<String, dynamic> data,
  });

  Future<void> updateWhere({
    required String path,
    required String field,
    required dynamic isEqualTo,
    required Map<String, dynamic> data,
  });
}
