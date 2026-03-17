import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wai_api/wai_api.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final WaiApi _api;

  AuthRepository({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    WaiApi? api,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.instance,
        _api = api ?? WaiApi();

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Googleログイン → Firebase認証 → バックエンドAPI同期
  Future<User?> signInWithGoogle() async {
    final account = await _googleSignIn.authenticate();
    final idToken = account.authentication.idToken;

    final credential = GoogleAuthProvider.credential(idToken: idToken);
    final userCredential =
        await _firebaseAuth.signInWithCredential(credential);

    // バックエンドAPIにログインを同期
    final firebaseIdToken = await userCredential.user?.getIdToken();
    if (firebaseIdToken != null) {
      _api.setBearerAuth('BearerAuth', firebaseIdToken);
      await _api.getAuthApi().login();
    }

    return userCredential.user;
  }

  Future<void> signOut() async {
    await Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.disconnect(),
    ]);
  }
}
