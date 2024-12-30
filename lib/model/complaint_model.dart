class ComplaintType {
  final int id;
  final String complainType;

  ComplaintType({required this.id, required this.complainType});

  @override
  String toString() {
    return complainType;
  }
}
