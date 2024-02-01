import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/services/database_helper.dart';

final databaseProvider = Provider<DatabaseHelper>((ref) => DatabaseHelper());