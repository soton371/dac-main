import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class PdfViewPage extends StatelessWidget {
  final String source; // URL or local path
  final bool isFromUrl;

  const PdfViewPage({
    super.key,
    required this.source,
    this.isFromUrl = false,
  });

  Future<File> _downloadAndSavePdf(String url) async {
    final response = await http.get(Uri.parse(url));
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/temp.pdf');
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PDF Viewer")),
      body: isFromUrl
          ? FutureBuilder<File>(
              future: _downloadAndSavePdf(source),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError || snapshot.data == null) {
                  return const Center(child: Text("Failed to load PDF"));
                } else {
                  return SfPdfViewer.file(snapshot.data!);
                }
              },
            )
          : SfPdfViewer.file(File(source)),
    );
  }
}


/*
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const PdfViewPage(
      source: 'https://example.com/sample.pdf',
      isFromUrl: true,
    ),
  ),
);


Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const PdfViewPage(
      source: '/storage/emulated/0/Download/sample.pdf',
      isFromUrl: false,
    ),
  ),
);

*/