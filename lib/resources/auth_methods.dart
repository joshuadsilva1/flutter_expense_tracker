

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authChanges => _auth.authStateChanges();
  User get user => _auth.currentUser!;

  Future<bool> signInWithGoogle(BuildContext context) async {
    bool res = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      User? user = userCredential.user;

      

      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await _firestore.collection('users').doc(user.uid).set({
            'username': user.displayName,
            'uid': user.uid,
            'profilePhoto': user.photoURL,
           'isAdmin': user.email == 'joshua.dsilva134@nmims.edu.in', 
          });
        }

        if (user.email == 'joshua.dsilva134@nmims.edu.in') {
          Navigator.pushNamed(context, '/admin-screen'); 
        }
         bool isAdmin = await checkIfUserIsAdmin(user.uid);

      if (isAdmin) {

      }else{

        res = true;
      }

        
        
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
      res = false;
    }
    return res;
  }

  Future<bool> checkIfUserIsAdmin(String uid) async {
  DocumentSnapshot doc =
      await _firestore.collection('users').doc(uid).get();
  return doc.exists && doc['isAdmin'] == true;
}

Future<void> assignAdminByEmail(String? email) async {
  QuerySnapshot querySnapshot = await _firestore
      .collection('users')
      .where('email', isEqualTo: email)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    String uid = querySnapshot.docs.first.id;
    await _firestore.collection('users').doc(uid).update({
      'isAdmin': true,
    });
  }
}

}