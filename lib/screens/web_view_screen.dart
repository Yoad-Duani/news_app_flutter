import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:news_app/style/theme.dart' as myStyle;

class WebViewScreen extends StatefulWidget {
  final url;
  final title;
  WebViewScreen(this.url, this.title);
  @override
  createState() => _WebViewScreenState(this.url, this.title);
}

class _WebViewScreenState extends State<WebViewScreen> {
  String _url;
  String _tittle;
  final _key = UniqueKey();
  _WebViewScreenState(this._url, this._tittle);
  @override
  Widget build(BuildContext context) {
    var uri = Uri.parse(_url);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myStyle.MyColors.mainColor,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _tittle,
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            SizedBox(height: 3.0),
            Text(
              uri.host.toString(),
              style: TextStyle(color: Colors.white70, fontSize: 13.0),
            )
          ],
        ),
        centerTitle: false,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 3.0),
            child: IconButton(
              onPressed: () {
                // Get.toNamed("/coinDataPage");
              },
              icon: Icon(
                Icons.share,
                size: 22.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: WebView(
              key: _key,
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: _url,
            ),
          ),
        ],
      ),
    );
  }
}
