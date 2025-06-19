import 'package:carta_digital/models/usuario_model.dart';
import 'package:carta_digital/services/servicio_google_sheets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ServicioAutenticacion {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firestore;
  final UserSheetApi _sheetApi;

  
  ServicioAutenticacion()
      : _auth = FirebaseAuth.instance,
        _googleSignIn = GoogleSignIn(
          clientId: kIsWeb  //se le asigna el id del cliente solo si se corre en web
              ? '512119346213-u3v4jiqkpjb50icjsmqmb49jf8lrin6q.apps.googleusercontent.com' //identificador de la aplicacion
              : null,
        ),
        _firestore = FirebaseFirestore.instance,
        _sheetApi = UserSheetApi.getinstance();

  
  Future<User?> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();  
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication; //Obtiene las credenciales 
      final credential = GoogleAuthProvider.credential( //crea las credenciales en firebase
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final userCredential = await _auth.signInWithCredential(credential); //Usa las credenciales para para iniciar sesion
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

      final usuario = {    //Usa un modelo de usuario que luego verifica si esta presente en la planilla de googlesheet
        ModeloUsuario.nombre: user.uid,
        ModeloUsuario.correoelectronico: user.email,
      };
      final primeracolumna = await _sheetApi.getFirstColumn(); //Pide la primer columna de la planilla
      final esta = primeracolumna.contains(user.uid); //Compara las uid de la planilla con la del usuario
      if (!esta) {     // Si no esta se agrega al usuario a la planilla
        await _sheetApi.insert([usuario]);
      }

      return user;
    } catch (e) {
      print('Error al iniciar sesión con Google: $e');
      return null;
    }
  }

  Future<void> signOut() async { //S
    await _googleSignIn.signOut(); //cierra sesion en google
    await _auth.signOut();  //cierra sesion en firebase
  }

  User? get currentUser => _auth.currentUser; //Devuleve el usuario que esta autenticado si es que hay uno
}
