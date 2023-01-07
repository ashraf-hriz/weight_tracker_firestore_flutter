
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class WeightModel extends Equatable{
  String? weight;
  String? id;
  var createdAt;

  WeightModel({this.weight,this.createdAt,this.id});

  factory WeightModel.fromJson(Map<String,dynamic> json){
    return WeightModel(weight: json['weight'] as String,createdAt: json['createdAt'] as Timestamp);
  }

  Map<String, Object> toJson() {
    return {
      'weight': weight!,
      'createdAt': createdAt,
    };
  }

  WeightModel fromSnapshot(DocumentSnapshot snap) {
    Map<String,dynamic> map = snap.data() as Map<String,dynamic>;
    return WeightModel(
      weight: map['weight'],
      id: snap.id,
      createdAt: map['createdAt']
    );
  }
  Map<String,dynamic> toDocument(){
    return {
      'weight': weight,
      'createdAt': createdAt,
    };
  }
  @override
  // TODO: implement props
  List<Object?> get props => [weight,createdAt,id];

}