import 'package:authentication_repository/src/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/cupertino.dart';
import 'package:cache/cache.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository{
  AuthenticationRepository({CacheClient? cache,
  firebase_auth.FirebaseAuth? firebaseAuth,
  GoogleSignIn? googleSignIn}):_cache = cache?? CacheClient(),
_firebaseAuth ? firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
_googleSignIn =googleSignIn ?? GoogleSignIn.standard();

final CacheClient _cache;
final firebase_auth.FirebaseAuth _firebaseAuth;
final GoogleSignIn _googleSignIn;

@visibleForTesting
static const userCacheKey = '__user_cache_key__';

Stream<User> get user {
  return _firebaseAuth.authStateChanges().map((event) {
final user = event == null ? User.empty : event.toUser;
_cache.write(key:userCacheKey, value:user);
return user;
  });}

User get currentUser{
  return _cache.read<User>(key: userCacheKey)??User.empty;
}


}
extension on firebase_auth.User{
  User get toUser{
    return User(id:uid,email: email,name: displayName);
  }
}