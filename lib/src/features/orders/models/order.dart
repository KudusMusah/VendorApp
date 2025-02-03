class MyOrderItem {
  final String id;
  final String status;
  final String created;
  final String updated;
  MyOrderItem({
    required this.id,
    required this.status,
    required this.created,
    required this.updated,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'status': status,
      'created': created,
      'updated': updated,
    };
  }

  factory MyOrderItem.fromJson(Map<String, dynamic> map) {
    return MyOrderItem(
      id: map['_id'] as String,
      status: map['status'] as String,
      created: map['createdAt'] as String,
      updated: map['updatedAt'] as String,
    );
  }
}
