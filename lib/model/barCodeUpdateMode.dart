class BarCodeUpdateModel {
  bool? codeStatus;
  String? message;

  BarCodeUpdateModel({this.codeStatus, this.message});

  BarCodeUpdateModel.fromJson(Map<String, dynamic> json) {
    codeStatus = json['code_status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code_status'] = this.codeStatus;
    data['message'] = this.message;
    return data;
  }
}
