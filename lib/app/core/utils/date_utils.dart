import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeFormat on DateTime? {
  String get dateFormat {
    if (this == null) {
      return '';
    } else {
      return DateFormat('yyyy-MM-dd').format(this!);
    }
  }

  String get onlyDateFormat {
    if (this == null) {
      return '';
    } else {
      return DateFormat('MM-dd').format(this!);
    }
  }

  String get timeFormat {
    if (this == null) {
      return '';
    } else {
      return DateFormat.Hm().format(this!);
    }
  }

  String get weekdayFormat {
    if (this == null) {
      return '';
    } else {
      return DateFormat.EEEE('zh_TW').format(this!);
    }
  }

  /// 純 Dart 實作的星期標籤（如「星期四」），不依賴 intl locale 初始化。
  String get weekdayLabel {
    if (this == null) {
      return '';
    } else {
      const weekdays = ['一', '二', '三', '四', '五', '六', '日'];
      return '星期${weekdays[this!.weekday - 1]}';
    }
  }

  DateTime get getDate {
    if (this == null) {
      return DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
    } else {
      return DateTime(this!.year, this!.month, this!.day);
    }
  }

  TimeOfDay get timeOfDay {
    if (this == null) {
      return const TimeOfDay(hour: 0, minute: 0);
    } else {
      return TimeOfDay(hour: this?.hour ?? 0, minute: this?.minute ?? 0);
    }
  }

  DateTime setTimeOfDay(TimeOfDay time) {
    return DateTime(
        this?.year ?? DateTime.now().year,
        this?.month ?? DateTime.now().month,
        this?.day ?? DateTime.now().day,
        time.hour,
        time.minute);
  }
}
