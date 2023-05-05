class DocumentGet {
  bool? status;
  String? message;
  List<DocumentList>? documentList;

  DocumentGet({this.status, this.message, this.documentList});

  DocumentGet.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    if (json['DocumentList'] != null) {
      documentList = <DocumentList>[];
      json['DocumentList'].forEach((v) {
        documentList!.add(new DocumentList.fromJson(v));
      });
    }
  }
}

class DocumentList {
  String? documentID;
  String? documentName;
  String? documentPdfUrl;
  String? documentCreateDate;
  String? documentVerificationCode;
  bool? documentStatus;

  DocumentList(
      {this.documentID,
      this.documentName,
      this.documentPdfUrl,
      this.documentCreateDate,
      this.documentVerificationCode,
      this.documentStatus});

  DocumentList.fromJson(Map<String, dynamic> json) {
    documentID = json['DocumentID'];
    documentName = json['DocumentName'];
    documentPdfUrl = json['DocumentPdfUrl'];
    documentCreateDate = json['DocumentCreateDate'];
    documentVerificationCode = json['DocumentVerificationCode'];
    documentStatus = json['DocumentStatus'];
  }
}
