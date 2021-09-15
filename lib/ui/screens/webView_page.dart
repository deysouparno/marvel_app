import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/cubits/web_progress/cubit/progress_cubit.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:marvel_app/cubits/search/search_cubit.dart';

class MyWebView extends StatefulWidget {
  const MyWebView({
    Key? key,
    required this.url,
  }) : super(key: key);
  final String url;

  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  late WebViewController _controller;
  double progress = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _controller.canGoBack()) {
          _controller.goBack();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.url,
            maxLines: 1,
            style: TextStyle(fontSize: 12),
          ),
          leading: IconButton(
              onPressed: () {
                _controller.clearCache();
                CookieManager().clearCookies();
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close)),
          // actions: [
          //   IconButton(
          //       onPressed: () async {
          //         if (await _controller.canGoBack()) {
          //           _controller.goBack();
          //         }
          //       },
          //       icon: Icon(Icons.arrow_back)),
          // ],
        ),
        body: Column(
          children: [
            BlocBuilder<ProgressCubit, ProgressState>(
                builder: (context, state) {
              if (state.val == 1) {
                return SizedBox();
              }
              return LinearProgressIndicator(
                color: Colors.red,
                value: state.val,
                backgroundColor: Colors.black12,
              );
            }),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  // BlocProvider.of<SearchCubit>(context).emitRefreshing();
                  _controller.reload();
                  // BlocProvider.of<SearchCubit>(context).emitNotSearching();
                },
                child: WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: widget.url,
                  onWebViewCreated: (controller) {
                    this._controller = controller;
                  },
                  onWebResourceError: (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Something wrong")));
                  },
                  onProgress: (progress) {
                    BlocProvider.of<ProgressCubit>(context)
                        .emitProgress(progress.toDouble() / 100);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
