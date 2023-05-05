class DocumentVerification {
  bool? verification;
  String? verificationMessage;
  Document? document;

  DocumentVerification({this.verification, this.verificationMessage, this.document});

  DocumentVerification.fromJson(Map<String, dynamic> json) {
    verification = json['Verification'];
    verificationMessage = json['VerificationMessage'];
    document = json['Document'] != null ? new Document.fromJson(json['Document']) : Document();
  }
}

class Document {
  String? documentID;
  String? studentFullName;
  String? documentName;
  String? documentPdfUrl;
  String? documentCreateDate;
  bool? documentStatus;

  Document(
      {this.documentID,
      this.studentFullName,
      this.documentName,
      this.documentPdfUrl,
      this.documentCreateDate,
      this.documentStatus});

  Document.fromJson(Map<String, dynamic> json) {
    documentID = json['DocumentID'];
    studentFullName = json['StudentFullName'];
    documentName = json['DocumentName'];
    documentPdfUrl = json['DocumentPdfUrl'];
    documentCreateDate = json['DocumentCreateDate'];
    documentStatus = json['DocumentStatus'];
  }
}
