import 'dart:io';

import 'package:HotUpdateService/server/src/context/context_request.dart';
import 'package:HotUpdateService/server/fair_server_response.dart';
import 'package:HotUpdateService/server/fair_server_widget.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;

class UploadFilePage extends FairServiceWidget {
  Directory? _fileDirectory = null;

  @override
  Future<ResponseBaseModel> service(Map? request_params) async {

    try {
      _fileDirectory = await new Directory('file').create(recursive: true);
    } catch (e) {
      print(e);
      return ResponseError(msg: "创建目录失败");
    }

    var fileName = request_params?['fileName'];
    MultipartUpload upload = request_params?['fileContent'];
    String fileExtension = path.extension(fileName);

    var targetFileName = "${Uuid().v4()}$fileExtension";

    try {
      File file = await File('${_fileDirectory!.path}/$targetFileName').create();
      file.writeAsBytesSync(upload.data);
    } catch (e) {
      return ResponseError(msg: "文件写入失败");
    }

    return ResponseSuccess(data: {
      "file": "${targetFileName}",
    });
  }
}
