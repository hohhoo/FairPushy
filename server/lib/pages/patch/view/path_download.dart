import 'dart:ffi';
import 'dart:io';

import 'package:HotUpdateService/server/fair_server_download_widget.dart';
import 'package:HotUpdateService/server/src/context/context_request.dart';
import 'package:HotUpdateService/server/fair_server_response.dart';


class DownloadFilePage extends FairDownloadServiceWidget {

  Directory? _fileDirectory = null;

  @override
  Future<String> service(Map? request_params) async {
    try {
      _fileDirectory = await new Directory('file').create(recursive: true);
    } catch (e) {
      print(e);
      return ResponseError(msg: "创建目录失败");
    }

    var fileName = request_params?['fileName'];

    String filePath = '${_fileDirectory!.path}/$fileName';

    return filePath;
  }


  initDirectory() async {
    _fileDirectory = await new Directory('file').create(recursive: true);
  }






}
