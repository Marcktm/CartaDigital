import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServicioAutenticacion {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;
      if (user == null) return null;

      // Verificar si el usuario ya existe en Firestore
      final userDoc = await _firestore.collection('usuarios').doc(user.uid).get();

      if (!userDoc.exists) {
        // Registrar usuario por primera vez
        await _firestore.collection('usuarios').doc(user.uid).set({
          'uid': user.uid,
          'nombre': user.displayName,
          'email': user.email,
        });
        print('Usuario registrado en Firestore');
      } else {
        print('Usuario ya existe');
      }

      return user;
    } catch (e) {
      print('Error al iniciar sesión con Google: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}