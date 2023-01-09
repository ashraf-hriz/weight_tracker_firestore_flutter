import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weight_tracher_task/core/error/failures.dart';
import 'package:weight_tracher_task/models/weight_model.dart';
abstract class WeightRepository {

  Future<Either<Failure,Unit>> addNewWeight(String title);
  Future<Either<Failure,Unit>> deleteWeight(String id);
  Future<Either<Failure,Unit>> editWeight(String id,String title);
  Either<Failure,Stream<List<WeightModel>>> weights();
}
class WeightRepositoryImpl extends WeightRepository {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var weightCollection = FirebaseFirestore.instance.collection("user");

  @override
  Future<Either<Failure,Unit>> addNewWeight(String title) async {
     try {
       await weightCollection
          .doc(firebaseAuth.currentUser!.uid)
          .collection('Weight')
          .add({
        "title": title,
        "createdAt": FieldValue.serverTimestamp(),
           });
       return const Right(unit);
     } catch (e) {
       return Left(ServerFailure(message: e.toString()));
     }
  }

  @override
  Future<Either<Failure,Unit>> deleteWeight(String id) {
    // TODO: implement deleteWeight
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure,Unit>> editWeight(String id, String title) {
    // TODO: implement editWeight
    throw UnimplementedError();
  }

  @override
  Either<Failure,Stream<List<WeightModel>>> weights() {

    try {
      var weights =  weightCollection.doc(firebaseAuth.currentUser!.uid)
          .collection('Weight').orderBy('createdAt',descending: true).snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) => WeightModel.fromSnapshot(doc))
            .toList();
      });
      return Right(weights);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
