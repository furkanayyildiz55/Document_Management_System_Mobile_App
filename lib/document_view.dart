import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class DocumentView extends StatelessWidget {
  final PDFUrl;
  const DocumentView({super.key, required this.PDFUrl});

  @override
  Widget build(BuildContext context) {
    String server = "https://bys.furkanayyildiz.net/";
    return Scaffold(
      appBar: AppBar(
        title: Text("Belge Görüntüleme"),
        centerTitle: true,
      ),
      body: const PDF(
        //error işlemi yap
        swipeHorizontal: true,
      ).cachedFromUrl(server + PDFUrl),
    );
  }
}
