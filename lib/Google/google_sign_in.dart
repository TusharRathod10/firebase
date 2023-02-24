import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleData extends StatefulWidget {
  const GoogleData({Key? key}) : super(key: key);

  @override
  State<GoogleData> createState() => _GoogleDataState();
}

class _GoogleDataState extends State<GoogleData> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                try {
                  GoogleSignIn googleSignIn = GoogleSignIn();

                  GoogleSignInAccount? account = await googleSignIn.signIn();

                  GoogleSignInAuthentication authProvider =
                      await account!.authentication;

                  var credentialProvider = GoogleAuthProvider.credential(
                    accessToken: authProvider.accessToken,
                    idToken: authProvider.idToken,
                  );
                  var userCredentials =
                      await auth.signInWithCredential(credentialProvider);

                  print("User: " + '${userCredentials.user!.displayName}');
                } on FirebaseAuthException catch (e) {
                  print('ERROR ${e.message}');
                }
              },
              child: Image.asset(
                "assets/images/google.png",
                height: 50,
                width: 50,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                GoogleSignIn googleSignIn = GoogleSignIn();

                await googleSignIn.signOut();
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
