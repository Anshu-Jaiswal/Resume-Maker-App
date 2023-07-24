import 'package:pdf/widgets.dart';

import '../info.dart';

abstract class Template {
  void insertPage(Document pdf, Info info);
}
