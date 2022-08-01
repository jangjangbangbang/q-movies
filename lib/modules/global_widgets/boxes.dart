import 'package:hive/hive.dart';
import 'package:q_movies/models/cache_hive.dart';

class Boxes {
  static Box<CacheHive> getCacheHive() => Hive.box<CacheHive>('cacheHive');
}
