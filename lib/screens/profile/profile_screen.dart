import 'package:expense_tracker_2/models/account_info.dart';
import 'package:expense_tracker_2/screens/profile/widgets/profile_form.dart';
import 'package:expense_tracker_2/services/backend_service.dart';
import 'package:expense_tracker_2/widgets/styled_widgets/styled_text.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> textController = {
    'firstName': TextEditingController(),
    'lastName': TextEditingController(),
    'yearOfBirth': TextEditingController(),
    'adress': TextEditingController(),
    'phoneNumber': TextEditingController(),
  };
  // final ImageUploadService _imageUploadService =  ImageUploadService();

  @override
  void dispose() {
    textController.forEach(
      (key, value) {
        value.dispose();
      },
    );
    super.dispose();
  }

  late final dataIsEntered;
  @override
  void initState() {
    super.initState();
    dataIsEntered = BackendService.checkUserInfo();
  }

  // File? image;
  // Future pickImage(ImageSource source) async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (image == null) return;
  //     final imageTemp = File(image.path);
  //     setState(() => this.image = imageTemp);
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, //prevents the keyboard overflow error
        body: SingleChildScrollView(
          child: Center(
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const StyledHeading('User Info:'),
            FutureBuilder<AccountInfo?>(
                future: dataIsEntered,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text(
                            'Error loading data ${snapshot.data.toString()}'));
                  } else if (!snapshot.hasData) {
                    return ProfileForm(
                      formKey: _formKey,
                      enableTextFormFields: true,
                    );
                  } else {
                    // Now passing snapshot.data which is of type AccountInfo?
                    return ProfileForm(
                      formKey: _formKey,
                      enableTextFormFields: false,
                      accountInfo: snapshot.data!,
                    );
                  }
                }),
            // const MaterialButton(
            //     color: Colors.blue,
            //     child: const Text("Pick Image from Gallery",
            //         style: TextStyle(
            //             color: Colors.white70, fontWeight: FontWeight.bold)),
            //     onPressed: () {
            //       pickImage(ImageSource.gallery);
            //     }),
            // const MaterialButton(
            //     color: Colors.blue,
            //     child: const Text("Pick Image from Camera",
            //         style: TextStyle(
            //             color: Colors.white70, fontWeight: FontWeight.bold)),
            //     onPressed: () {
            //       pickImage(ImageSource.camera);
            //       _imageUploadService.uploadProfileImage('imagePath', 'dsadass');
            //     }),
          ],
                ),
              ),
        ));
  }
}
