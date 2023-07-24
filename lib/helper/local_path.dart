import 'package:path_provider/path_provider.dart';

Future<String> appStoragePath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}
