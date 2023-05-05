import 'package:document_management_system/fetchservice/DocumentGet.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class DocumentGetPage extends StatefulWidget {
  final String studentID;
  const DocumentGetPage({super.key, required this.studentID});

  @override
  State<DocumentGetPage> createState() => _DocumentGetPageState();
}

class _DocumentGetPageState extends State<DocumentGetPage> {
  Future<DocumentGet?> fetchDocumentVerification(String documentCode) async {
    final response = await http.get(Uri.parse(
        'https://bysdemo.aymodamobilya.com/api/DocumentVerification?Code=${documentCode}'));
    if (response.statusCode == 200) {
      return DocumentGet.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load document verification');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
