import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

//dd-MM-yy 12-02-25
String? formatDateTime({dynamic dateTime, String? format}) {
  if (dateTime == null) {
    return null;
  }

  try {
    final dateFormatter = DateFormat(format ?? 'dd MMM yyyy');
    if (dateTime is DateTime) {
      return dateFormatter.format(dateTime.toLocal());
    }

    final DateTime parsedDate = DateTime.parse(dateTime);
    return dateFormatter.format(parsedDate);
  } catch (e) {
    if (kDebugMode) {
      print("object convertDateTime e: $e");
    }
    return null;
  }
}



