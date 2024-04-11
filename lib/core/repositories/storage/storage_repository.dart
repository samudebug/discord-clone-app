import 'dart:io';

abstract class StorageRepository {
  Future<String> uploadFile(File file);
}