import 'package:berkania/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl extends AuthRepository {
  // - - - - - - - - - - - - - - - - - - CREATE INSTANCES - - - - - - - - - - - - - - - - - -  //
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // - - - - - - - - - - - - - - - - - - OVERRIDE REGISTER METHODE - - - - - - - - - - - - - - - - - -  //
  @override
  Future<UserCredential> register({ required String email, required String password }) async {

    return await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

  }

  // - - - - - - - - - - - - - - - - - - OVERRIDE LOGIN METHODE - - - - - - - - - - - - - - - - - -  //
  @override
  Future<UserCredential> login({required String email, required String password}) async {
    return await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  // - - - - - - - - - - - - - - - - - - OVERRIDE FORGET PASSWORD METHODE - - - - - - - - - - - - - - - - - -  //
  @override
  Future<UserCredential> forgetPassword({required String email}) async {
    // TODO: implement forgetPassword
    throw UnimplementedError();
  }
}
