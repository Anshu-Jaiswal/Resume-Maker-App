import 'package:pdf/widgets.dart';

extension TemplateUIExt on Widget {
  Widget padding({double left: 0, double top: 0, double right: 0, double bottom: 0}) {
    return Padding(padding: EdgeInsets.fromLTRB(left, top, right, bottom), child: this);
  }
}

extension DateTimeFormatter on DateTime {
  static const _monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

  String get fmtYYYY => "${this.year}";
  String get fmtMYYYY => "${_monthNames[this.month - 1]}, ${this.year}";
}
