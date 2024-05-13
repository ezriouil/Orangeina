import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {

  // - - - - - - - - - - - - - - - - - - REGISTER - - - - - - - - - - - - - - - - - -  //
  Future<UserCredential> register({required String firstName, required String lastName, required String email, required String password, required String confirmPassword});

  // - - - - - - - - - - - - - - - - - - LOGIN - - - - - - - - - - - - - - - - - -  //
  Future<UserCredential> login({required String email, required String password});

  // - - - - - - - - - - - - - - - - - - FORGET PASSWORD - - - - - - - - - - - - - - - - - -  //
  Future<UserCredential> forgetPassword({required String email});

}