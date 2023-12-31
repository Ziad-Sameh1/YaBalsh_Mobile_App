import 'package:hive/hive.dart';
import 'package:yabalash_mobile_app/core/api/local_data_api/local_storage_provider.dart';
import 'package:yabalash_mobile_app/core/errors/exceptions.dart';

class HiveLocalDataConsumer implements LocalStorageProvider {
  @override
  void deleteData({required key, id}) async {
    try {
      if (!Hive.isBoxOpen(key)) {
        await Hive.openBox(key);
      }
      final box = Hive.box(key);

      box.delete(key);
      box.close();
    } catch (err) {
      throw CacheException();
    }
  }

  @override
  dynamic getData({required key, type}) {
    try {
      if (!Hive.isBoxOpen(key)) {
        Hive.openBox(key);
      }
      final box = Hive.box(key);
      final data = box.get(key);

      return data;
    } catch (err) {
      throw CacheException();
    }
  }

  @override
  void setData({required key, required data}) async {
    try {
      if (!Hive.isBoxOpen(key)) {
        await Hive.openBox(key);
      }
      final box = Hive.box(key);

      box.put(key, data);
      box.close();
    } catch (err) {
      throw CacheException();
    }
  }

  @override
  void addData({required key, required data}) {
    try {
      if (!Hive.isBoxOpen(key)) {
        Hive.openBox(key);
      }
      final box = Hive.box(key);

      box.add(data);
      box.close();
    } catch (err) {
      throw CacheException();
    }
  }
}
