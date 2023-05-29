import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<void> saveAndLaunchFile(List<int> bytes, String filename) async {
  Directory? directory = (await getExternalStorageDirectory());
  //Get directory path
  String path = directory!.path;
  // final path = (await getExternalStorageDirectory()).path;
  final file = File('$path/$filename');
  await file.writeAsBytes(bytes, flush: true);

  print(directory);
  OpenFile.open('$path');
}
