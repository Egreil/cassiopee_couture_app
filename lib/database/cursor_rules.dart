class CursorRules {
  // Constants for common column names
  static const String columnId = 'id';
  static const String columnCreatedAt = 'created_at';
  static const String columnUpdatedAt = 'updated_at';

  // Helper method to convert cursor to map
  static Map<String, dynamic> cursorToMap(Map<String, dynamic> cursor) {
    return Map<String, dynamic>.from(cursor);
  }

  // Helper method to convert cursor to list of maps
  static List<Map<String, dynamic>> cursorToList(
      List<Map<String, dynamic>> cursor) {
    return List<Map<String, dynamic>>.from(cursor);
  }

  // Helper method to get current timestamp
  static String getCurrentTimestamp() {
    return DateTime.now().toIso8601String();
  }

  // Helper method to add timestamps to a map
  static Map<String, dynamic> addTimestamps(Map<String, dynamic> map,
      {bool isUpdate = false}) {
    final now = getCurrentTimestamp();
    if (!isUpdate) {
      map[columnCreatedAt] = now;
    }
    map[columnUpdatedAt] = now;
    return map;
  }

  // Helper method to parse DateTime from database timestamp
  static DateTime? parseDateTime(String? timestamp) {
    if (timestamp == null) return null;
    return DateTime.tryParse(timestamp);
  }

  // Helper method to create standard WHERE clause
  static String createWhereClause(List<String> conditions) {
    return conditions.join(' AND ');
  }

  // Helper method to safely get value from cursor
  static T? getValue<T>(Map<String, dynamic> cursor, String columnName) {
    final value = cursor[columnName];
    if (value == null) return null;
    return value as T;
  }

  // Helper method to handle database errors
  static void handleDatabaseError(dynamic error) {
    // Add your error handling logic here
    print('Database error: $error');
    throw Exception('Database operation failed: $error');
  }
}
