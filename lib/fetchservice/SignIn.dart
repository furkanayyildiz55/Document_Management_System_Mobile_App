class SignIn {
  bool? signIn;
  String? signInError;
  Student? student;

  SignIn({this.signIn, this.signInError, this.student});

  SignIn.fromJson(Map<String, dynamic> json) {
    signIn = json['SignIn'];
    signInError = json['SignInError'];
    student = json['Student'] != null ? new Student.fromJson(json['Student']) : Student();
  }
}

class Student {
  int? studentID;
  String? studentName;
  String? studentSurname;
  String? studentPassword;
  String? studentMail;
  bool? studentUniversityRegistered;
  String? studentNo;
  String? studentProgram;
  Null? documents;

  Student(
      {this.studentID,
      this.studentName,
      this.studentSurname,
      this.studentPassword,
      this.studentMail,
      this.studentUniversityRegistered,
      this.studentNo,
      this.studentProgram,
      this.documents});

  Student.fromJson(Map<String, dynamic> json) {
    studentID = json['StudentID'];
    studentName = json['StudentName'];
    studentSurname = json['StudentSurname'];
    studentPassword = json['StudentPassword'];
    studentMail = json['StudentMail'];
    studentUniversityRegistered = json['StudentUniversityRegistered'];
    studentNo = json['StudentNo'];
    studentProgram = json['StudentProgram'];
    documents = json['Documents'];
  }
}
