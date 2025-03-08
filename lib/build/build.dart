import 'dart:io';
import 'dart:convert'; // For utf8.decoder

Future<void> buildApkWithMakeFile(String env) async {
  // Validate the environment
  if (!['dev', 'uat', 'prod'].contains(env)) {
    print('Invalid environment: $env. Must be one of: dev, uat, prod');
    return;
  }

  Process.run(
    "make",
    ["build-apk", "env=$env"],
    runInShell: true,
  );
}

Future<void> buildApkWithProcess(String env) async {
  // Validate the environment
  if (!['dev', 'uat', 'prod'].contains(env)) {
    print('Invalid environment: $env. Must be one of: dev, uat, prod');
    return;
  }

  // Construct the base command sequence with set -e to stop on error
  String command = '''
set -e
cd data && flutter clean && flutter pub get && cd ..
cd domain && flutter clean && flutter pub get && cd ..
rm -f pubspec.lock && flutter clean && flutter pub get
cd ios && rm -f Podfile.lock && rm -rf Pods && rm -rf .symlinks && pod install && cd ..
flutter build apk --flavor $env --release
''';

  // Add the app bundle command for prod environment with a newline
  if (env == 'prod') {
    command += '\nflutter build appbundle --flavor $env --release';
  }

  try {
    // Start the process
    print('Starting build for $env...');
    final process = await Process.start('sh', ['-c', command], runInShell: true);

    // Stream stdout and stderr in real-time
    process.stdout.transform(utf8.decoder).listen((data) {
      print(data); // Output from commands
    });
    process.stderr.transform(utf8.decoder).listen((data) {
      print('\x1B[31m$data\x1B[0m'); // Output errors in red (optional)
    });

    // Wait for the process to complete and check the exit code
    final exitCode = await process.exitCode;
    if (exitCode == 0) {
      print('Build completed successfully for $env.');
    } else {
      print('Build failed with exit code $exitCode.');
    }
  } catch (e) {
    print('Failed to start build process: $e');
  }
}
