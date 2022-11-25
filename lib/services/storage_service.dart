import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final userReference =
    FirebaseStorage.instance.ref().child(credentialUser!.uid.toString());
User? credentialUser = FirebaseAuth.instance.currentUser;

class StorageService {
  static Future<List<FileDataModel>> getData() async {
    var files = await userReference.list(const ListOptions(maxResults: 5));
    var res = <FileDataModel>[];

    for (var item in files.items) {
      var content = await item.getData();
      var created = (await item.getMetadata()).timeCreated!;

      res.add(FileDataModel(content!, item.name, created, item));
    }
    print('logme res $res');
    return res;
  }

  static Future deleteItem(Reference ref) async {
    print('logme ref $ref');
    await ref.delete();
  }

  static UploadTask uploadItem(File file, String targetName) {
    var child = userReference.child(targetName);

    // With the UploadTask object you can listen to progress changes and control
    // the upload
    return child.putFile(file);
  }
}

class FileDataModel {
  final Uint8List content;
  final String name;
  final DateTime uploadDate;
  final Reference reference;

  FileDataModel(this.content, this.name, this.uploadDate, this.reference);
}
