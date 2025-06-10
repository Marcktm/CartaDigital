import 'package:carta_digital/models/usuario_model.dart';
import 'package:carta_digital/services/servicio_google_sheets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';


class ServicioAutenticacion {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
final GoogleSignIn _googleSignIn = GoogleSignIn(
  clientId: kIsWeb
      ? '512119346213-u3v4jiqkpjb50icjsmqmb49jf8lrin6q.apps.googleusercontent.com'
      : null,
);
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

      final usuario = {
        ModeloUsuario.nombre : user.uid,
        ModeloUsuario.correoelectronico : user.email,
      };
      final primeracolumna = await UserSheetApi.getFirstColumn();
      final esta = primeracolumna.contains(user.uid);
      if (!esta){
            await UserSheetApi.insert([usuario]);

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