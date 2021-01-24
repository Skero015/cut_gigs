import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class PdfScreen extends StatelessWidget {

  PDFDocument document;
  bool _isLoading;
  String appBarName;
  PdfScreen(this.document, this._isLoading,this.appBarName);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top:45.0),
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarName, style: TextStyle(fontSize: 22),),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
            SizedBox(width: 20,),
            Padding(
              padding: const EdgeInsets.only(right:5.0),
              child: Image(
                image: AssetImage('images/AppBar.png'),
                fit: BoxFit.cover,
                height: 90.0,
              ),
            ),
          ],
        ),
        body: Center(

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 8,
                child: _isLoading ? CircularProgressIndicator() : PDFViewer(document: document,),
              ),
            ],
          ),

        ),
      ),
    );
  }
}