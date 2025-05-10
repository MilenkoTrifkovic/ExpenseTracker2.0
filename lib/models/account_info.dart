class AccountInfo {
  AccountInfo(
      {required this.firstName,
      required this.lastName,
      required this.yearOfBirth,
      required this.address,
      required this.phoneNumber});

  final String firstName;
  final String lastName;
  final int yearOfBirth;
  final String address;
  final String phoneNumber;
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'yearOfBirth': yearOfBirth,
      'adress': address,
      'phoneNumber': phoneNumber,
    };
  }
}
