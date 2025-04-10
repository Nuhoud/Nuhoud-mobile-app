import 'dart:developer';
import 'dart:io';
import 'dart:convert';

void main() async {
  final config = jsonDecode(await File('setup.json').readAsString());

  await Process.run(
    'flutter',
    ['pub', 'add', ...List<String>.from(config["packages"])],
    runInShell: true,
  );
  await Process.run(
    'flutter',
    ['pub', 'get'],
    runInShell: true,
  );
  log('✅ Project setup completed!');
}
