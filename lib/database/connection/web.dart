import 'package:drift/drift.dart';
import 'package:drift/web.dart';

QueryExecutor createDriftDatabase() {
  return WebDatabase('db');
}
