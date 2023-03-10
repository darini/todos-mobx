import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todos_mobx/user.dart';

class LoginController {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future login() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth!.idToken, accessToken: googleAuth.accessToken);

    final User? firebaseUser =
        (await _firebaseAuth.signInWithCredential(credential)).user;

    var tokenResult = await firebaseUser!.getIdToken();

    user.name = firebaseUser.displayName;
    user.email = firebaseUser.email;
    user.picture = firebaseUser.photoURL;
    user.token = tokenResult;
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
    user = IUser();
  }
}
