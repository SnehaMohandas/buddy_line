import 'dart:io';
import 'package:buddy_line/consts/image_constants.dart';
import 'package:buddy_line/controller/network_controller.dart';
import 'package:buddy_line/screens/viewer_screen/view_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class ViewerScreen extends StatelessWidget {
  ViewerScreen(
      {super.key,
      required this.myUrl,
      required this.type,
      required this.title,
      required this.share});

  final String myUrl;
  final String type;
  final String title;
  final bool share;

  final NetworkController networkController = Get.find<NetworkController>();

  @override
  Widget build(BuildContext context) {
    print(myUrl);
    return Obx(() {
      if (networkController.isConnected.value == true) {
        final ViewPageController viewPageController =
            Get.put(ViewPageController());
        return Scaffold(
            appBar: AppBar(
              title: Text(title),
              actions: [
                share == true
                    ? IconButton(
                        onPressed: () {
                          if (type == 'Pdf') {
                            _fileFromPdfUrl(myUrl);
                          } else {
                            _fileFromImageUrl(myUrl);
                          }
                        },
                        icon: const Icon(Icons.share),
                      )
                    : const SizedBox(),
              ],
            ),
            body: type == 'Pdf'
                ? SizedBox(
                    // height: 250,
                    width: double.infinity,
                    //color: Colors.yellow,
                    child: SfPdfViewerTheme(
                      data: SfPdfViewerThemeData(
                        backgroundColor: Colors.grey[200],
                      ),
                      child: SfPdfViewer.network(
                        myUrl,
                      ),
                    ),
                  )
                : Stack(
                    children: [
                      WebView(
                          initialUrl: myUrl,
                          javascriptMode: JavascriptMode.disabled,
                          zoomEnabled: true,
                          onPageFinished: (finish) {
                            viewPageController.isLoading.value = false;
                          }),
                      viewPageController.isLoading.value == true
                          ? Center(
                              child: Lottie.asset(AssetImages.loader,
                                  fit: BoxFit.fill),
                            )
                          : const SizedBox()
                    ],
                  ));
      } else {
        return networkController.noDataImage(context);
      }
    });
  }

  Future _fileFromImageUrl(String imageUrl) async {
    print('hello');
    final response = await http.get(Uri.parse(imageUrl));
    final documentDirectory = await getApplicationDocumentsDirectory();
    final file = File(join(documentDirectory.path, 'imagetest.jpg'));
    print('ok');
    file.writeAsBytesSync(response.bodyBytes);
    print('++++++++++++$file');
    await Share.shareFiles(
      [file.path],
    );
  }

  Future _fileFromPdfUrl(String pdfUrl) async {
    print('helllliii');
    final response = await http.get(Uri.parse(pdfUrl));
    final documentDirectory = await getApplicationDocumentsDirectory();
    final file = File(join(documentDirectory.path, 'local.pdf'));
    print('ok');
    file.writeAsBytesSync(response.bodyBytes);
    print('++++++++++++$file');
    await Share.shareFiles(
      [file.path],
    );
  }
}
