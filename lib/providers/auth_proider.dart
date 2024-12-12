

import 'package:expense_tracker_2/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StreamProvider.autoDispose<AppUser?>((ref) async*{
  //from Firebase
  final Stream<AppUser?> userStream = FirebaseAuth.instance.authStateChanges().map((user) {
    if(user != null){
      return AppUser(email: user.email!, uid: user.uid);
    }return null;
  },);
  //providing listeners
  await for(final user in userStream){
    yield user;
  }
},);