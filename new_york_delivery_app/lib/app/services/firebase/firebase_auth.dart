import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<FirebaseApp> initializeFirebase() async {
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  return firebaseApp;
}

Future initializationFirebase() async {
  try {
    await initializeFirebase();
  } catch (e) {
    print("Error on firebase initialization, please try it later");
    print(e);
  }
}

Future<User?> signInUsingEmailPassword({
  required String email,
  required String password,
  required BuildContext context,
}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  try {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = userCredential.user;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided.');
    }
  }

  return user;
}

Future<User?> registerUsingEmailPassword({
  // required String name,
  required String email,
  required String password,
}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = userCredential.user;
    user = auth.currentUser;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }

  await user?.sendEmailVerification();
  return user;
}

Future<void> sendPasswordResetEmail(String email) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  return auth.sendPasswordResetEmail(email: email);
}

void changePassword(String newPassword) async {
  var user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    try {
      await user.updatePassword(newPassword);
    } catch (e) {
      print(e);
      print("Error on Firebase, please try later");
    }
  }
}

void changeImageProfile(String newPhotoURL) async {
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    await user.updatePhotoURL(newPhotoURL);
  }
}

Future<User?> initializeFirebaseLogin() async {
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return user;
  }
  return null;
}

Future<UserCredential> signInWithGoogle() async {
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

//Facebook
Future<UserCredential> signInWithFacebook() async {
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  // Trigger the sign-in flow
  final LoginResult loginResult = await FacebookAuth.instance.login();

  // Create a credential from the access token
  final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(loginResult.accessToken!.token);

  // Once signed in, return the UserCredential
  return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
}


void signOut() async {
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    await FirebaseAuth.instance.signOut();
  }
}