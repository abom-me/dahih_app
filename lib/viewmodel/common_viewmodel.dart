// import 'dart:io';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// final commonViewModelProvider =
// Provider<CommonViewModel>((ref) {
//   return CommonViewModel(
//     firebaseStorage: FirebaseStorage.instance,
//   );
// });
// class CommonViewModel {
//   final FirebaseStorage firebaseStorage;
//
//   CommonViewModel({required this.firebaseStorage});
//
//   Future<String> storeFileToFirebase(String ref, File file) async {
//     UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
//     TaskSnapshot taskSnapshot = await uploadTask;
//     return await taskSnapshot.ref.getDownloadURL();
//   }
// }
