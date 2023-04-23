import 'package:flutter/foundation.dart';

String daysFromDatetimeToNow(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);
  final days = difference.inDays;
  return '${days}d';
}

void printDebug(Object object) {
  if (kDebugMode) {
    print(object);
  }
}
