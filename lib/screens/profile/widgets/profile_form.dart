import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:expense_tracker_2/models/account_info.dart';
import 'package:expense_tracker_2/services/backend_service.dart';
import 'package:expense_tracker_2/widgets/styled_widgets/styled_button.dart';
import 'package:expense_tracker_2/widgets/styled_widgets/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final bool enableTextFormFields;
  final AccountInfo? accountInfo;
  const ProfileForm(
      {super.key,
      required this.formKey,
      required this.enableTextFormFields,
      this.accountInfo});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final Map<String, TextEditingController> textController = {
    'firstName': TextEditingController(),
    'lastName': TextEditingController(),
    'yearOfBirth': TextEditingController(),
    'address': TextEditingController(),
    'phoneNumber': TextEditingController(),
  };
  Map<String, dynamic> placeHolders = {
    'firstName': '',
    'lastName': '',
    'yearOfBirth': '',
    'address': '',
    'phoneNumber': '',
  };
  late bool enableFields;

  @override
  void initState() {
    if (widget.accountInfo != null) {
      placeHolders = {
        'firstName': widget.accountInfo!.firstName,
        'lastName': widget.accountInfo!.lastName,
        'yearOfBirth': widget.accountInfo!.yearOfBirth.toString(),
        'address': widget.accountInfo!.address,
        'phoneNumber': widget.accountInfo!.phoneNumber,
      };
    }
    enableFields = widget.enableTextFormFields;
    super.initState();
  }

  @override
  void dispose() {
    textController.forEach((key, value) => value.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    textController.forEach(
      (key, value) => value.text = placeHolders[key],
    );
    return Form(
      key: widget.formKey,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //NAME
          Padding(
            padding: EdgeInsets.all(screenHeight * 0.01),
            child: SizedBox(
              width: 400,
              child: TextFormField(
                autofocus: true,
                enabled: enableFields,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                ),
                maxLength: 36,
                controller: textController['firstName'],
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
            ),
          ),
          //LAST NAME
          Padding(
            padding: EdgeInsets.all(screenHeight * 0.01),
            child: SizedBox(
              width: 400,
              child: TextFormField(
                enabled: enableFields,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                ),
                maxLength: 36,
                controller: textController['lastName'],
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Last Name';
                  }
                  return null;
                },
              ),
            ),
          ),
          //DATE OF BIRTH
          Padding(
            padding: EdgeInsets.all(screenHeight * 0.01),
            child: SizedBox(
              width: 400,
              child: TextFormField(
                enabled: enableFields,
                decoration: const InputDecoration(
                  labelText: 'Year of birth',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TextInputFormatter.withFunction(
                    (oldValue, newValue) {
                      final regExp = RegExp(r'^\d{1,4}$');

                      // If the new value matches the regex, return the new value, otherwise, return the old value
                      if (newValue.text.isEmpty ||
                          regExp.hasMatch(newValue.text)) {
                        return newValue;
                      } else {
                        return oldValue; // Reject the invalid input
                      }
                    },
                  )
                ],
                maxLength: 36,
                controller: textController['yearOfBirth'],
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      int.parse(value) < 1920 ||
                      int.parse(value) > 2020) {
                    return 'Year of birth is not';
                  }
                  return null;
                },
              ),
            ),
          ),
          //address
          Padding(
            padding: EdgeInsets.all(screenHeight * 0.01),
            child: SizedBox(
              width: 400,
              child: TextFormField(
                enabled: enableFields,
                decoration: const InputDecoration(
                  // labelText: enableFields ? "address" : 'address',
                  labelText: 'Address',
                ),
                maxLength: 36,
                controller: textController['address'],
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
            ),
          ),
          //PHONE NUMBER
          Padding(
            padding: EdgeInsets.all(screenHeight * 0.01),
            child: SizedBox(
              width: 400,
              child: TextFormField(
                enabled: enableFields,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
                maxLength: 36,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: textController['phoneNumber'],
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
            ),
          ),
          //SUBMIT BUTTON
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: StyledButton(
                // disabled: true,
                onPressed: enableFields
                    ? () async {
                        if (widget.formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: StyledText(
                              text: 'Processing Data',
                              textAlignment: TextAlign.center,
                            ),duration: Duration(seconds: 1)),
                          );
                          AccountInfo accountInfo = AccountInfo(
                              firstName: textController['firstName']!.text,
                              lastName: textController['lastName']!.text,
                              yearOfBirth: int.parse(
                                  textController['yearOfBirth']!.text),
                              address: textController['address']!.text,
                              phoneNumber: textController['phoneNumber']!.text);
                          final response =
                              await BackendService.saveUserInfo(accountInfo);
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: StyledText(
                              text: response,
                              textAlignment: TextAlign.center,
                              textColor: AppColors.highlightColor,
                            ), duration: const Duration(seconds: 1),),
                          );
                          setState(() {
                            //Sets submited values as labels
                            placeHolders.forEach(
                              (key, value) =>
                                  placeHolders[key] = textController[key]!.text,
                            );
                            enableFields = false;
                          });
                        } else {}
                      }
                    : () {
                        setState(() {
                          enableFields = true;
                          placeHolders.forEach(
                            (key, value) => textController[key]!.text = value,
                          );
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  content: StyledText(
                            text: 'Editing',
                            textAlignment: TextAlign.center,
                          ),duration: Duration(milliseconds: 500)));
                        });
                      },
                // disabled: true,
                child: enableFields ? const Text("Submit") : const Text("Edit"),
              )),
        ],
      ),
    );
  }
}
