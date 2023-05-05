import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import './fetchservice/DocumentVerification.dart';

class VerificationResponse extends StatefulWidget {
  final String verificationCode;
  VerificationResponse({super.key, required this.verificationCode});

  @override
  State<VerificationResponse> createState() => _VerificationResponseState();
}

class _VerificationResponseState extends State<VerificationResponse> {
  Future<DocumentVerification?> fetchDocumentVerification(String documentCode) async {
    final response = await http.get(Uri.parse(
        'https://bysdemo.aymodamobilya.com/api/DocumentVerification?Code=${documentCode}'));
    if (response.statusCode == 200) {
      return DocumentVerification.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load document verification');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Sorgulama Sonucu"),
        ),
        body: FutureBuilder<DocumentVerification?>(
          future: fetchDocumentVerification(widget.verificationCode),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final documentVerification = snapshot.data!;
              final document = documentVerification.document!;

              if (documentVerification.verification! == true) {
                return verified(context, documentVerification);
              } else {
                return notVerified(documentVerification.verificationMessage!);
              }
            } else if (snapshot.hasError) {
              return notVerified("Bir sorun oluştu");
            } else {
              return _documentVerificationLoading();
            }
          },
        ));
  }

  Padding notVerified(String errorMessage) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[300],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                errorMessage,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              Lottie.asset("assets/lottie/lottie_notVerified.json", height: 80, repeat: true)
            ],
          ),
        ),
      ),
    );
  }

  Column verified(BuildContext context, DocumentVerification documentVerification) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[300],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  documentVerification.verificationMessage!,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23),
                ),
                Lottie.asset("assets/lottie/lottie_verified.json", height: 100, repeat: false)
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[300],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Text(
                "Belge Bilgileri",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: 15,
              ),
              Wrap(
                spacing: 150,
                runSpacing: 15,
                children: [
                  Text(
                    "Belge Sahibi        : ${documentVerification.document!.studentFullName}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    "Belge Adı             :  ${documentVerification.document!.documentName}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    "Oluşturma Tarihi :  ${documentVerification.document!.documentCreateDate}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Bu belge Yozgat Bozok Üniversitesi tarafından verilmiştir ve onaylanmıştır. ",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 15),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Container _documentVerificationLoading() {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Lottie.asset("assets/lottie/lottie_search_document.json"),
      ),
    );
  }
}
