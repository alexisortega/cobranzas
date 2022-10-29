import 'package:cobranzas/repository/Exception/signup_email_paswword_failure.dart';
import 'package:cobranzas/ui/onboarding_screen.dart';
import 'package:cobranzas/ui/root_page.dart';
import 'package:cobranzas/ui/screens/home_page.dart';
import 'package:cobranzas/ui/screens/widgets/signin_page.dart';
import 'package:cobranzas/ui/screens/widgets/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ignore: camel_case_types
class authenticationRepository extends GetxController {
  static authenticationRepository get instance => Get.find();

  final _auth1 = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser1;
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  void onReady() {
    firebaseUser1 = Rx<User?>(_auth1.currentUser);
    firebaseUser1.bindStream(_auth1.userChanges());

    ever(firebaseUser1, _setInitialScreen);
  }

  _setInitialScreen(User? user1) {
    user1 != null
        ? Get.offAll(() => const RootPage())
        : Get.offAll(() => const OnboardingScreen());
  }

  Future<void> createUserWithEmailAndPassword1(
      String email, String password) async {
    try {
      await _auth1.createUserWithEmailAndPassword(
          email: email, password: password);

      firebaseUser1.value != null
          ? Get.offAll(() => const RootPage())
          : Get.to(() => SignUp());
    } on FirebaseAuthException catch (e) {
      final ex = signUpWithEmailAndPasswordFailure.code(e.code);

      // ignore: avoid_print
      print("'''FIREBASE AUTH EXCEPTION'''-${ex.message1}");
    } catch (_) {}
  }

  Future<void> loginWithEmailAndPassword1(String email, String password) async {
    try {
      await _auth1.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print("'''FIREBASE AUTH EXCEPTION 2'''-${e.code}");
    } catch (_) {}
  }

  // ignore: non_constant_identifier_names
  // Future<void> LogoOut() async => await _auth1.signOut();

  LogoOut() async {
    FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
   // setState(() {});
  }

  void EnviarLinkResetContrasena(String trim) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;

      await auth.sendPasswordResetEmail(email: trim);
    } catch (e) {
      print("Error " + e.toString());
    }
  }

  HandleAuthState() async {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return const SignIn();
          }
        });
  }

  SignInWithGoogle() async {
    final GoogleSignInAccount? googleUser1 =
        await GoogleSignIn(scopes: <String>["email"]).signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser1!.authentication;

    final Credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    return await FirebaseAuth.instance.signInWithCredential(Credential);
  }

  static Future<User?> SignInWithGoogle2(
      {required BuildContext context}) async {
    FirebaseAuth auth2 = FirebaseAuth.instance;
    User? user2;
    GoogleSignIn objGoogleSign = GoogleSignIn();
    GoogleSignInAccount? objGoogleSignInAccount = await objGoogleSign.signIn();

    if (objGoogleSignInAccount != null) {
      GoogleSignInAuthentication objGoogleSignInAuthentication =
          await objGoogleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: objGoogleSignInAuthentication.accessToken,
          idToken: objGoogleSignInAuthentication.idToken);

      try {
        UserCredential userCredential =
            await await FirebaseAuth.instance.signInWithCredential(credential);

        user2 = userCredential.user;
        return user2;
      } on FirebaseAuthException catch (e) {
        print("Error en la autentificacion ${e.hashCode.toString()}");
      }
    }
  }

  void setState(Null Function() param0) {}

}
