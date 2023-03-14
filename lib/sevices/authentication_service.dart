import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newsly_app/sevices/data_service.dart';

class AuthenticationService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String? userEmail;
  dynamic errorMessage;

  Future<dynamic> signUpWithEmailAndPassword(email, password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password!,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "unknown":
          errorMessage = "Some fild miss please double check";
          break;
        case "invalid-email":
          errorMessage = "Your email format is not correct please try again";
          break;
        case "weak-password":
          errorMessage = "Password should be greater then 6 digit";
          break;
        case "email-already-in-use":
          errorMessage = "Your email already exist please try another email";
          break;
      }

      return errorMessage;
    } catch (e) {
      print(errorMessage);
      errorMessage = "e $e";
      return errorMessage;
    }
  }

  Future<dynamic> loginAuthentication(email, password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      userCredential.user;
      await DataService.getMyUser();

      errorMessage = "SignUp Success!";
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == "wrong-password") {
        errorMessage = "Your Password is Wrong Please try again";
      } else if (e.code == "user-not-found") {
        errorMessage = "Email not Found Please try again";
      }
      return errorMessage;
    } catch (e) {
      errorMessage = e.toString();

      return errorMessage;
    }
  }

  Future<void> logoutAuthentication() async {
    await firebaseAuth.signOut();
  }

  Future<UserCredential> googleAuthentication() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    userEmail = googleUser.email;
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
