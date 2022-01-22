import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final FirebaseStorage storage = FirebaseStorage.instance;
final Uuid uuid = Uuid();
// Collection refs
CollectionReference usersRef = FirebaseFirestore.instance.collection('users');
CollectionReference postRef = FirebaseFirestore.instance.collection('posts');
CollectionReference likeRef = FirebaseFirestore.instance.collection('likes');
CollectionReference commentRef =
    FirebaseFirestore.instance.collection('comments');
CollectionReference commentLikeRef =
    FirebaseFirestore.instance.collection('commentLikes');
CollectionReference shareRef = FirebaseFirestore.instance.collection('shares');
CollectionReference followingRef =
    FirebaseFirestore.instance.collection('followings');
CollectionReference followerRef =
    FirebaseFirestore.instance.collection('followers');

// Storage refs
Reference profilePic = FirebaseStorage.instance.ref().child('profilePic');
Reference posts = FirebaseStorage.instance.ref().child('posts');
Reference prevImage = FirebaseStorage.instance.ref().child('previewImage');
