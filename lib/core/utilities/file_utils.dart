import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class FileUtils {
  static List<String> kPdfAndImageExtensions = ['pdf', 'jpg', 'jpeg', 'png'];

  static Future<String?> pickSingleFile({List<String>? allowedExtensions}) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions ?? kPdfAndImageExtensions,
        allowMultiple: false,
        withData: false, // true if you need file.bytes
      );

      if (result != null && result.files.isNotEmpty) {
        return result.files.single.path;
      }
    } catch (e) {
      // Ideally log error using logger or crashlytics
      if (kDebugMode) {
        print('File picking error: $e');
      }
    }
    return null;
  }
}
