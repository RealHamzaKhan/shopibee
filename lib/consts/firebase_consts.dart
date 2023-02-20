import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseAuth auth=FirebaseAuth.instance;
FirebaseFirestore firestore=FirebaseFirestore.instance;
FirebaseStorage storage=FirebaseStorage.instance;
User? user=auth.currentUser;
const usersCollection="users";
const productCollection="products";
const cartCollection="cart";
const chatsCollection="chats";
const messageCollection='messages';
const ordersCollection='orders';