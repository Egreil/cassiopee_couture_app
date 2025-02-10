import 'package:drift/drift.dart';
import 'package:drift/web.dart';

QueryExecutor connectDb() {
  return WebDatabase('db');
}
