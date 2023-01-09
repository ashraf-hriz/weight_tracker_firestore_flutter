
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class WeightModel extends Equatable{
  String? title;
  String? id;
  var createdAt;

  WeightModel({this.title,this.createdAt,this.id});

  factory WeightModel.fromJson(Map<String,dynamic> json){
    return WeightModel(title: json['title'] as String,createdAt: json['createdAt'] as Timestamp);
  }

  Map<String, Object> toJson() {
    return {
      'title': title!,
      'createdAt': createdAt,
    };
  }

  factory WeightModel.fromSnapshot(DocumentSnapshot snap) {
    Map<String,dynamic> map = snap.data() as Map<String,dynamic>;
    print('map $map');
    return WeightModel(
      title: map['title'],
      id: snap.id,
      createdAt: map['createdAt'],
    );
  }
  Map<String,dynamic> toDocument(){
    return {
      'title': title,
      'createdAt': createdAt,
    };
  }
  @override
  // TODO: implement props
  List<Object?> get props => [title,createdAt,id];

}