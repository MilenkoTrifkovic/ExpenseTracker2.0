import 'dart:io';

import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:expense_tracker_2/models/record.dart';
import 'package:expense_tracker_2/screens/home/new_record/providers/new_record_providers.dart';
import 'package:expense_tracker_2/services/cloud_functions_services/gemini_cloud_function_service.dart';
import 'package:expense_tracker_2/services/firebase_services/firebase_storage_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class TakeAPhotoBtn extends ConsumerStatefulWidget {
  final void Function(String) setDescription;
  // final void Function(double) setTotalAmount;
  final void Function(DateTime) setDate;
  final void Function(bool) changeLoadingStatus;
  const TakeAPhotoBtn(
      {super.key,
      required this.setDescription,
      // required this.setTotalAmount,
      required this.setDate,
      required this.changeLoadingStatus});

  @override
  ConsumerState<TakeAPhotoBtn> createState() => _TakeAPhotoBtnState();
}

class _TakeAPhotoBtnState extends ConsumerState<TakeAPhotoBtn> {
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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondaryAccent,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(15),
      ),
      onPressed: () async {
        widget.changeLoadingStatus(true);
        await _pickImage(ImageSource.camera);
        if (_image != null) {
          FirebaseStorageService firebaseStorage = FirebaseStorageService();
          try {
            final String gsutilURL =
                await firebaseStorage.uploadRecieptToCloudStorage(_image!);
            final extractedData =
                await GeminiServices.extractRecordFromReciept(gsutilURL);
            final TransactionRecord extractedRecord =
                extractedData as TransactionRecord;
            widget.setDescription(extractedRecord.description);
            ref.read(totalAmountProvider.notifier).setTotalAmount(extractedRecord.price);
            // widget.setTotalAmount(extractedRecord.price);
            widget.setDate(extractedRecord.date);
            widget.changeLoadingStatus(false);
          } catch (e) {
            //try again code goes here
            print("Error uploading image: $e");
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
