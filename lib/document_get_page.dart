import 'package:document_management_system/document_view.dart';
import 'package:document_management_system/fetchservice/DocumentGet.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DocumentGetPage extends StatefulWidget {
  final String studentID;
  const DocumentGetPage({super.key, required this.studentID});

  @override
  State<DocumentGetPage> createState() => _DocumentGetPageState();
}

class _DocumentGetPageState extends State<DocumentGetPage> {
  Future<DocumentGet?> fetchDocumentGet(String studentID) async {
    final response = await http
        .get(Uri.parse('https://bysdemo.aymodamobilya.com/api/DocumentApi?StudentID=${studentID}'));
    if (response.statusCode == 200) {
      return DocumentGet.fromJson(json.decode(response.body));
    } else {
      return DocumentGet(status: false, message: "Bir sorun oluştu !", documentList: []);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Belge Listeleme"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: fetchDocumentGet(widget.studentID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final DocumentGet = snapshot.data;
            final DocumentList = DocumentGet?.documentList;

            if (DocumentGet!.status == false) {
              return _error(DocumentGet.message!);
            } else {
              return Column(
                children: [
                  _listMessage(DocumentGet.message!),
                  Expanded(
                    child: ListView.builder(
                      itemCount: DocumentList!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Material(
                            child: InkWell(
                              splashColor: Colors.blue.shade50,
                              onTap: () {
                                print("object");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DocumentView(
                                            PDFUrl: DocumentList[index].documentPdfUrl,
                                          )),
                                );
                              },
                              child: Ink(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text(
                                      "${index + 1}",
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  title: Text(DocumentList[index].documentName!),
                                  subtitle: Text(DocumentList[index].documentCreateDate!),
                                  trailing: const Icon(
                                    Icons.picture_as_pdf,
                                    size: 30,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            }
          } else if (snapshot.hasError) {
            return _error("Bir sorun oluştu !");
          } else {
            return _loading();
          }
        },
      ),
    );
  }

  Widget _listDocument(List<DocumentList> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(list[index].documentName!));
      },
    );
  }

  Widget _listMessage(String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              message,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            Lottie.asset("assets/lottie/lottie_verified.json", height: 50, repeat: false)
          ],
        ),
      ),
    );
  }

  Widget _error(String errorMessage) {
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

  Widget _loading() {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Center(child: Lottie.asset("assets/lottie/lottie_search_document.json")),
      ),
    );
  }
}
