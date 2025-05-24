import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareWithFriends extends StatefulWidget {
  const ShareWithFriends({super.key});

  @override
  State<ShareWithFriends> createState() => _ShareWithFriendsState();
}

class _ShareWithFriendsState extends State<ShareWithFriends> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      onPressed: () async {
        try {
          // Step 1: Load the asset image
          final byteData =
              await rootBundle.load('assets/imgs_shared/share_to_friends.jpg');

          // Step 2: Create a temporary file
          final tempDir = await getTemporaryDirectory();
          final tempFile = File('${tempDir.path}/invitation.jpg');
          await tempFile.writeAsBytes(byteData.buffer.asUint8List());

          // Step 3: Share the file using share_plus
          final result = await Share.shareXFiles(
            [
              XFile(tempFile.path),
            ],
            text:
                'Download link #', //download link could be placed here, but it doesn't work with all platforms as expected...
          );

          // Step 4: Check the result
          if (result.status == ShareResultStatus.success) {
            print('Image shared successfully!');
          } else {
            print('Sharing was canceled or failed.');
          }
        } catch (e) {
          print('Error sharing image: $e');
        }
      },
      child: const Icon(Icons.share),
    );
  }
}
