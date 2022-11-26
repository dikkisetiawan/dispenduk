import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dispenduk/models/request_layanan_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RequestLayananService {
  CollectionReference _taskReference =
      FirebaseFirestore.instance.collection('requests');

  User? user = FirebaseAuth.instance.currentUser;

//create
  Future<void> createRequestService(RequestLayananModel request) async {
    try {
      _taskReference.add({
        'uid': user!.uid,
        'status': request.status.name,
        'tanggalPermohonan': request.tanggalPermohonan.toString(),
        'layanan': request.layanan,
        'keterangan': request.keterangan,
      });
    } catch (e) {
      throw e;
    }
  }

//read
  Future<List<RequestLayananModel>> fetchRequestsByCurrentUser() async {
    try {
      QuerySnapshot result = await _taskReference
          .where('uid', isEqualTo: user!.uid)
          .get(); //where uid current user

      List<RequestLayananModel> RequestLayananList = result.docs.map(
        (e) {
          return RequestLayananModel.fromJson(
              e.id, e.data() as Map<String, dynamic>);
        },
      ).toList();

      return RequestLayananList;
    } catch (e) {
      throw e;
    }
  }

//read by taskidd

  //update tasks by id

  //delete

}
