import 'package:berkania/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  Future<void> forgetPassword({required String email}) async {
    return await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // - - - - - - - - - - - - - - - - - - OVERRIDE LOGIN WITH GOOGLE METHODE - - - - - - - - - - - - - - - - - -  //
  @override
  Future<UserCredential> loginWithGoogle() async{
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
