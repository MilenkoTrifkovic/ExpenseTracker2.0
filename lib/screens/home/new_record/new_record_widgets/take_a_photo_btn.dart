import 'dart:io';

import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:expense_tracker_2/models/record.dart';
import 'package:expense_tracker_2/screens/home/new_record/providers/new_record_providers.dart';
import 'package:expense_tracker_2/services/cloud_functions_services/gemini_cloud_function_service.dart';
import 'package:expense_tracker_2/services/firebase_services/firebase_storage_services.dart';
import 'package:expense_tracker_2/utils/show_error_snack_bar_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ScanReceiptBtn extends ConsumerStatefulWidget {
  const ScanReceiptBtn({
    super.key,
  });

  @override
  ConsumerState<ScanReceiptBtn> createState() => _TakeAPhotoBtnState();
}

class _TakeAPhotoBtnState extends ConsumerState<ScanReceiptBtn> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Controls a circular progress indicator while loading
    //Circular progress indicator is shown when the value is true
    final loadingNotifier = ref.watch(newRecordLoadingStatusProvider.notifier);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondaryAccent,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(15),
      ),
      onPressed: () async {
        loadingNotifier.changeLoadingStatus(true);
        await _pickImage(ImageSource.camera);
        if (_image != null) {
          FirebaseStorageService firebaseStorage = FirebaseStorageService();
          try {
            // Uploads the image to Firebase Storage
            // and gets the download URL
            final String gsutilURL =
                await firebaseStorage.uploadRecieptToCloudStorage(_image!);
            // Passes the URL to the Gemini AI function
            // to extract the record details
            final extractedData =
                await GeminiServices.extractRecordFromReciept(gsutilURL);
            final TransactionRecord extractedRecord =
                extractedData as TransactionRecord;
            // Updates the new record providers with the extracted data
            ref
                .read(newRecordDescriptionProvider.notifier)
                .changeDescription(extractedRecord.description);
            ref
                .read(newRecordTotalAmountProvider.notifier)
                .setTotalAmount(extractedRecord.price);
            ref
                .read(newRecordSelectedDateProvider.notifier)
                .changeDateAndTime(extractedRecord.date);
                //Hides the loading indicator
            loadingNotifier.changeLoadingStatus(false);
          } catch (e) {
            // ignore: use_build_context_synchronously
            showErrorSnackBar(context, "Could't process the image. Try again");
          }
        }
      },
      child: Icon(
        Icons.photo_camera,
        color: AppColors.textColor,
      ),
    );
  }
}
